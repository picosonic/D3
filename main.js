// Global constants
const xmax=256;
const ymax=192;

const header=40;
const border=8;

const maxroom=100;

// Game state is global to prevent it going out of scope
var gs={
  // animation frame of reference
  step:(1/60), // target step time @ 60 fps
  acc:0, // accumulated time since last frame
  lasttime:0, // time of last frame

  // Canvas objects
  canvas:null,
  ctx:null,

  // Dizzy
  keystate:0, // keyboard bitfield [action][down][right][up][left]
  dizzycanvas:null,
  dizzyctx:null,
  x:124, // x position, from left
  y:154, // y position, from top
  h:0, // current sprite height
  px:0, // previous x position
  py:0, // previous y position
  vs:0, // vertical speed
  hs:0, // horizontal speed
  jump:false, // jumping
  fall:false, // falling
  dir:0, // direction (-1=left, 0=none, 1=right)
  maxvs:1, // max vertical speed
  maxhs:1, // max horizontal speed
  walkspeed:3, // walking speed
  jumpspeed:6, // jumping speed
  sequence:0, // sequence being used for animation
  animation:0, // current frame within sequence
  animdelay:6, // frames until next animation frame

  // physics in pixels per frame @ 60fps
  gravity:0.5,
  terminalvelocity:5,
  friction:1,

  // Room
  room:36,
  newroom:false,
  flames:[], flamerate:4,
  water:[], waterrate:6, waterheight:(0*6),
  solid:[],
  attritable:[],

  heartsetup:false,
  numhearts:16,
  hearttable:[],
  heartsclockwise:true, // rotation direction

  seed:[0x59, 0xa3, 0x13],

  debug:true
};

// Clear both keyboard input state
function clearinputstate()
{
  gs.keystate=0;
}

// Check if an input is set in keyboard input state
function ispressed(keybit)
{
  return ((gs.keystate&keybit)!=0);
}

function drawclippedpixel(ctx, x, y, width, height, clipping)
{
  if ((clipping) && (!((x>=border) && ((x+width)<=(xmax-border))
     && (y>=(header+border)) && ((y+height)<=(ymax-border)))))
    return;

  ctx.fillRect(x, y, width, height);
}

function drawframe(ctx, x, y, framenum, scale, hflip, style, frameplot, clipping)
{
  if ((framenum<0) || (framenum>0xff)) return;

  ctx.save();

  var offs=frametable[framenum];
  var px=0;
  var py=0;
  var fwidth=framedefs[offs++]*4;
  var fheight=framedefs[offs++];

  for (py=0; py<fheight; py++)
  {
    var done=0;

    while ((done*8)<fwidth)
    {
      var mask=0x80;
      var data=framedefs[offs++];

      while (mask>0)
      {
        if ((data&mask)>0)
        {
          ctx.fillStyle=style;
        }
        else
        {
          if (frameplot!=0) // 0=normal, 1=or, 2=xor
            ctx.fillStyle="rgba(0,0,0,0)";
          else
            ctx.fillStyle="#000000";
        }

        if (hflip)
          drawclippedpixel(ctx, Math.floor(x+((fwidth-px-1)*scale)), Math.floor(y+(py*scale)), Math.ceil(scale), Math.ceil(scale), clipping);
        else
          drawclippedpixel(ctx, Math.floor(x+(px*scale)), Math.floor(y+(py*scale)), Math.ceil(scale), Math.ceil(scale), clipping);

        px++;

        mask>>=1;
      }

      done++;
    }

    px=0;
  }

  ctx.restore();
}

function drawdizzy(ctx, x, y, framenum, scale)
{
  if ((framenum<0) || (framenum>=dizzytable.length)) return;

  var offs=dizzytable[framenum];
  var px=0;
  var py=0;
  var fheight=dizzydefs[offs++];
  var fwidth=24;

  gs.h=fheight;

  ctx.save();

  offs++;

  for (py=0; py<fheight; py++)
  {
    var done=0;

    while ((done*8)<fwidth)
    {
      var bitmask=0x80;
      var mask=dizzydefs[offs++];
      var data=dizzydefs[offs++];

      while (bitmask>0)
      {
        if ((mask&bitmask)==0)
        {
          if ((data&bitmask)>0)
            ctx.fillStyle="#ffffff";
          else
            ctx.fillStyle="#000000";
          
          drawclippedpixel(ctx, Math.floor(x+(px*scale)), Math.floor(y+(17-fheight)+(py*scale)), Math.ceil(scale), Math.ceil(scale), true);

        }

        px++;

        bitmask>>=1;
      }

      done++;
    }
    
    px=0;
  }

  // DEBUG
  if (gs.debug)
  {
    ctx.strokeStyle="red";
    ctx.strokeRect(x, y-3, fwidth, fheight);
  }

  ctx.restore();
}

function writestring(ctx, x, y, text, scale, style, clipping)
{
  for (var i=0; i<text.length; i++)
    drawframe(ctx, x+(i*8), y, text.charCodeAt(i), 1, false, style, 0, clipping);
}

function getpalette(framecolour)
{
  var framestyle="#000000";

  switch (framecolour)
  {
    case 0x00: framestyle="#000000"; break;
    case 0x01: framestyle="#0000ff"; break;
    case 0x02: framestyle="#ff0000"; break;
    case 0x03: framestyle="#ff00ff"; break;
    case 0x04: framestyle="#00ff00"; break;
    case 0x05: framestyle="#00ffff"; break;
    case 0x06: framestyle="#ffff00"; break;
    case 0x07: framestyle="#ffffff"; break;
    default: break;
  }

  return framestyle;
}

// At the start of every game reset the objects state/position
function resetobjects()
{
  for (var i=0; i<objects.length; i++)
  {
    objects[i].room=objects[i].origroom;
    objects[i].movex=objects[i].origx;
    objects[i].movey=objects[i].origy;
    objects[i].movefrm=objects[i].origfrm;
    objects[i].var1=0;
    objects[i].delaycounter=0;
  }
}

function setpackedsolidity(fx, fy, fwidth, fheight, solid)
{
  var bwidth=Math.ceil(fwidth/2); // Width in blocks
  var bheight=Math.ceil(fheight/8); // Height in blocks

  var fymin=Math.floor(fy >> 3)-6; // Calculate row
  var fymax=fymin+bheight;

  if (fymin<0) fymin=0; // Clip top
  if (fymax>17) fymax=17; // Clip bottom

  var offset=fymin<<2; // Byte position for start of first row

  var fxmin=Math.floor(((fx&0x7f)-32) >> 1); // Calculate column (bit position (0..31))
  var fxmax=fxmin+bwidth;

  if (fxmin<1) fxmin=1; // Clip left
  if (fxmax>31) fxmax=31; // Clip right

  var bit=(0x80 >> (fxmin & 0x07)); // Starting bit pattern

  for (var y=fymin; y<fymax; y++)
  {
    offset+=Math.floor(fxmin >> 3); // Move to starting byte on this row

    for (var x=fxmin; x<fxmax; x++)
    {
      if (solid)
        gs.attritable[offset]|=bit;
      else
        gs.attritable[offset]&=(bit ^ 0xFF);

      bit=bit>>1; // Move to next bit
      if (bit==0)
      {
        // Move to next byte
        bit=0x80;
        offset++;
      }
    }

    offset=(y+1)<<2; // Move to start of next row down
    bit=(0x80 >> (fxmin & 0x07)); // Starting bit pattern
  }
}

// Mark as solid/notsolid
function setsolidity(fx, fy, fwidth, fheight, solid)
{
  var fxmin=Math.floor(fx/8);
  var fymin=Math.floor(fy/8);
  var fxmax=Math.ceil((fx+fwidth)/8);
  var fymax=Math.ceil((fy+fheight)/8);

  for (var y=fymin; y<fymax; y++)
    for (var x=fxmin; x<fxmax; x++)
      gs.solid[(y*(xmax/8))+x]=solid;
}

// Highlight where the solid blocks are
function highlightsolid()
{
  for (var y=0; y<(ymax/8); y++)
    for (var x=0; x<(xmax/8); x++)
    {
      if (gs.solid[(y*(xmax/8))+x])
      {
        gs.ctx.fillStyle="rgba(255,0,255,0.5)";
        gs.ctx.fillRect(x*8, y*8, 7, 7);
      }
    }
}

// Draw a full room
function drawroom(roomnum)
{
  var ptr=0;

  var framenum=0;
  var framex=0;
  var framey=0;
  var frameattrib=0;
  var framereverse=false;
  var frameplot=0;
  var framecolour=0;
  var framesolid=false;

  gs.water=[];
  gs.flames=[];

  setsolidity(0, 0, xmax, ymax, framesolid);
  setpackedsolidity(32, 6*8, xmax/4, ymax-(7*8), framesolid);

  gs.ctx.fillStyle="#000000";
  gs.ctx.fillRect(border, header+border, xmax-(border*2), ymax-header-(border*2));

  while (ptr<roomtable[roomnum].len)
  {
    framenum=roomdata[roomtable[roomnum].offs+(ptr++)];
    framex=roomdata[roomtable[roomnum].offs+(ptr++)];
    framey=roomdata[roomtable[roomnum].offs+(ptr++)];

    // Check for change of attributes
    if (framex<=0x7f)
    {
      frameattrib=roomdata[roomtable[roomnum].offs+(ptr++)];

      framereverse=((frameattrib&0x80)!=0);
      framesolid=((frameattrib&0x40)==0);
      frameplot=((frameattrib&0x18)>>3);
      framecolour=(frameattrib&0x07);
    }
    else
      framex-=0x80;

    // Check for flames
    if (framenum==115)
      gs.flames.push({"frm":framenum,"x":framex,"y":framey,"col":frameattrib,"delay":gs.flamerate});

    // Check for water
    if (framenum==91)
    {
      // Check for extra processing on broken bridge
      if (gs.room==48)
      {
        // x=52, y=184, attrib=0x47
        framey=(0-gs.waterheight)+168;

        for (var stretch=0; stretch<3; stretch++)
          gs.water.push({"frm":framenum,"x":(framex+(8*stretch)),"y":framey,"col":frameattrib,"delay":gs.waterrate});
      }
      else
        gs.water.push({"frm":framenum,"x":framex,"y":framey,"col":frameattrib,"delay":gs.waterrate});
    }

    drawframe(gs.ctx, (framex*4)-128, framey, framenum, 1, framereverse, getpalette(framecolour), frameplot, true);

    // Set solidity
    {
      var offs=frametable[framenum];
      var fx=(framex*4)-128;
      var fy=framey;
      var fwidth=framedefs[offs++]*4;
      var fheight=framedefs[offs++];

      // Clipping
      if (fx<border) { fwidth-=(border-fx); fx=border; } // left
      if (fy<(header+border)) { fheight-=((header+border)-fy); fy=header+border; } // top
      if ((fx+fwidth)>(xmax-border)) fwidth=((xmax-border)-fx); // right
      if ((fy+fheight)>(ymax-border)) fheight=((ymax-border)-fy); // bottom

      setsolidity(fx, fy, fwidth, fheight, framesolid);
      setpackedsolidity(framex, framey, fwidth/4, fheight, framesolid);
    }
  }

  // Draw any coins which are in this room
  for (var i=0; i<cointable.length; i++)
    if (cointable[i].room==roomnum)
      drawframe(gs.ctx, (cointable[i].x*4)-128, cointable[i].y, 0, 1, false, getpalette(6), 0, true);

  // Draw any objects which are in this room
  for (var i=0; i<objects.length; i++)
  {
    if (objects[i].room==roomnum)
    {
      var objattrib=objects[i].colour;
      var objreverse=((objattrib&0x80)!=0);
      var objplot=((objattrib&0x18)>>3);
      var objcolour=(objattrib&0x07);

      drawframe(gs.ctx, (objects[i].movex*4)-128, objects[i].movey, objects[i].movefrm, 1, objreverse, getpalette(objcolour), objplot, true);

      {
        var offs=frametable[objects[i].movefrm];
        var fx=(objects[i].movex*4)-128;
        var fy=objects[i].movey;
        var fwidth=framedefs[offs++]*4;
        var fheight=framedefs[offs++];
        var framesolid=((objattrib&0x40)==0);

        // Clipping
        if (fx<border) { fwidth-=(border-fx); fx=border; } // left
        if (fy<(header+border)) { fheight-=((header+border)-fy); fy=header+border; } // top
        if ((fx+fwidth)>(xmax-border)) fwidth=((xmax-border)-fx); // right
        if ((fy+fheight)>(ymax-border)) fheight=((ymax-border)-fy); // bottom

        setsolidity(fx, fy, fwidth, fheight, framesolid);
        setpackedsolidity(objects[i].movex, objects[i].movey, fwidth/4, fheight, framesolid);

        if (gs.debug)
        {
          // Highlight object
          gs.ctx.fillStyle="rgba(255,255,0,0.5)";
          gs.ctx.fillRect(fx, fy, fwidth, fheight);
        }
      }
    }
 }

  // Highlight proximity areas which are in this room
  if (gs.debug)
  {
    for (j=0; j<prox.length; j++)
    {
      if (prox[j].room==roomnum)
      {
        gs.ctx.fillStyle="rgba(0,255,255,0.5)";
        gs.ctx.fillRect((prox[j].x*4)-128, prox[j].y, prox[j].w*4, prox[j].h);

        gs.ctx.fillStyle="rgb(255,255,255)";
        gs.ctx.font = "12px Sans";
        gs.ctx.fillText(prox[j].name, (prox[j].x*4)-128, prox[j].y+12);
      }
    }
  }

 // When in debug, show where the solid blocks are
 if (gs.debug)
   highlightsolid();

  // Write name of room
  writestring(gs.ctx, 6*8, 3*8, (roomtable[roomnum].name.length==0)?"::::::::::::::::::::":roomtable[roomnum].name, 1, getpalette(6), false);

  // Extra per-room processing
  switch (roomnum)
  {
    case 0:
      var pen=0;

      pen=3;
      writestring(gs.ctx, (19*4), 49, "FANTASY:WORLD", 1, getpalette(pen), false);

      pen=2;
      writestring(gs.ctx, (24*4), 80, "STARRING", 1, getpalette(pen), false);
      writestring(gs.ctx, (20*4), 89, "THE:YOLKFOLK", 1, getpalette(pen), false);

      pen=5;
      writestring(gs.ctx, (20*4), 108, "D", 1, getpalette(pen), false);
      writestring(gs.ctx, (22*4), 106, "I", 1, getpalette(pen), false);
      writestring(gs.ctx, (24*4), 104, "Z", 1, getpalette(pen), false);
      writestring(gs.ctx, (26*4), 102, "Z", 1, getpalette(pen), false);
      writestring(gs.ctx, (28*4), 100, "Y", 1, getpalette(pen), false);

      writestring(gs.ctx, (35*4), 100, "D", 1, getpalette(pen), false);
      writestring(gs.ctx, (37*4), 102, "A", 1, getpalette(pen), false);
      writestring(gs.ctx, (39*4), 104, "I", 1, getpalette(pen), false);
      writestring(gs.ctx, (41*4), 106, "S", 1, getpalette(pen), false);
      writestring(gs.ctx, (43*4), 108, "Y", 1, getpalette(pen), false);

      writestring(gs.ctx, (9*4), 142, "DENZIL:DYLAN", 1, getpalette(pen), false);
      writestring(gs.ctx, (35*4), 136, "DOZY", 1, getpalette(pen), false);
      writestring(gs.ctx, (46*4), 136, "GRAND", 1, getpalette(pen), false);
      writestring(gs.ctx, (46*4), 144, "DIZZY", 1, getpalette(pen), false);

      drawframe(gs.ctx, (58*4)-128, 57, 27, 1, false, getpalette(6), 0, true);
      break;

    default:
      break;
  }
}

function setsequence(seq)
{
  if (gs.sequence!=seq)
  {
    gs.sequence=seq;
    gs.animation=0;
  }
}

// Handle slowing player down by friction
function standcheck()
{
  // When no horizontal movement pressed, slow down by friction
  if (((!ispressed(1)) && (!ispressed(4))) ||
      ((ispressed(1)) && (ispressed(4))))
  {
    // Going left
    if (gs.dir==-1)
    {
      if (gs.hs<0)
      {
        gs.hs+=gs.friction;
      }
      else
      {
        gs.hs=0;
        gs.dir=0;
        setsequence(0);
      }
    }

    // Going right
    if (gs.dir==1)
    {
      if (gs.hs>0)
      {
        gs.hs-=gs.friction;
      }
      else
      {
        gs.hs=0;
        gs.dir=0;
        setsequence(0);
      }
    }
  }
}

// When jumping and vertical speed positive (down) set to falling
function jumpcheck()
{
  // When jumping ..
  if (gs.jump)
  {
    // Check if loosing altitude
    if (gs.vs>=0)
    {
      gs.jump=false;
      gs.fall=true;
    }
  }
}

// Check if character collides with solid background
function collide(x, y)
{
  var tx=Math.floor(x/8);
  var ty=Math.floor(y/8);
  var twidth=Math.floor(xmax/8);

  if ((gs.solid[(ty*twidth)+tx]) || // top left
      (gs.solid[(ty*twidth)+tx+2]) || // top right
      (gs.solid[((ty+2)*twidth)+tx]) || // bottom left
      (gs.solid[((ty+2)*twidth)+tx+2]))   // bottom right
    return true;

  return false;

/*
  // Look through the room for a collision
  for (var i=0; i<gs.solid.length; i++)
  {
    if (((x+22)>=gs.solid[i].x) && // right of player vs left of object
        ((y+20)>=gs.solid[i].y) && // bottom of player vs top of object
        (x<=(gs.solid[i].x+gs.solid[i].w)) && // left of player vs right of object
        (y<=(gs.solid[i].y+gs.solid[i].h))) // top of player vs bottom of object
      return true;
  }
    
  return false;
*/
}

// Check for player being on the ground
function groundcheck()
{
  // Check we are on the ground
  if (collide(gs.x, gs.y+1))
  {
    gs.vs=0;
    gs.jump=false;
    gs.fall=false;
    
    // Check for jump pressed
    if (ispressed(16))
    {
      gs.jump=true;
      gs.vs=-gs.jumpspeed;
    }
  }
  else
  {
    // Check for jump pressed
    if ((ispressed(16)) && (gs.jump==false) && (gs.fall==false))
    {
      gs.jump=true;
      gs.vs=-gs.jumpspeed;
    }

    // We're in the air, increase falling speed until we're at terminal velocity
    if (gs.vs<gs.terminalvelocity)
      gs.vs+=gs.gravity;

    // Set falling flag when vertical speed is positive
    if (gs.vs>0)
      gs.fall=true;
  }
}

// Move character by up to horizontal/vertical speeds, stopping when a collision occurs
function collisioncheck()
{
  // check for horizontal collisions
  if ((!gs.newroom) && (collide(gs.x+gs.hs, gs.y)))
  {
    // A collision occured, so move the character until it hits
    while (!collide(gs.x+(gs.hs>0?1:-1), gs.y))
      gs.x+=(gs.hs>0?1:-1);

    // Stop horizontal movement
    gs.hs=0;
  }
  gs.x+=gs.hs;

  // check for vertical collisions
  if ((!gs.newroom) && (collide(gs.x, gs.y+gs.vs)))
  {
    // A collision occured, so move the character until it hits
    while (!collide(gs.x, gs.y+(gs.vs>0?1:-1)))
      gs.y+=(gs.vs>0?1:-1);

    // Stop vertical movement
    gs.vs=0;
  }
  gs.y+=gs.vs;
}

// Changing to a new room
function newroom()
{
  // Check we have not left the map entirely
  if ((gs.room<0) || (gs.room>100))
  {
    gs.room=36;
    gs.x=124; // 46
    gs.y=154; // 168
    gs.hs=0;
    gs.vs=0;
    gs.dir=0;
    gs.jump=false;
    gs.fall=false;
  }

  gs.newroom=true;

  drawroom(gs.room);
}

// Check for player leaving room
function offscreencheck()
{
  // Going left
  if (gs.x<8)
  {
    gs.x=225;
    gs.room--;
    newroom();
  }

  // Going right
  if (gs.x>225)
  {
    gs.x=8;
    gs.room++;
    newroom();
  }

  // Going up
  if (gs.y<26)
  {
    gs.y=154;
    gs.room+=16;
    newroom();
  }

  // Going down
  if (gs.y>162)
  {
    gs.y=50;
    gs.room-=16;
    newroom();
  }
}

// Update the position of player
function updatemovements()
{
  // If newroom and not colliding, reset flag
  if ((gs.newroom) && (!collide(gs.x, gs.y)))
    gs.newroom=false;

  // Check if the player has left the room
  offscreencheck();

  // Check if the player on the ground or falling
  groundcheck();

  // Process jumping
  jumpcheck();

  // Move payer by appropriate amount, up to a collision
  collisioncheck();

  // If no input, slow the player using friction
  standcheck();

  // Move player when a key is pressed
  if (gs.keystate!=0)
  {
    // Left key
    if ((ispressed(1)) && (!ispressed(4)))
    {
      gs.hs=-gs.walkspeed;
      gs.dir=-1;
      setsequence((gs.jump||gs.fall)?4:1);
    }

    // Right key
    if ((ispressed(4)) && (!ispressed(1)))
    {
      gs.hs=gs.walkspeed;
      gs.dir=1;
      setsequence((gs.jump||gs.fall)?5:2);
    }
  }

  if ((gs.x!=gs.px) || (gs.y!=gs.py))
  {
    gs.px=gs.x;
    gs.py=gs.y;
  }

  if (gs.dir==0)
  {
    if ((gs.jump) || (gs.fall))
      setsequence(3);
    
    if ((!gs.jump) && (!gs.fall))
      setsequence(0);
  }

  gs.dizzyctx.clearRect(0, 0, gs.dizzycanvas.width, gs.dizzycanvas.height);
  drawdizzy(gs.dizzyctx, gs.x, gs.y, sequences[gs.sequence][gs.animation], 1);

  gs.animdelay--;
  if (gs.animdelay<=0)
  {
    gs.animation=((gs.animation+1)%sequences[gs.sequence].length);
    gs.animdelay=6;
  }
}

function random()
{
  var a;
  var c;
  var oc;

  a=gs.seed[0]&0xff;

  a=(a-1)&0xff;

  a=(a^gs.seed[1])&0xff;
  c=0;

  oc=c;
  c=(a&0x80)>>7;
  a=(a<<1)&0xff;
  a|=oc;

  oc=c;
  c=gs.seed[2]&0x01;
  gs.seed[2]>>=1;
  gs.seed[2]|=oc<<7;

  gs.seed[0]=a;

  a=(a^0xff)&0xff;

  oc=c;
  c=(a&0x80)>>7;
  a=(a<<1)&0xff;
  a|=oc;

  a=(a^48)&0xff;
  c=0;

  a=(a^gs.seed[1])&0xff;
  c=0;

  gs.seed[1]=a;

  a=(a^gs.seed[2])&0xff;
  c=0;

  return a;
}

function getsincos(i)
{
  return [0, 6,12,18,24,30,35,40,45,49,53,56,59,61,62,63, // quad 0
          64,63,62,61,59,56,53,49,45,40,35,30,24,18,12, 6, // quad 1
	  -0,-6,-12,-18,-24,-30,-35,-40,-45,-49,-53,-56,-59,-61,-62,-63,  // quad 2
	  -64,-63,-62,-61,-59,-56,-53,-49,-45,-40,-35,-30,-24,-18,-12,-6 // quad 3
	  ][i>>1];
}

function getvalue(i, c)
{
  var a=getsincos(i);
  var waspos=a>-1;
 
  a=Math.abs(a);
  a=a*c;
  a=(a>>8)&0xff;
  
  if (!waspos)
    a=0-a;
 
  return a;
}

function printheart(count)
{
  var a=gs.hearttable[count*2];
  var c;
  var frameno;
  var frmx;
  var frmy;

  // Determine heart size
  a=(a>>5)&0x03;
  if (a==0) return a;
  
  frameno=a+28;
  
  a=gs.hearttable[(count*2)+1]; // path 0-255
  
  // sub (anticlockwise) or add (clockwise)
  if (gs.heartsclockwise)
    a=(a-gs.hearttable[count*2])&0xff; // count 0-255
  else
    a=(a+gs.hearttable[count*2])&0xff; // count 0-255

  a=a&0x7f;
  
  c=a;
  a=getvalue(a, gs.hearttable[count*2]);
  frmx=(a+62)&0xff;
  a=c;
  
  a=(a+32)&0x7f;
  
  a=getvalue(a, gs.hearttable[count*2]);
  c=a;
  a=(a+a)&0xff;
  a=(a+c)&0xff;
  
  a=(a+110)&0xff;
  frmy=a;

  drawframe(gs.dizzyctx, frmx*2, frmy, frameno, 1, false, getpalette(2), 1, true);

  return a;
}

function resethearts()
{
  var a=0;
  gs.heartsclockwise=!gs.heartsclockwise;
    
  for (var count=0; count<gs.numhearts; count++)
  {
    gs.hearttable[count*2]=a;
    a=random();
    gs.hearttable[(count*2)+1]=a;
    printheart(count);
    a=(a+8)&0xff;
  }
}

function updatehearts()
{
  if (!gs.heartsetup)
  {
    resethearts();
    gs.heartsetup=true;

    return;
  }

  gs.dizzyctx.clearRect(0, 0, gs.dizzycanvas.width, gs.dizzycanvas.height);

  for (var count=0; count<gs.numhearts; count++)
  {
    gs.hearttable[count*2]=(gs.hearttable[count*2]+1)&0xff;

    printheart(count);
  }
}

// Update state
function update()
{
  // Apply keystate/physics to player
  updatemovements();

  // Animate flames
  for (var i=0; i<gs.flames.length; i++)
  {
    if (gs.flames[i].anim>0)
    {
      gs.flames[i].anim--;
      continue;
    }
    else
      gs.flames[i].anim=gs.flamerate;

    var attrib=gs.flames[i].col;
    var reverse=((attrib&0x80)!=0);
    var plot=((attrib&0x18)>>3);
    var colour=(attrib&0x07);

    plot=0;

    // Flash between red and yellow
    colour=((colour==2)?colour=6:colour=2);
    gs.flames[i].col&=0x78; gs.flames[i].col|=colour;

    // Flip horizontally
    if (!reverse)
      gs.flames[i].col|=0x80;

    drawframe(gs.ctx, (gs.flames[i].x*4)-128, gs.flames[i].y, gs.flames[i].frm, 1, reverse, getpalette(colour), plot, true);
  }

  // Animate water
  for (var i=0; i<gs.water.length; i++)
  {
    if (gs.water[i].anim>0)
    {
      gs.water[i].anim--;
      continue;
    }
    else
      gs.water[i].anim=gs.waterrate;

    var attrib=gs.water[i].col;
    var reverse=((attrib&0x80)!=0);
    var plot=((attrib&0x18)>>3);
    var colour=(attrib&0x07);

    // Flip horizontally
    gs.water[i].frm++;
    if (gs.water[i].frm>95) gs.water[i].frm=92;

    drawframe(gs.ctx, (gs.water[i].x*4)-128, gs.water[i].y, gs.water[i].frm, 1, reverse, getpalette(colour), plot, true);
  }
}

// Request animation frame callback
function rafcallback(timestamp)
{
  // First time round, just save epoch
  if (gs.lasttime>0)
  {
    // Determine accumulated time since last call
    gs.acc+=((timestamp-gs.lasttime) / 1000);

    // If it's more than 15 seconds since last call, reset
    if ((gs.acc>gs.step) && ((gs.acc/gs.step)>(60*15)))
      gs.acc=gs.step*2;

    // Process "steps" since last call
    while (gs.acc>gs.step)
    {
      update();
      gs.acc-=gs.step;
    }
  }

  // Remember when we were last called
  gs.lasttime=timestamp;

  // Request we are called on the next frame
  window.requestAnimationFrame(rafcallback);
}

// Handle screen resizing to maintain correctly centered display
function resize()
{
  var height=window.innerHeight;
  var ratio=xmax/ymax;
  var width=Math.floor(height*ratio);
  var top=0;
  var left=Math.floor((window.innerWidth/2)-(width/2));

  if (width>window.innerWidth)
  {
    width=window.innerWidth;
    ratio=ymax/xmax;
    height=Math.floor(width*ratio);

    left=0;
    top=Math.floor((window.innerHeight/2)-(height/2));
  }

  // Background canvas
  gs.bgcanvas.style.top=top+"px";
  gs.bgcanvas.style.left=left+"px";

  gs.bgcanvas.style.transformOrigin='0 0';
  gs.bgcanvas.style.transform='scale('+(width/xmax)+')';

  // Play canvas
  gs.canvas.style.top=top+"px";
  gs.canvas.style.left=left+"px";

  gs.canvas.style.transformOrigin='0 0';
  gs.canvas.style.transform='scale('+(width/xmax)+')';

  // Dizzy canvas
  gs.dizzycanvas.style.top=top+"px";
  gs.dizzycanvas.style.left=left+"px";

  gs.dizzycanvas.style.transformOrigin='0 0';
  gs.dizzycanvas.style.transform='scale('+(width/xmax)+')';
}

function updatekeystate(e, dir)
{
  switch (e.which)
  {
    case 37: // cursor left
    case 65: // A
    case 90: // Z
      if (dir==1)
        gs.keystate|=1;
      else
        gs.keystate&=~1;
      e.preventDefault();
      break;

    case 38: // cursor up
    case 87: // W
    case 59: // semicolon
      if (dir==1)
        gs.keystate|=2;
      else
        gs.keystate&=~2;
      e.preventDefault();
      break;

    case 39: // cursor right
    case 68: // D
    case 88: // X
      if (dir==1)
        gs.keystate|=4;
      else
        gs.keystate&=~4;
      e.preventDefault();
      break;

    case 40: // cursor down
    case 83: // S
    case 190: // dot
      if (dir==1)
        gs.keystate|=8;
      else
        gs.keystate&=~8;
      e.preventDefault();
      break;

    case 13: // enter
    case 32: // space
      if (dir==1)
        gs.keystate|=16;
      else
        gs.keystate&=~16;
      e.preventDefault();
      break;

    case 73: // I (for info/debug)
      if (dir==1)
      {
        gs.debug=(!gs.debug);
        drawroom(gs.room);
      }
      e.preventDefault();
      break;

    // Keys to allow processing for
    case 116: // F5
      return;
      break;

    default:
      break;
  }
  e.preventDefault();
}

// Generate water sprites
function generatewater()
{
  for (dframe=92; dframe<96; dframe++)
  {
    var orig=frametable[dframe-1];
    var xor=frametable[dframe];
    var dwidth=framedefs[orig++]*4;
    var dheight=framedefs[orig++];
    xor+=2;

    for (var count=0; count<((dwidth/8)*dheight); count++)
      framedefs[xor++]^=framedefs[orig++];
  }
}

// Load a png and display it on bg canvas
function loadbg(fn)
{
  var image=new Image();

  image.onload=function()
  {
    gs.bgctx.drawImage(image, 0, 0); // img, sx, sy, sw, sh, x, y, w, h
  };

  image.src=fn;
}

// Startup called once when page is loaded
function startup()
{
  document.onkeydown=function(e)
  {
    e = e || window.event;
    updatekeystate(e, 1);
  };

  document.onkeyup=function(e)
  {
    e = e || window.event;
    updatekeystate(e, 0);
  };

  // Stop things from being dragged around
  window.ondragstart=function(e)
  {
    e = e || window.event;
    e.preventDefault();
  };

  gs.bgcanvas=document.getElementById('bg');
  gs.bgctx=gs.bgcanvas.getContext('2d');

  gs.canvas=document.getElementById('canvas');
  gs.ctx=gs.canvas.getContext('2d');

  gs.dizzycanvas=document.getElementById('dizzy');
  gs.dizzyctx=gs.dizzycanvas.getContext('2d');

  loadbg('info/dizzy3_loader.png');

  resize();
  window.addEventListener("resize", resize);

  generatewater();

  resetobjects();

  drawroom(gs.room);

  // Start updates
  window.requestAnimationFrame(rafcallback);

/*
  setInterval(function() {
    drawroom(gs.room);

    gs.room++;
    if (gs.room>maxroom) gs.room=0;
    while (roomtable[gs.room].len==0)
    {
      gs.room++;
      if (gs.room>maxroom) gs.room=0;
    }
  }, 2000);
*/
}

// Run the startup() once page has loaded
window.onload=function() { startup(); };
