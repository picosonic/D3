#ifndef _YM6_H_
#define _YM6_H_

#define YM6_MAGIC "YM6!"
#define YM6_CHECKSTR "LeOnArD!"
#define YM6_ENDMARKER "End!"
#define YM6_REGS 16

#pragma pack(push,1)

struct ym6_header
{
  uint8_t id[4]; // File ID "YM6!
  uint8_t type[8]; // Check string "LeOnArD!"
  uint32_t frames; // No. of frames in the file
  uint32_t attrib; // Song attributes
  uint16_t digidrums; // No. of digidrum samples (can be 0)
  uint32_t clock; // YM Master clock in Hz
  uint16_t fps; // Original player frame in Hz (traditionally 50)
  uint32_t loopframe; // Frame to jump back to when looping (traditionally 0)
  uint16_t extralen; // Size in bytes of future additional data (skip it, usually 0)
};

#pragma pack(pop)

// Frame register names
//
//  r0 - 8-bit Period voice A
//  r1 - 4-bit Fine period voice A
//
//  r2 - 8-bit Period voice B
//  r3 - 4-bit Fine period voice B
//
//  r4 - 8-bit Period voice C
//  r5 - 4-bit Fine period voice C
//
//  r6 - 5-bit Noise period (pseudo random)
//  r7 - 6-bit Mixer control
//
//  r8 - 5-bit Volume control A
//  r9 - 5-bit Volume control B
// r10 - 5-bit Volume control C
//
// r11 - 8-bit Envelope high period
// r12 - 8-bit Envelope low period
// r13 - 4-bit Envelope shape
//
// r14 - 8-bit Extended data
// r15 - 8-bit Extended data

// The 12-bit period (pitch) value is treated as the frequency divider for the chip clock.
// With the full value being = ((4-bit value << 8) | 8-bit value)
// Then frequency = CLOCK / (16 * period)
//
//   YM Master clock in Hz examples:
//
//     2000000 Atari ST
//     1789772 MSX / Spectravideo
//     1773400 ZX Spectrum 128
//     1625000 ZX81
//     1000000 Amstrad CPC / Amstrad PCW
//
//  So the note range on the ZX Spectrum is between
//    (1773400 / (16*4095)) = 27 Hz = A0
//    (1773400 / (16*1)) = 110837 Hz
//
// A total of 8 envelope shapes were supported, including sawtooth and triangle, but only 1 envelope across all 3 voice channels.

static struct note_mapping_type
{
  double actual;
  double low;  // Calculated as midpoint to previous
  char name[4]; // Note name
} note_mapping[]=
{
  // Values in Hz
  { 16.35, 15.89, "C 0" }, // MIDI 13
  { 17.32, 0.0, "C#0" },
  { 18.35, 0.0, "D 0" },
  { 19.45, 0.0, "D#0" },
  { 20.6,  0.0, "E 0" },
  { 21.83, 0.0, "F 0" },
  { 23.12, 0.0, "F#0" },
  { 24.5,  0.0, "G 0" },
  { 25.96, 0.0, "G#0" },
  { 27.5,  0.0, "A 0" },
  { 29.14, 0.0, "A#0" },
  { 30.87, 0.0, "B 0" },

  { 32.7,  0.0, "C 1" }, // MIDI 25
  { 34.65, 0.0, "C#1" },
  { 36.71, 0.0, "D 1" },
  { 38.89, 0.0, "D#1" },
  { 41.2,  0.0, "E 1" },
  { 43.65, 0.0, "F 1" },
  { 46.25, 0.0, "F#1" },
  { 49.0,  0.0, "G 1" },
  { 51.91, 0.0, "G#1" },
  { 55.0,  0.0, "A 1" },
  { 58.27, 0.0, "A#1" },
  { 61.74, 0.0, "B 1" },

  { 65.41, 0.0, "C 2" }, // MIDI 37
  { 69.3,  0.0, "C#2" },
  { 73.42, 0.0, "D 2" },
  { 77.78, 0.0, "D#2" },
  { 82.41, 0.0, "E 2" },
  { 87.31, 0.0, "F 2" },
  { 92.5,  0.0, "F#2" },
  { 98.0,  0.0, "G 2" },
  { 103.8, 0.0, "G#2" },
  { 110.0, 0.0, "A 2" },
  { 116.5, 0.0, "A#2" }, // Beeb 0
  { 123.47, 0.0, "B 2" },

  { 130.81, 0.0, "C 3" }, // MIDI 49
  { 138.59, 0.0, "C#3" },
  { 146.83, 0.0, "D 3" },
  { 155.56, 0.0, "D#3" },
  { 164.81, 0.0, "E 3" },
  { 174.61, 0.0, "F 3" },
  { 185.0,  0.0, "F#3" },
  { 196.0,  0.0, "G 3" },
  { 207.65, 0.0, "G#3" },
  { 220.0,  0.0, "A 3" },
  { 233.08, 0.0, "A#3" },
  { 246.94, 0.0, "B 3" },

  { 261.63, 0.0, "C 4" }, // MIDI 61 ** MIDDLE C **
  { 277.18, 0.0, "C#4" },
  { 293.66, 0.0, "D 4" },
  { 311.13, 0.0, "D#4" },
  { 329.63, 0.0, "E 4" },
  { 349.23, 0.0, "F 4" },
  { 369.99, 0.0, "F#4" },
  { 392.0,  0.0, "G 4" },
  { 415.3,  0.0, "G#4" },
  { 440.0,  0.0, "A 4" },
  { 466.16, 0.0, "A#4" },
  { 493.88, 0.0, "B 4" },

  { 523.25, 0.0, "C 5" }, // MIDI 73
  { 554.37, 0.0, "C#5" },
  { 587.33, 0.0, "D 5" },
  { 622.25, 0.0, "D#5" },
  { 659.26, 0.0, "E 5" },
  { 698.46, 0.0, "F 5" },
  { 739.99, 0.0, "F#5" },
  { 783.99, 0.0, "G 5" },
  { 830.61, 0.0, "G#5" },
  { 880.0,  0.0, "A 5" },
  { 932.33, 0.0, "A#5" },
  { 987.77, 0.0, "B 5" },

  { 1046.5,  0.0, "C 6" }, // MIDI 85
  { 1108.73, 0.0, "C#6" },
  { 1174.66, 0.0, "D 6" },
  { 1244.51, 0.0, "D#6" },
  { 1318.51, 0.0, "E 6" },
  { 1396.91, 0.0, "F 6" },
  { 1479.98, 0.0, "F#6" },
  { 1567.98, 0.0, "G 6" },
  { 1661.22, 0.0, "G#6" },
  { 1760.0,  0.0, "A 6" },
  { 1864.66, 0.0, "A#6" },
  { 1975.53, 0.0, "B 6" },

  { 2093.0,  0.0, "C 7" }, // MIDI 97
  { 2217.46, 0.0, "C#7" },
  { 2349.32, 0.0, "D 7" },
  { 2489.02, 0.0, "D#7" },
  { 2637.02, 0.0, "E 7" },
  { 2793.83, 0.0, "F 7" },
  { 2959.96, 0.0, "F#7" },
  { 3135.96, 0.0, "G 7" },
  { 3322.44, 0.0, "G#7" },
  { 3520.0,  0.0, "A 7" },
  { 3729.31, 0.0, "A#7" },
  { 3951.07, 0.0, "B 7" },

  { 4186.01, 0.0, "C 8" }, // MIDI 109
  { 4434.92, 0.0, "C#8" },
  { 4698.64, 0.0, "D 8" }, // Beeb 252
  { 4978.03, 0.0, "D#8" },
  { 5274.04, 0.0, "E 8" },
  { 5587.65, 0.0, "F 8" },
  { 5919.91, 0.0, "F#8" },
  { 6271.93, 0.0, "G 8" },
  { 6644.88, 0.0, "G#8" },
  { 7040.0,  0.0, "A 8" },
  { 7458.62, 0.0, "A#8" },
  { 7902.13, 0.0, "B 8" },

  { 8372.02,  0.0, "C 9" }, // MIDI 121
  { 8869.84,  0.0, "C#9" },
  { 9397.27,  0.0, "D 9" },
  { 9956.06,  0.0, "D#9" },
  { 10548.08, 0.0, "E 9" },
  { 11175.3,  0.0, "F 9" },
  { 11839.82, 0.0, "F#9" },
  { 12543.85, 0.0, "G 9" },
  { 13289.75, 0.0, "G#9" },
  { 14080.0,  0.0, "A 9" },
  { 14917.24, 0.0, "A#9" },
  { 15804.27, 0.0, "B 9" }, // MIDI 134

  { 0.0, 0.0, "INV" },
};

#endif
