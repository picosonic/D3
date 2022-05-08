// Global constants
const xmax=256;
const ymax=192;

const header=40;
const border=8;

const maxroom=100;

// Game state is global to prevent it going out of scope
var gs={
  // Canvas object
  canvas:null,
  ctx:null,

  room:0,

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
      var attrib=roomdata[roomtable[roomnum].offs+(ptr++)];

      framereverse=((attrib&0x80)!=0);
      framesolid=((attrib&0x40)==0);
      frameplot=((attrib&0x18)>>3);
      framecolour=(attrib&0x07);
    }
    else
      framex-=0x80;

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

          while ((gs.room>0) && (roomtable[gs.room].len==0))
            gs.room--;

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

          while ((gs.room<maxroom) && (roomtable[gs.room].len==0))
            gs.room++;

          drawroom(gs.room);
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
