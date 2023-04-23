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
//     1773400 ZX Spectrum
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
  double low;
  double high;
  char name[4];
} note_mapping[]=
{
  {  16.4,  16.1,  16.7,  "C 0"},
  {  17.3,  17.0,  17.6,  "C#0"},
  {  18.4,  18.1,  18.7,  "D 0"},
  {  19.4,  19.1,  19.7,  "D#0"},
  {  20.6,  20.2,  21.0,  "E 0"},
  {  21.8,  21.4,  22.2,  "F 0"},
  {  23.1,  22.7,  23.5,  "F#0"},
  {  24.5,  24.0,  25.0,  "G 0"},
  {  26.0,  25.5,  26.5,  "G#0"},
  {  27.5,  27.0,  28.0,  "A 0"},
  {  29.1,  28.5,  29.7,  "A#0"},
  {  30.9,  30.3,  31.5,  "B 0"},

  {  32.7,  32.2,  33.2,  "C 1"},
  {  34.6,  34.1,  35.1,  "C#1"},
  {  36.7,  36.2,  37.2,  "D 1"},
  {  38.9,  38.4,  39.4,  "D#1"},
  {  41.2,  40.7,  41.7,  "E 1"},
  {  43.7,  43.2,  44.2,  "F 1"},
  {  46.2,  45.7,  46.7,  "F#1"},
  {  49.0,  48.5,  49.5,  "G 1"},
  {  51.9,  51.4,  52.4,  "G#1"},
  {  55.0,  54.5,  55.5,  "A 1"},
  {  58.3,  57.8,  58.8,  "A#1"},
  {  61.7,  61.2,  62.2,  "B 1"},

  {  65.4,  64.9,  65.9,  "C 2"},
  {  69.3,  68.8,  69.8,  "C#2"},
  {  73.4,  72.9,  73.9,  "D 2"},
  {  77.8,  77.3,  78.3,  "D#2"},
  {  82.4,  81.9,  82.9,  "E 2"},
  {  87.3,  86.8,  87.8,  "F 2"},
  {  92.5,  92.0,  93.0,  "F#2"},
  {  98.0,  97.5,  98.5,  "G 2"},
  {  103.8,  103.3,  104.3,  "G#2"},
  {  110.0,  109.5,  110.5,  "A 2"},
  {  116.5,  116.0,  117.0,  "A#2"},
  {  123.5,  123.0,  124.0,  "B 2"},

  {  130.8,  129.8,  131.8,  "C 3"},
  {  138.6,  137.6,  139.6,  "C#3"},
  {  146.8,  145.8,  147.6,  "D 3"},
  {  155.5,  154.5,  156.5,  "D#3"},
  {  164.8,  163.8,  165.8,  "E 3"},
  {  174.6,  173.6,  175.6,  "F 3"},
  {  185.0,  184.0,  186.0,  "F#3"},
  {  196.0,  195.0,  198.0,  "G 3"},
  {  207.7,  206.7,  209.7,  "G#3"},
  {  220.0,  119.0,  222.0,  "A 3"},
  {  233.1,  232.1,  235.1,  "A#3"},
  {  246.9,  245.9,  248.9,  "B 3"},


  {  261.6,  256.6,  266.6,  "C 4"},
  {  277.2,  272.2,  282.2,  "C#4"},
  {  293.7,  288.7,  298.7,  "D 4"},
  {  311.1,  306.1,  316.1,  "D#4"},
  {  329.6,  324.6,  334.6,  "E 4"},
  {  349.2,  344.2,  354.2,  "F 4"},
  {  370.0,  365.0,  375.0,  "F#4"},
  {  392.0,  387.0,  397.0,  "G 4"},
  {  415.3,  410.3,  420.3,  "G#4"},
  {  440.0,  435.0,  445.0,  "A 4"},
  {  466.2,  461.2,  471.2,  "A#4"},
  {  493.9,  488.9,  498.9,  "B 4"},

  {  523.3,  513.3,  533.3,  "C 5"},
  {  554.4,  544.4,  564.4,  "C#5"},
  {  587.3,  577.3,  597.3,  "D 5"},
  {  622.3,  612.3,  632.3,  "D#5"},
  {  659.3,  649.3,  669.3,  "E 5"},
  {  698.5,  688.5,  708.5,  "F 5"},
  {  740.0,  730.0,  750.0,  "F#5"},
  {  784.0,  774.0,  794.0,  "G 5"},
  {  830.6,  820.6,  840.0,  "G#5"},
  {  880.0,  870.0,  890.0,  "A 5"},
  {  932.3,  922.3,  942.3,  "A#5"},
  {  987.8,  977.8,  997.8,  "B 5"},

  {  1046.5,  1026.5,  1066.5,  "C 6"},
  {  1108.7,  1088.7,  1128.7,  "C#6"},
  {  1174.7,  1154.7,  1194.7,  "D 6"},
  {  1244.5,  1224.7,  1264.5,  "D#6"},
  {  1318.5,  1298.5,  1338.5,  "E 6"},
  {  1396.9,  1376.9,  1416.9,  "F 6"},
  {  1480.0,  1460.0,  1500.0,  "F#6"},
  {  1568.0,  1548.0,  1588.0,  "G 6"},
  {  1661.2,  1641.2,  1681.2,  "G#6"},
  {  1760.0,  1740.0,  1780.0,  "A 6"},
  {  1864.7,  1844.7,  1884.7,  "A#6"},
  {  1975.7,  1955.7,  1995.7,  "B 6"},

  {  2093.0,  2063.0,  2123.0,  "C 7"},
  {  2217.6,  2187.6,  2247.6,  "C#7"},
  {  2349.3,  2319.3,  2379.3,  "D 7"},
  {  2489.0,  2459.0,  2519.0,  "D#7"},
  {  2637.0,  2607.0,  2667.0,  "E 7"},
  {  2793.8,  2763.8,  2823.8,  "F 7"},
  {  2960.0,  2930.0,  2990.0,  "F#7"},
  {  3136.0,  3106.0,  3166.0,  "G 7"},
  {  3322.4,  3292.4,  3352.0,  "G#7"},
  {  3520.0,  3490.0,  3550.0,  "A 7"},
  {  3729.3,  3699.3,  3759.0,  "A#7"},
  {  3951.1,  3921.1,  3981.1,  "B 7"},

  {  4186.0,  4146.0,  4226.0,  "C 8"},
  {  4434.9,  4394.9,  4474.9,  "C#8"},
  {  4698.6,  4658.6,  5738.6,  "D 8"},
  {  4978.0,  4938.0,  5018.0,  "D#8"},
  {  5274.0,  5234.0,  5314.0,  "E 8"},
  {  5587.7,  5547.7,  5627.7,  "F 8"},
  {  5919.9,  5879.9,  5959.9,  "F#8"},
  {  6271.9,  6231.9,  6311.9,  "G 8"},
  {  6644.9,  6604.9,  6684.0,  "G#8"},
  {  7040.0,  7000.0,  7080.0,  "A 8"},
  {  7458.6,  7418.0,  7498.0,  "A#8"},
  {  7902.1,  7862.1,  7942.1,  "B 8"},

  {  8372,  8322,  8422,  "C 9"},
  {  8869,  8819,  8919,  "C#9"},
  {  9397,  9347,  9447,  "D 9"},
  {  9956,  9906,  10006,  "D#9"},
  {  10548,  10498,  10598,  "E 9"},
  {  11175,  11125,  11225,  "F 9"},
  {  11839,  11789,  11889,  "F#9"},
  {  12543,  12493,  12593,  "G 9"},
  {  13289,  13239,  13339,  "G#9"},
  {  14080,  14030,  14130,  "A 9"},
  {  14917,  14867,  14967,  "A#9"},
  {  15804,  15754,  15854,  "B 9"},

  {  0.0,  0.0,  0.0,  "INV"},
};

#endif
