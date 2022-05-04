// Global constants
const xmax=256;
const ymax=192;

// Game state is global to prevent it going out of scope
var gs={
  // Canvas object
  canvas:null,
  ctx:null
};

function drawframe(ctx, x, y, framenum, scale, style)
{
  if ((framenum<0) || (framenum>0xff)) return;

  ctx.save();

  ctx.fillStyle=style;

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
          ctx.fillRect(Math.floor(x+(px*scale)), Math.floor(y+(py*scale)), Math.ceil(scale), Math.ceil(scale));

        px++;

        mask>>=1;
      }

      done++;
    }

    px=0;
  }

  ctx.restore();
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

  drawframe(gs.ctx, 128, 80, 96, 1, "#00FF00");
}

// Run the startup() once page has loaded
window.onload=function() { startup(); };
