#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define NUMROOMS 102

int main()
{
  FILE *rd;
  struct stat fs;
  uint8_t *roomdata;
  int i, j, k;
  int start, end;

  rd=fopen("roomdata.bin", "rb");
  if (rd==NULL) return 1;

  fstat(fileno(rd), &fs);
  roomdata=malloc(fs.st_size);

  if (roomdata!=NULL)
  {
    fread(roomdata, fs.st_size, 1, rd);
    fclose(rd);

    // Process it
    for (i=0; i<(NUMROOMS-1); i++)
    {
      start=(roomdata[i*2]);
      start=((roomdata[(i*2)+1]<<8)+start);

      end=(roomdata[(i+1)*2]);
      end=((roomdata[((i+1)*2)+1]<<8)+end);

      if (end!=start)
      {
        printf("%d : 0x%.4x to 0x%.4x (len %d)\n", i, start, end, end-start);

        printf("  ");

        for (j=start; j<end; j+=3)
        {
          printf("[%.2x ", roomdata[(NUMROOMS*2)+j]);
          printf("%dx%d", (roomdata[(NUMROOMS*2)+j+1])*2, roomdata[(NUMROOMS*2)+j+2]);
          if (!(roomdata[(NUMROOMS*2)+j+1] & 0x80))
          {
            printf(" 0x%.2x]", roomdata[(NUMROOMS*2)+j+3]);
            j++;
          }
          else
            printf("]");
        }

        printf("\n");
      }
    }

    free(roomdata);
  }
  else
  {
    fclose(rd);

    return 1;
  }

  return 0;
}
