#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#define BITSPERBYTE 8

#define FONTOFFS 0xc0fb
#define HEADERBYTES 2
#define DATABYTES 8
#define FONTCHARS 44
#define FONTWIDTH 8

void drawbin(const unsigned char *data)
{
  unsigned char mask=0x80;

  while (mask>0)
  {
    printf("%c", (((*data)&mask)>0)?'#':' ');

    mask>>=1;
  }
}

void drawbin_width(const unsigned char *data, const unsigned char width)
{
  unsigned char done=0;
  
  while ((done*8)<width)
  {
    drawbin(&data[done]);

    done++;
  }
  
  printf("\n");
}

int main()
{
  FILE *fp;
  unsigned char *buffer;
  unsigned int offs, ch;
  int i;
  
  fp=fopen("dizzy3_spectrum_ramdump", "rb");
  if (fp!=NULL)
  {
    buffer=malloc(0xffff);
    if (buffer!=NULL)
    {
      if (fread(buffer, 0xffff, 1, fp)==1)
      {
        offs=FONTOFFS;

        for (ch=0; ch<FONTCHARS; ch++)
        {
          printf("%.4x (%.2xx%.2x) \n", offs, buffer[offs]*4, buffer[offs+1]);

          for (i=HEADERBYTES; i<(HEADERBYTES+DATABYTES); i++)
            drawbin_width(&buffer[offs+i], FONTWIDTH);

          offs+=(HEADERBYTES+DATABYTES);
          printf("--------\n");
        }
      }
    }
    
    fclose(fp);
  }
  
  return 0;
}
