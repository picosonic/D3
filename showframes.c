#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define BITSPERBYTE 8
#define HEADERBYTES 2

#define NUMFRAMES 256

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

void drawbin_width(const unsigned char *data, const unsigned char width)
{
  unsigned char done=0;

  printf("|");
  
  while ((done*8)<width)
  {
    drawbin(&data[done]);

    done++;
  }
  
  printf("|\n");
}

int main()
{
  FILE *rd;
  struct stat fs;
  uint8_t *framedata;
  int start;
  int frame, y;
  int width, height;
  int offs;

  rd=fopen("frames.bin", "rb");
  if (rd==NULL) return 1;

  fstat(fileno(rd), &fs);
  framedata=malloc(fs.st_size);

  if (framedata!=NULL)
  {
    fread(framedata, fs.st_size, 1, rd);
    fclose(rd);

    // Process it
    for (frame=0; frame<(NUMFRAMES-1); frame++)
    {
      start=(framedata[frame*2]);
      start=((framedata[(frame*2)+1]<<8)+start);

      // Check for valid pointer
      if (start<0xff00)
      {
        printf("%d [%.2x] : 0x%.4x", frame, frame, start);

        width=framedata[(NUMFRAMES*2)+start]*4;
        height=framedata[(NUMFRAMES*2)+start+1];

        printf(" (%dx%d)\n", width, height);

        // Decode the framedata
        offs=0;
        for (y=0; y<height; y++)
        {
          drawbin_width(&framedata[(NUMFRAMES*2)+start+HEADERBYTES+offs], width);
          offs+=(width/8);
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
