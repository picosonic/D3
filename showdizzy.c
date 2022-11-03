#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define BITSPERBYTE 8
#define HEADERBYTES 2

#define WIDTH 48

#define NUMFRAMES 39

//#define ASMOUT 1

void drawbin(const unsigned char *data)
{
  unsigned char mask=0x80;

  while (mask>0)
  {
    printf("%c", (((*data)&mask)>0)?'#':' ');
    printf("%c", (((*data)&mask)>0)?'#':' ');

    mask>>=1;
  }
}

void hexbin(const unsigned char *data)
{
  unsigned char mask=0x80;

  fprintf(stderr, "%%");

  while (mask>0)
  {
    fprintf(stderr, "%c", (((*data)&mask)>0)?'1':'0');

    mask>>=1;
  }

  fprintf(stderr, ",");
}

void drawbin_width(const unsigned char *data, const unsigned char width, const unsigned char mask)
{
  unsigned char done=0;

#ifdef ASMOUT
  if (!mask) fprintf(stderr, "EQUB ");
#endif

  printf("|");
  
  while ((done*8)<width)
  {
    if (((mask) && (!(done&1))) || ((!mask) && (done&1)))
        drawbin(&data[done]);

#ifdef ASMOUT
  if ((!mask) && (done&1))
    hexbin(&data[done]);
#endif

    done++;
  }
  
  if (!mask)
    printf("|\n");

#ifdef ASMOUT
  if (!mask)
    fprintf(stderr, "\n");
#endif
}

int main()
{
  FILE *rd;
  struct stat fs;
  uint8_t *framedata;

  rd=fopen("dizzyfrm.bin", "rb");
  if (rd==NULL) return 1;

  fstat(fileno(rd), &fs);
  framedata=malloc(fs.st_size);

  if (framedata!=NULL)
  {
    int frame;

    fread(framedata, fs.st_size, 1, rd);
    fclose(rd);

    // Process it
    for (frame=0; frame<NUMFRAMES; frame++)
    {
      int start;

      start=(framedata[frame*2]);
      start=((framedata[(frame*2)+1]<<8)+start);

      // Check for valid pointer
      if (start<0xff00)
      {
        int width, height;
        int offs;
        int y;

        printf("%d [%.2x] : 0x%.4x", frame, frame, start);

        height=framedata[(NUMFRAMES*2)+start];

        printf(" (%dx%d) / %.2x\n", WIDTH, height, framedata[(NUMFRAMES*2)+start+1]);

#ifdef ASMOUT
        fprintf(stderr, ".frame%.2d\n", frame);
        fprintf(stderr, "EQUB %.2d,%.2d\n", height, framedata[(NUMFRAMES*2)+start+1]);
#endif

        // Decode the framedata
        offs=0;
        for (y=0; y<height; y++)
        {
          drawbin_width(&framedata[(NUMFRAMES*2)+start+HEADERBYTES+offs], WIDTH, 1);
          drawbin_width(&framedata[(NUMFRAMES*2)+start+HEADERBYTES+offs], WIDTH, 0);

          offs+=(WIDTH/8);
        }

        printf("\n");
      }
    }

    free(framedata);
  }
  else
  {
    fclose(rd);

    return 1;
  }

  return 0;
}
