#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define BITSPERBYTE 8
#define HEADERBYTES 2

#define WIDTH 24

#define NUMFRAMES 70

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

int main()
{
  FILE *rd;
  struct stat fs;
  uint8_t *framedata;

  rd=fopen("c64_memdump", "rb");
  if (rd==NULL) return 1;

  fstat(fileno(rd), &fs);
  framedata=malloc(fs.st_size);

  if (framedata!=NULL)
  {
    int frame;
    int start;

    fread(framedata, fs.st_size, 1, rd);
    fclose(rd);

    start=16384;

    // Process it
    for (frame=0; frame<NUMFRAMES; frame++)
    {
      int width, height;
      int offs;
      int y;

      printf("%d [%.2x] : 0x%.4x\n", frame, frame, start);

      // height=framedata[(NUMFRAMES*2)+start];
      height=21;

      // Decode the framedata
      offs=0;
      for (y=0; y<height; y++)
      {
        printf("|");

#ifdef ASMOUT
        fprintf(stderr, "EQUB ");
        hexbin(&framedata[start+offs]);
        hexbin(&framedata[start+offs+1]);
        hexbin(&framedata[start+offs+2]);
        fprintf(stderr, "\n");
#endif

        drawbin(&framedata[start+offs]);
        drawbin(&framedata[start+offs+1]);
        drawbin(&framedata[start+offs+2]);

        printf("|\n");

        offs+=3;
      }

      printf("(%.2x)\n\n", (unsigned char)framedata[start+offs]);

#ifdef ASMOUT
      fprintf(stderr, "EQUB &%.2X\n", (unsigned char)framedata[start+offs]);
      fprintf(stderr, "\n");
#endif

      start+=offs+1;
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
