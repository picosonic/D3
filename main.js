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
  room:0
};

function drawclippedpixel(ctx, x, y, width, height)
{
  if ((x>=border) && ((x+width)<=(xmax-border))
     && (y>=(header+border)) && ((y+height)<=(ymax-border)))
    ctx.fillRect(x, y, width, height);
}

function drawframe(ctx, x, y, framenum, scale, hflip, style)
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
          ctx.fillStyle=style;
        else
          ctx.fillStyle="#000000";

        if (hflip)
          drawclippedpixel(ctx, Math.floor(x+((fwidth-px-1)*scale)), Math.floor(y+(py*scale)), Math.ceil(scale), Math.ceil(scale));
        else
          drawclippedpixel(ctx, Math.floor(x+(px*scale)), Math.floor(y+(py*scale)), Math.ceil(scale), Math.ceil(scale));

        px++;

        mask>>=1;
      }

      done++;
    }

    px=0;
  }

  ctx.restore();
}

// Draw a full room
function drawroom(roomnum)
{
  var ptr=0;
  var framenum=0;
  var framex=0;
  var framey=0;
  var frameattrib=0;
  var framestyle="#FFFFFF";

  gs.ctx.fillStyle="#000000";
  gs.ctx.fillRect(border, header+border, xmax-(border*2), ymax-header-(border*2));

  while (ptr<roomtable[roomnum].len)
  {
    framenum=roomdata[roomtable[roomnum].offs+(ptr++)];
    framex=roomdata[roomtable[roomnum].offs+(ptr++)];
    framey=roomdata[roomtable[roomnum].offs+(ptr++)];

    if (framex>0x7f)
      framex-=0x80;
    else
      frameattrib=roomdata[roomtable[roomnum].offs+(ptr++)];

    switch ((frameattrib&0x0f))
    {
      case 0x00: framestyle="#000000"; break;
      case 0x01: framestyle="#0000d7"; break;
      case 0x02: framestyle="#d70000"; break;
      case 0x03: framestyle="#d700d7"; break;
      case 0x04: framestyle="#00d700"; break;
      case 0x05: framestyle="#00d7d7"; break;
      case 0x06: framestyle="#d7d700"; break;
      case 0x07: framestyle="#d7d7d7"; break;

      case 0x08: framestyle="#000000"; break;
      case 0x09: framestyle="#0000ff"; break;
      case 0x0a: framestyle="#ff0000"; break;
      case 0x0b: framestyle="#ff00ff"; break;
      case 0x0c: framestyle="#00ff00"; break;
      case 0x0d: framestyle="#00ffff"; break;
      case 0x0e: framestyle="#ffff00"; break;
      case 0x0f: framestyle="#ffffff"; break;
      default: break;
    }

    drawframe(gs.ctx, (framex*4)-128, framey, framenum, 1, ((frameattrib&0x80)!=0), framestyle);
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

// Startup called once when page is loaded
function startup()
{
  gs.canvas=document.getElementById('canvas');
  gs.ctx=gs.canvas.getContext('2d');

  resize();
  window.addEventListener("resize", resize);

  drawroom(gs.room);

  setInterval(function() {
    drawroom(gs.room);

    gs.room++;
    if (gs.room>maxroom) gs.room=0;
    while (roomtable[gs.room].len==0)
    {
      gs.room++;
      if (gs.room>maxroom) gs.room=0;
    }
  }, 1000);
}

// Run the startup() once page has loaded
window.onload=function() { startup(); };
