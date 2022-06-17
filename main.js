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

  // Canvas object
  canvas:null,
  ctx:null,

  room:0,
  flames:[], flamerate:4,
  water:[], waterrate:6,

  debug:false
};

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
          
          drawclippedpixel(ctx, Math.floor(x+(px*scale)), Math.floor(y+(py*scale)), Math.ceil(scale), Math.ceil(scale), true);

        }

        px++;

        bitmask>>=1;
      }

      done++;
    }
    
    px=0;
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
      gs.water.push({"frm":framenum,"x":framex,"y":framey,"col":frameattrib,"delay":gs.waterrate});

    drawframe(gs.ctx, (framex*4)-128, framey, framenum, 1, framereverse, getpalette(framecolour), frameplot, true);

    // When in debug, show where the solid frames are
    if ((gs.debug) && (framesolid))
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

      gs.ctx.fillStyle="rgba(255,0,255,0.5)";
      gs.ctx.fillRect(fx, fy, fwidth, fheight);
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

      //if ((gs.debug) && (objects[i].routine=="pickupable"))
      if (gs.debug)
      {
        var offs=frametable[objects[i].movefrm];
        var fx=(objects[i].movex*4)-128;
        var fy=objects[i].movey;
        var fwidth=framedefs[offs++]*4;
        var fheight=framedefs[offs++];

        gs.ctx.fillStyle="rgba(255,255,0,0.5)";
        gs.ctx.fillRect(fx, fy, fwidth, fheight);
      }
    }
  }

  // Write name of room
  writestring(gs.ctx, 7*8, 4*8, (roomtable[roomnum].name.length==0)?"::::::::::::::::::::":roomtable[roomnum].name, 1, getpalette(6), false);

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
  
  drawdizzy(gs.ctx, 100, 100, roomnum%dizzytable.length, 1);
}

// Update state
function update()
{
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

  // Play canvas
  gs.canvas.style.top=top+"px";
  gs.canvas.style.left=left+"px";

  gs.canvas.style.transformOrigin='0 0';
  gs.canvas.style.transform='scale('+(width/xmax)+')';
}

function updatekeystate(e, dir)
{
  switch (e.which)
  {
    case 37: // cursor left
    case 65: // A
    case 90: // Z
      if (dir==1)
      {
        if (gs.room>0)
        {
          gs.room--;

          drawroom(gs.room);
        }
      }
      e.preventDefault();
      break;

    case 38: // cursor up
    case 87: // W
    case 59: // semicolon
      if (dir==1)
      {
        if ((gs.room+16)<=maxroom)
        {
          gs.room+=16;

          drawroom(gs.room);
        }
      }
      e.preventDefault();
      break;

    case 39: // cursor right
    case 68: // D
    case 88: // X
      if (dir==1)
        if (gs.room<maxroom)
        {
          gs.room++;

          drawroom(gs.room);
        }
      e.preventDefault();
      break;

    case 40: // cursor down
    case 83: // S
    case 190: // dot
      if (dir==1)
      {
        if (gs.room>16)
        {
          gs.room-=16;

          drawroom(gs.room);
        }
      }
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

    default:
      break;
  }
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

  gs.canvas=document.getElementById('canvas');
  gs.ctx=gs.canvas.getContext('2d');

  resize();
  window.addEventListener("resize", resize);

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
