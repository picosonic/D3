#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <arpa/inet.h>

// https://github.com/deater/vmw-meter/blob/db80b56cfbaeb7c4278aeec3ecd860a84f870d6d/ay-3-8910/ymlib/ym_lib.c

#include "ym6.h"

struct ym6_header ym6header;
int interleaved=0;
unsigned char *framedata;
unsigned char frame[YM6_REGS];
unsigned char lastframe[YM6_REGS];

uint16_t lastanote=0;
uint16_t lastbnote=0;
uint16_t lastcnote=0;

uint16_t acounter=0;
uint16_t bcounter=0;
uint16_t ccounter=0;

int ym6_processheader(FILE *fp)
{
  if (fread(&ym6header, sizeof(ym6header), 1, fp)==0)
    return 1;

  if (strncmp((char *)&ym6header.id, YM6_MAGIC, strlen(YM6_MAGIC))!=0)
    return 1;

  printf("YM6 ID valid\n");

  if (strncmp((char *)&ym6header.type, YM6_CHECKSTR, strlen(YM6_CHECKSTR))!=0)
    return 1;

  printf("YM6 check string valid\n");

  // Swap numeric endianness from BE to host
  ym6header.frames=ntohl(ym6header.frames);
  ym6header.attrib=ntohl(ym6header.attrib);
  ym6header.digidrums=ntohs(ym6header.digidrums);
  ym6header.clock=ntohl(ym6header.clock);
  ym6header.fps=ntohs(ym6header.fps);
  ym6header.loopframe=ntohl(ym6header.loopframe);
  ym6header.extralen=ntohs(ym6header.extralen);

  interleaved=(ym6header.attrib & 0x01);

  printf("Frames : %u\n", ym6header.frames);
  printf("Attributes : %u\n", ym6header.attrib);
  printf("Interleaved : %d\n", interleaved);
  printf("Digidrum samples: %u\n", ym6header.digidrums);
  printf("YM master clock: %u Hz", ym6header.clock);
  if (ym6header.clock==2000000)
    printf(" (Atari ST)\n");
  else if (ym6header.clock==1773400)
    printf(" (ZX Spectrum)\n");
  else if (ym6header.clock==1789772)
    printf(" (MSX / Spectravideo)\n");
  else if (ym6header.clock==1625000)
    printf(" (ZX81)\n");
  else if (ym6header.clock==1000000)
    printf(" (Amstrad CPC / Amstrad PCW)\n");
  else
    printf("\n");
  printf("Player frame : %u Hz\n", ym6header.fps);
  printf("Loop frame : %u\n", ym6header.loopframe);
  printf("Additional data size : %u bytes\n", ym6header.extralen);

  return 0;
}

// Null terminated string
void ym6_processntstr(FILE *fp)
{
  uint8_t inp;

  if (fread(&inp, sizeof(inp), 1, fp)==0)
    return;

  while (inp!=0)
  {
    printf("%c", inp);

    if (fread(&inp, sizeof(inp), 1, fp)==0)
      return;
  }
}

void buildnotetable()
{
  int i = 0;

  while (1)
  {
    // Check for end terminator
    if (note_mapping[i].actual==0.0) break;

    // Check for missing low value
    if (note_mapping[i].low==0.0)
      note_mapping[i].low=note_mapping[i-1].actual+((note_mapping[i].actual-note_mapping[i-1].actual)/2);

    i++;
  }
}

void ym6_notes(const uint16_t divider, const uint16_t lastdivider, uint16_t *counter)
{
  double freq = ym6header.clock / (16.0 * (double)divider);
  double lastfreq = ym6header.clock / (16.0 * (double)lastdivider);
  int i = 0;
  int j = 0;

  if (divider==0)
  {
    printf("  --- ");
    return;
  }

  // Calculate current note from divider
  while (1)
  {
    if (note_mapping[i].actual==0.0) break;

    if (note_mapping[i].low>freq)
    {
      i--;
      break;
    }

    i++;
  }

  // Calculate previous note from divider
  while (1)
  {
    if (note_mapping[j].actual==0.0) break;

    if (note_mapping[j].low>lastfreq)
    {
      j--;
      break;
    }

    j++;
  }

  if (i!=j)
  {
    printf("  %s ", note_mapping[i].name);
    *counter=0; // Reset counter due to note change
  }
  else
  {
    printf("  ... ");

    *counter=*counter+1; // Advance counter due to note staying same
  }
}

void ym6_processframe(const uint32_t framenum, unsigned char *frame)
{
  int i;
  uint16_t note;

  printf("%.6u : ", framenum);

  for (i=0; i<YM6_REGS; i++)
  {
    if ((framenum==0) || (frame[i]!=lastframe[i]))
      printf("%.2x ", frame[i]);
    else
      printf("-- ");
  }

  // Print equivalent note names
  note=((frame[1]&0x0f)<<8) | frame[0]; ym6_notes(note, lastanote, &acounter); lastanote=note; // A
  note=((frame[3]&0x0f)<<8) | frame[2]; ym6_notes(note, lastbnote, &bcounter); lastbnote=note; // B
  note=((frame[5]&0x0f)<<8) | frame[4]; ym6_notes(note, lastcnote, &ccounter); lastcnote=note; // C

  printf("\n");

  memcpy(lastframe, frame, sizeof(lastframe));
}

void ym6_processframes(FILE *fp)
{
  uint32_t i;

  // Allocate memory
  framedata=malloc(ym6header.frames*YM6_REGS);
  if (framedata==NULL) return;

  // Load data in
  if (fread(framedata, (ym6header.frames*YM6_REGS), 1, fp)==0)
  {
    free(framedata);
    return;
  }

  for (i=0; i<ym6header.frames; i++)
  {
    int j;

    for (j=0; j<YM6_REGS; j++)
    {
      if (interleaved==0x01)
        frame[j]=framedata[(j*ym6header.frames)+i];
      else
        frame[j]=framedata[(i*YM6_REGS)+j];
    }

    ym6_processframe(i, frame);
  }

  // Free memory
  free(framedata);
}

void ym6_processend(FILE *fp)
{
  uint8_t endmarker[4];

  if (fread(endmarker, sizeof(endmarker), 1, fp)==0)
    return;

  if (strncmp((char *)&endmarker, YM6_ENDMARKER, strlen(YM6_ENDMARKER))!=0)
    printf("End not found\n");
  else
    printf("End found\n");
}

int main(int argc, char **argv)
{
  FILE *fp;

  if (argc!=2)
  {
    printf("Specify .ym6 on command line\n");
    return 1;
  }

  fp=fopen(argv[1], "rb");
  if (fp==NULL)
  {
    printf("Unable to open file\n");
    return 2;
  }

  if (ym6_processheader(fp)!=0)
  {
    fclose(fp);
    return 3;
  }

  // Not supported at the moment
  if (ym6header.digidrums>0)
  {
    fclose(fp);
    return 4;
  }

  buildnotetable();

  printf("Song name : \"");
  ym6_processntstr(fp);
  printf("\"\n");

  printf("Author name : \"");
  ym6_processntstr(fp);
  printf("\"\n");

  printf("Song comment : \"");
  ym6_processntstr(fp);
  printf("\"\n");

  printf("Song length : %u seconds\n", (ym6header.frames/ym6header.fps));

  printf("         PA FA PB FB PC FC PN MX VA VB VC EH EL ES XD XD\n");
  ym6_processframes(fp);
  printf("         PA FA PB FB PC FC PN MX VA VB VC EH EL ES XD XD\n");

  ym6_processend(fp);

  fclose(fp);

  return 0;
}
