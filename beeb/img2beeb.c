#include <IL/il.h>
#include <IL/ilu.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <math.h>

#define MAX_CMAP_SIZE 8
#define MAX_WIDTH 320
#define MAX_HEIGHT 256

#define RGB_RED   0
#define RGB_GREEN 1
#define RGB_BLUE  2

// Floyd-Steinberg dithering error diffusion
//  ImageAlchemy 1
//
//   2D error diffusion formula was published by Robert Floyd and Louis Steinberg in 1976
//
//       X   7
//   3   5   1
//
//     (1/16)
#define FSD_R  (7.0/16.0)
#define FSD_BL (3.0/16.0)
#define FSD_B  (5.0/16.0)
#define FSD_BR (1.0/16.0)

#define DITHER_NONE 0
#define DITHER_FS   1

#define REVISION "1.0"

int remap=0;
long colours=0;
long ext_colours=0;
unsigned char quantpal[MAX_CMAP_SIZE*3];
long bpp=2; // Default to 4-colour mode

void loadpalette(const char *filename)
{
  char *dotpos;
  long palcolours;

  // Look for extension in filename
  dotpos=strrchr(filename, '.');

  if (dotpos!=NULL)
  {
    if (strcasecmp(dotpos, ".pal")==0)
    {
      // HSI palette file
      FILE *fp;
      char *line=NULL;
      size_t len=0;

      int r, g, b;

      fp=fopen(filename, "r");
      if (fp!=NULL)
      {
        ssize_t numread;

        // Read first line, it should be "PAL"
        numread=getline(&line, &len, fp);
        if (numread!=-1)
        {
          dotpos=strchr(line, '\r'); if (dotpos!=NULL) dotpos[0]=0;
          dotpos=strchr(line, '\n'); if (dotpos!=NULL) dotpos[0]=0;

          // Check header
          if (strcasecmp(line, "PAL")!=0)
          {
            if (line!=NULL) free(line);
            fclose(fp);
            return;
          }

          // Read second line, it should be the number of entries in the file
          numread=getline(&line, &len, fp);
          if (numread!=-1)
          {
            int palentry;

            dotpos=strchr(line, '\r'); if (dotpos!=NULL) dotpos[0]=0;
            dotpos=strchr(line, '\n'); if (dotpos!=NULL) dotpos[0]=0;

            sscanf(line, "%ld", &palcolours);

            // Check palette entries
            if ((palcolours<2) || (palcolours>MAX_CMAP_SIZE))
            {
              if (line!=NULL) free(line);
              fclose(fp);
              return;
            }

            palentry=0; ext_colours=0;

            // Read the rest of the file
            while (((numread=getline(&line, &len, fp)) != -1) && (palentry<palcolours))
            {
              int numvalues;

              dotpos=strchr(line, '\r'); if (dotpos!=NULL) dotpos[0]=0;
              dotpos=strchr(line, '\n'); if (dotpos!=NULL) dotpos[0]=0;

              numvalues=sscanf(line, "%d\t%d\t%d", &r, &g, &b);
              if (numvalues==3)
              {
                // Check they are all in range
                if ((r<0) || (r>255) ||
                    (g<0) || (g>255) ||
                    (b<0) || (b>255))
                {
                  r=0; g=0; b=0;
                }

                quantpal[(palentry*3)+RGB_RED]=r;
                quantpal[(palentry*3)+RGB_GREEN]=g;
                quantpal[(palentry*3)+RGB_BLUE]=b;

                palentry++;
              }
            }
            ext_colours=palentry;
          }
        }
        if (line!=NULL) free(line);

        fclose(fp);
      }
    }
    else
    {
      // Try to load palette from image
      ILuint  ImgId;
      unsigned char *impal;

      // Generate the image name to use
      ilGenImages(1, &ImgId);

      // Bind this image name
      ilBindImage(ImgId);

      // Loads the image specified
      if (ilLoadImage(filename))
      {
        // Check the loaded palette is indexed
        if (ilGetInteger(IL_IMAGE_FORMAT)==IL_COLOUR_INDEX)
        {
          int imcolours;
          int i;

          // Make sure the loaded palette is in RGB
          ilConvertPal(IL_PAL_RGB24);

          imcolours=iluColoursUsed();

          // Save palette from image
          impal=ilGetPalette();
          for (i=0; ((i<imcolours) && (i<MAX_CMAP_SIZE)); i++)
          {
            quantpal[(i*3)+RGB_RED]=impal[RGB_RED];
            quantpal[(i*3)+RGB_GREEN]=impal[RGB_GREEN];
            quantpal[(i*3)+RGB_BLUE]=impal[RGB_BLUE];

            impal+=3;
          }

          ext_colours=imcolours;
        }
      }
      else
        fprintf(stderr, "\nCould not open file for palette... %s\n", filename);

      // We're done with the image, so let's delete it
      ilDeleteImages(1, &ImgId);
    }
  }
}

// Find nearest entry for r,g,b value in quantized palette
unsigned char findnearestentry(const unsigned char r, const unsigned char g, const unsigned char b)
{
  int i;
  int index=0;

  long best=((255*255)*3);

  for (i=0; i<(ext_colours!=0?ext_colours:colours); i++)
  {
    unsigned char pr, pg, pb;

    pr=quantpal[(i*3)+RGB_RED];
    pg=quantpal[(i*3)+RGB_GREEN];
    pb=quantpal[(i*3)+RGB_BLUE];

    long dr=(long)r-(long)pr;
    long dg=(long)g-(long)pg;
    long db=(long)b-(long)pb;

    // Determine "distance"
    long dist=(dr*dr)+(dg*dg)+(db*db);

    if (dist<best)
    {
      best=dist;
      index=i;
    }
  }

  return index;
}

unsigned char findpal(const unsigned char *impal, const unsigned char col)
{
  return (findnearestentry(impal[(col*3)+RGB_RED], impal[(col*3)+RGB_GREEN], impal[(col*3)+RGB_BLUE]));
}

unsigned char ditherclamp(const double value, const double qerr)
{
  double result=value+qerr;

  if (result>255) result=255;
  if (result<0) result=0;

  return result;
}

void apply_ditering(unsigned char *imdata, const long width, const long height, const long x, const long y, const unsigned char palentry)
{
  double qerr;
  double r, g, b;

  // Check x,y is within image bounds
  if ((x<0) || (y<0) || (x>=width) || (y>=height)) return;

  // Get current colour values from image
  r=imdata[(((y*width)+x)*3)+RGB_RED];
  g=imdata[(((y*width)+x)*3)+RGB_GREEN];
  b=imdata[(((y*width)+x)*3)+RGB_BLUE];

  qerr=r-(double)(quantpal[(palentry*3)+RGB_RED]);
  if (x<(width-1))
    imdata[(((y*width)+x+1)*3)+RGB_RED]=ditherclamp(imdata[(((y*width)+x+1)*3)+RGB_RED], (double)(qerr*FSD_R));
  if ((x>0) && (y<(height-1)))
    imdata[((((y+1)*width)+x-1)*3)+RGB_RED]=ditherclamp(imdata[((((y+1)*width)+x-1)*3)+RGB_RED], (double)(qerr*FSD_BL));
  if (y<(height-1))
    imdata[((((y+1)*width)+x)*3)+RGB_RED]=ditherclamp(imdata[((((y+1)*width)+x)*3)+RGB_RED], (double)(qerr*FSD_B));
  if ((x<(width-1)) && (y<(height-1)))
    imdata[((((y+1)*width)+x+1)*3)+RGB_RED]=ditherclamp(imdata[((((y+1)*width)+x+1)*3)+RGB_RED], (double)(qerr*FSD_BR));

  qerr=g-(double)(quantpal[(palentry*3)+RGB_GREEN]);
  if (x<(width-1))
    imdata[(((y*width)+x+1)*3)+RGB_GREEN]=ditherclamp(imdata[(((y*width)+x+1)*3)+RGB_GREEN], (double)(qerr*FSD_R));
  if ((x>0) && (y<(height-1)))
    imdata[((((y+1)*width)+x-1)*3)+RGB_GREEN]=ditherclamp(imdata[((((y+1)*width)+x-1)*3)+RGB_GREEN], (double)(qerr*FSD_BL));
  if (y<(height-1))
    imdata[((((y+1)*width)+x)*3)+RGB_GREEN]=ditherclamp(imdata[((((y+1)*width)+x)*3)+RGB_GREEN], (double)(qerr*FSD_B));
  if ((x<(width-1)) && (y<(height-1)))
    imdata[((((y+1)*width)+x+1)*3)+RGB_GREEN]=ditherclamp(imdata[((((y+1)*width)+x+1)*3)+RGB_GREEN], (double)(qerr*FSD_BR));

  qerr=b-(double)(quantpal[(palentry*3)+RGB_BLUE]);
  if (x<(width-1))
    imdata[(((y*width)+x+1)*3)+RGB_BLUE]=ditherclamp(imdata[(((y*width)+x+1)*3)+RGB_BLUE], (double)(qerr*FSD_R));
  if ((x>0) && (y<(height-1)))
    imdata[((((y+1)*width)+x-1)*3)+RGB_BLUE]=ditherclamp(imdata[((((y+1)*width)+x-1)*3)+RGB_BLUE], (double)(qerr*FSD_BL));
  if (y<(height-1))
    imdata[((((y+1)*width)+x)*3)+RGB_BLUE]=ditherclamp(imdata[((((y+1)*width)+x)*3)+RGB_BLUE], (double)(qerr*FSD_B));
  if ((x<(width-1)) && (y<(height-1)))
    imdata[((((y+1)*width)+x+1)*3)+RGB_BLUE]=ditherclamp(imdata[((((y+1)*width)+x+1)*3)+RGB_BLUE], (double)(qerr*FSD_BR));
}

int numeric(const char c)
{
  if ((c<'0') || (c>'9')) return 0;

  return 1;
}

void showsyntax()
{
  fprintf(stderr, "img2beeb v%s - Jasper Renow-Clarke (c) 2022\n", REVISION);
  fprintf(stderr, "  Usage : img2beeb [-c<max_colours>] [-d<dither>] [-b<bpp>] [-X<width>] [-Y<height>] [-f <palette_file>] <image_file> <beeb_file>\n");
}

int main(int argc, char **argv)
{
  ILuint  ImgId;
  ILuint  ImgOutId;
  ILenum  Error;

  int argn=1;
  int parampos;

  long width;
  long height;
  long targetwidth=0;
  long targetheight=0;
  long targetcolours=MAX_CMAP_SIZE;
  unsigned char *imdata;
  unsigned char *impal;
  unsigned char *trimdata;
  int dither=DITHER_FS;

  FILE *fp;
  char *infile=NULL;
  char *outfile=NULL;

  // We use the filename specified in the first argument of the command-line,
  //  and the output filename in the second
  if (argc < 3)
  {
    showsyntax();
    return 1;
  }

  // Check if the shared lib's version matches the executable's version
  if (ilGetInteger(IL_VERSION_NUM) < IL_VERSION ||
    iluGetInteger(ILU_VERSION_NUM) < ILU_VERSION)
  {
    fprintf(stderr, "DevIL version is different...exiting\n");
    return 2;
  }

  // Initialize DevIL
  ilInit();
  iluInit();

  // Set values from command line
  while (argn<argc)
  {
    // Check for option
    if (argv[argn][0]=='-')
    {
      parampos=2;

      switch (argv[argn][1])
      {
        case 'b': // bits per pixel
          sscanf(&argv[argn][parampos], "%ld", &bpp);

          // Make sure bpp is a supported value
          //
          // 2 colours - not supported - MODES 0/4
          // 4 colours - 2bpp - MODES 1/5
          // 8 colours - 4bpp - MODE 2

          if (bpp>4) bpp=4;
          if (bpp==3) bpp=2;
          if (bpp<2) bpp=2;
          break;

        case 'c': // max colours
          sscanf(&argv[argn][parampos], "%ld", &targetcolours);

          // limit colours to colour map size
          if (targetcolours>MAX_CMAP_SIZE) targetcolours=MAX_CMAP_SIZE;
          if (targetcolours<2) targetcolours=2;
          break;

        case 'd': // dither
          sscanf(&argv[argn][parampos], "%d", &dither);

          // We only support None, or Floyd-Steinberg dithering
          if (dither>1) dither=DITHER_FS;
          break;

        case 'f': // use external palette
          if ((argn+1)<argc) argn++;
          loadpalette(argv[argn]);
          break;

        case 'X': // target width
          if (numeric(argv[argn][parampos])==0) parampos++;
          sscanf(&argv[argn][parampos], "%ld", &targetwidth);
          break;

        case 'Y': // target height
          if (numeric(argv[argn][parampos])==0) parampos++;
          sscanf(&argv[argn][parampos], "%ld", &targetheight);
          break;

        default: // ignore everything else
          break;
      }
    }
    else
    {
      // Process this argument as a filename, first input then output
      if (infile==NULL)
        infile=argv[argn];
      else
      if (outfile==NULL)
        outfile=argv[argn];
    }

    argn++;
  }

  // Check we have 2 filenames
  if ((infile==NULL) || (outfile==NULL))
  {
    showsyntax();
    fprintf(stderr, "\nMissing filename(s)\n");
    return 3;
  }

  // Ensure loaded image format is RGB
  ilSetInteger(IL_FORMAT_MODE, IL_RGB);
  ilEnable(IL_FORMAT_SET);

  // Ensure loaded image type is in unsigned 8 bit
  ilSetInteger(IL_TYPE_MODE, IL_UNSIGNED_BYTE);
  ilEnable(IL_TYPE_SET);

  // Generate the main image name to use
  ilGenImages(1, &ImgId);

  // Bind main image name
  ilBindImage(ImgId);

  // Loads the image specified by File into the image named by ImgId
  if (!ilLoadImage(infile))
  {
    fprintf(stderr, "\nCould not open file... %s\n", infile);
    return 4;
  }

  // Get image size
  width=ilGetInteger(IL_IMAGE_WIDTH);
  height=ilGetInteger(IL_IMAGE_HEIGHT);

  // Check for target size scaling
  if ((targetwidth!=0) && (targetheight!=0))
  {
    // Only scale if target dimensions differ from source dimensions
    if ((width!=targetwidth) || (height!=targetheight))
    {
      iluImageParameter(ILU_FILTER, ILU_SCALE_TRIANGLE);
      iluScale(targetwidth, targetheight, ilGetInteger(IL_IMAGE_DEPTH));
    }
  }
  else
  {
    long scale;

    // Work out any scaling for big images
    if (width>MAX_WIDTH)
    {
      scale=(width*1000)/height;

      width=MAX_WIDTH;
      height=(width*1000)/scale;
    }

    if (height>MAX_HEIGHT)
    {
      scale=(height*1000)/width;

      height=MAX_HEIGHT;
      width=(height*1000)/scale;
    }

    iluImageParameter(ILU_FILTER, ILU_SCALE_TRIANGLE);
    iluScale(width, height, ilGetInteger(IL_IMAGE_DEPTH));
  }

  // Get image size (after any scaling has taken place)
  width=ilGetInteger(IL_IMAGE_WIDTH);
  height=ilGetInteger(IL_IMAGE_HEIGHT);

  // Disable dithering if we don't need to do it
  colours=iluColoursUsed();
  if ((colours<=targetcolours) && (ext_colours==0)) dither=DITHER_NONE;

  // Check if dithering required
  if (dither!=DITHER_NONE)
  {
    // Generate optimised palette, only run this if we've not loaded an external palette
    if (ext_colours==0)
    {
      // Duplicate scaled image ready for quantization
      ilGenImages(1, &ImgOutId);
      ilBindImage(ImgOutId);
      ilCopyImage(ImgId);

      // Set quantization parameters
      ilSetInteger(IL_QUANTIZATION_MODE, IL_WU_QUANT);
      ilSetInteger(IL_MAX_QUANT_INDICES, targetcolours);

      // Convert the scaled image to 8 bit indexed
      ilConvertImage(IL_COLOUR_INDEX, IL_UNSIGNED_BYTE);

      // Determine colours used in 8 bit indexed image (should be <= targetcolours)
      colours=iluColoursUsed();

      // Save quantized palette
      memcpy(quantpal, ilGetPalette(), (colours*3));

      // Indicate a palette remap is necessary
      remap=1;

      // We're done with the quantized image
      ilBindImage(ImgId);
      ilDeleteImages(1, &ImgOutId);
    }
  }

  // Check for external palette
  if (ext_colours!=0)
  {
    colours=ext_colours;
    remap=1;
  }

  // Map source image to palette
  if (remap==1)
  {
    long x;
    long y;

    imdata=ilGetData();
    for (y=0; y<height; y++)
      for (x=0; x<width; x++)
    {
      unsigned char r, g, b;
      unsigned char palentry;

      unsigned char *pixel;

      pixel=&imdata[(((y*width)+x)*3)];

      r=pixel[RGB_RED];
      g=pixel[RGB_GREEN];
      b=pixel[RGB_BLUE];

      palentry=findnearestentry(r, g, b);

      if (dither!=DITHER_NONE)
        apply_ditering(imdata, width, height, x, y, palentry);

      // Set this pixel to nearest found colour
      imdata[(((y*width)+x)*3)+RGB_RED]=quantpal[(palentry*3)+2];
      imdata[(((y*width)+x)*3)+RGB_GREEN]=quantpal[(palentry*3)+1];
      imdata[(((y*width)+x)*3)+RGB_BLUE]=quantpal[(palentry*3)+0];
    }
  }

  // Set quantization parameters
  ilSetInteger(IL_QUANTIZATION_MODE, IL_WU_QUANT);
  ilSetInteger(IL_MAX_QUANT_INDICES, targetcolours);

  // Convert the scaled image to 8 bit indexed
  ilConvertImage(IL_COLOUR_INDEX, IL_UNSIGNED_BYTE);

  // Count colours used in new dithered 8 bit indexed
  colours=iluColoursUsed();

  // Extract image data
  imdata=ilGetData();

  // Open output file
  fp=fopen(outfile, "wb+");
  if (fp==NULL)
  {
    showsyntax();
    fprintf(stderr, "\nCould not open output file... %s\n", outfile);
    return 5;
  }

  // Convert from RAW to BEEB
  {
    uint8_t p1, p2, p3, p4;
    uint8_t bc;
    int blockx, blocky;
    int offs;
    int ptr;

    impal=ilGetPalette();

    for (offs=0; offs<height; offs+=8)
    {
      for (blockx=0; blockx<width; blockx+=(bpp==2?4:2))
      {
        for (blocky=0; blocky<8; blocky++)
        {
          ptr=((blocky+offs)*width)+blockx;

          p1=findpal(impal, imdata[ptr+0]);
          p2=findpal(impal, imdata[ptr+1]);

          if (bpp==2)
          {
            p3=findpal(impal, imdata[ptr+2]);
            p4=findpal(impal, imdata[ptr+3]);

            // pack bits for 2bpp (4 colours)
            bc =(p1&2)<<6; bc|=(p1&1)<<3;
            bc|=(p2&2)<<5; bc|=(p2&1)<<2;
            bc|=(p3&2)<<4; bc|=(p3&1)<<1;
            bc|=(p4&2)<<3; bc|=(p4&1)<<0;
          }

          if (bpp==4)
          {
            // pack bits for 4bpp (16 colours)
            bc =(p1&0x1)<<1; bc|=(p1&0x2)<<2;
            bc|=(p1&0x4)<<3; bc|=(p1&0x8)<<4;

            bc|=(p2&0x1)<<0; bc|=(p2&0x2)<<1;
            bc|=(p2&0x4)<<2; bc|=(p2&0x8)<<3;
          }

          fprintf(fp, "%c", bc);
        }
      }
    }
  }

  // Close the output file
  fclose(fp);

  printf("Width: %d  Height: %d  Depth: %d  Bpp: %d  Colours: %d\n",
    ilGetInteger(IL_IMAGE_WIDTH),
    ilGetInteger(IL_IMAGE_HEIGHT),
    ilGetInteger(IL_IMAGE_DEPTH),
    ilGetInteger(IL_IMAGE_BITS_PER_PIXEL),
    iluColoursUsed());

  // We're done with the image, so let's delete it
  ilDeleteImages(1, &ImgId);

  // Simple Error detection loop that displays the Error to the user in a human-readable form
  while ((Error = ilGetError()) != IL_NO_ERROR)
  {
    fprintf(stderr, "Error %d : %s\n", Error, iluErrorString(Error));
  }

  return 0;
}
