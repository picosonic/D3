<?php

// Consts
$NOTES_IN_OCTAVE=12;

// YM6
$YM6_MAGIC="YM6!";
$YM6_CHECKSTR="LeOnArD!";
$YM6_ENDMARKER="End!";
$YM6_REGS=16;
$YM6_CHANS=3;

// Output codes
$code_stop=0xff;
$code_restart=0xfe;
$code_sustain_conf=0xfd;
$code_sustain=0xfc;
$code_notelen=0xfb;

// Frequencies in Hz
//
// Subsequent octave is current octave Hz * 2
//
// Beeb   0 = A#2 (MIDI 47)
// Beeb 252 = D 8 (MIDI 111)
//
$freqs=[
  16.3516, // C 0  (MIDI 12)
  17.3239, // C#0
  18.3540, // D 0
  19.4454, // D#0
  20.6017, // E 0
  21.8268, // F 0
  23.1247, // F#0
  24.4997, // G 0
  25.9565, // G#0
  27.5000, // A 0
  29.1352, // A#0
  30.8677  // B 0
];

$notenames=[
"C ",
"C#",
"D ",
"D#",
"E ",
"F ",
"F#",
"G ",
"G#",
"A ",
"A#",
"B "
];

// To store the mid point of the Hz value
$freqs_low=[15.8927];

$melody=array();
$lastdivider=[0, 0, 0]; // Last calculated note per channel

// Defaults
$frames=0;
$attrib=0;
$digidrums=0;
$clock=0;
$fps=0;
$loopframe=0;
$extralen=0;
$interleaved=false;

// File handle
$file=null;

function parsenum($bytes, $pos, $len)
{
  $retval=0;

  for ($i=0; $i<$len; $i++)
    $retval=($retval<<8) | unpack("C", $bytes[$pos+$i])[1];

  return $retval;
}

function parsestr()
{
  global $file;

  $out="";

  $char=fgetc($file);

  while (ord($char)!=0)
  {
    $out.=$char;
    $char=fgetc($file);
  }

  return $out;
}

function ym6_notes($divider, $channel)
{
  global $lastdivider;
  global $clock;
  global $freqs;
  global $freqs_low;
  global $NOTES_IN_OCTAVE;
  global $notenames;

  $freq=$clock/(16.0*$divider);
  $lastfreq=$clock/(16.0*$lastdivider[$channel]);

  $lastdivider[$channel]=$divider;

  if ($divider==0)
  {
    printf("  --- ");
    return;
  }

  $i=0; $j=0;

  // Calculate note from divider
  for ($i=0; $i<count($freqs); $i++)
  {
    if ($freqs_low[$i]>$freq)
    {
      $i--;
      break;
    }
  }

  // Calculate previous note from divider
  for ($j=0; $j<count($freqs); $j++)
  {
    if ($freqs_low[$j]>$lastfreq)
    {
      $j--;
      break;
    }
  }

  if ($i!=$j)
  {
    printf("  %s%01d ", $notenames[floor($i%$NOTES_IN_OCTAVE)], floor($i/$NOTES_IN_OCTAVE));
  }
  else
    printf("  --- ");
}

// Check filename was specified on command line
if ($argc<=1)
{
  echo "Specify YM6 file on command line\n";
  exit(0);
}

// Extend frequency table, and interpolate
for ($octave=0; $octave<10; $octave++)
{
  for ($note=0; $note<$NOTES_IN_OCTAVE; $note++)
  {
    if ($octave>0)
      $freqs[($octave*$NOTES_IN_OCTAVE)+$note]=$freqs[(($octave-1)*$NOTES_IN_OCTAVE)+$note]*2;

    // Add mid frequency
    if (($octave>0) || ($note>0))
      $freqs_low[($octave*$NOTES_IN_OCTAVE)+$note]=$freqs[($octave*$NOTES_IN_OCTAVE)+$note-1]+(($freqs[($octave*$NOTES_IN_OCTAVE)+$note]-$freqs[($octave*$NOTES_IN_OCTAVE)+$note-1])/2);
  }
}

// Parse ym6 file into frame array
if ($file=fopen($argv[1], "r"))
{
  // Read header
  $header=fread($file, 34);
  $spos=0;

  // Validate header
  $magic=substr($header, 0, strlen($YM6_MAGIC));
  if ($magic!=$YM6_MAGIC)
  {
    echo "Invalid magic\n";
    fclose($file);
    exit(0);
  }
  echo "YM6 ID valid\n";

  $checkstr=substr($header, strlen($YM6_MAGIC), strlen($YM6_CHECKSTR));
  if ($checkstr!=$YM6_CHECKSTR)
  {
    echo "Invalid checkstr\n";
    fclose($file);
    exit(0);
  }
  echo "YM6 check string valid\n";

  $frames=parsenum($header, 12, 4);
  $attrib=parsenum($header, 16, 4);
  $digidrums=parsenum($header, 20, 2);
  $clock=parsenum($header, 22, 4);
  $fps=parsenum($header, 26, 2);
  $loopframe=parsenum($header, 28, 4);
  $extralen=parsenum($header, 32, 2);
  $interleaved=($attrib & 0x01);

  echo "Frames : $frames\n";
  echo "Attributes : $attrib\n";
  echo "Interleaved : $interleaved\n";
  echo "Digidrum samples: $digidrums\n";
  echo "YM master clock: $clock Hz";
  if ($clock==2000000)
    echo " (Atari ST)\n";
  else if ($clock==1773400)
    echo " (ZX Spectrum)\n";
  else if ($clock==1789772)
    echo " (MSX / Spectravideo)\n";
  else if ($clock==1625000)
    echo " (ZX81)\n";
  else if ($clock==1000000)
    echo " (Amstrad CPC / Amstrad PCW)\n";
  else
    echo "\n";
  echo "Player frame : $fps Hz\n";
  echo "Loop frame : $loopframe\n";
  echo "Additional data size : $extralen bytes\n";

  // Check for drums (not supported at the moment)
  if ($digidrums>0)
  {
    fclose($file);
    exit(0);
  }

  // Build note table

  // Get song name
  echo "Song name : \"".parsestr()."\"\n";

  // Get author name
  echo "Author name : \"".parsestr()."\"\n";

  // Get song comment
  echo "Song comment : \"".parsestr()."\"\n";

  echo "Song length : ".($frames/$fps)." seconds\n";

  // Process frames
  echo "         PA FA PB FB PC FC PN MX VA VB VC EH EL ES XD XD\n";

  $framedata=fread($file, ($frames*$YM6_REGS));
  $framedata=unpack("C*", $framedata); // Convert from string to byte array
  $frame=[];
  $lastframe=[];

  for ($framenum=0; $framenum<$frames; $framenum++)
  {
    $lastframe=$frame;
    $frame=[];

    printf("%06u : ", $framenum);
    for ($j=0; $j<$YM6_REGS; $j++)
    {
      if ($interleaved==0x1)
        $frame[$j]=$framedata[1+($j*$frames)+$framenum];
      else
        $frame[$j]=$framedata[1+($framenum*$YM6_REGS)+$j];

      // Display all changed regs
      if (($framenum==0) || ($frame[$j]!=$lastframe[$j]))
        printf("%02X ", $frame[$j]);
      else
        printf("-- ");
    }

    // Determine equivalent note value
    $divider=(($frame[1]&0x0f)<<8) | $frame[0]; ym6_notes($divider, 0); // A
    $divider=(($frame[3]&0x0f)<<8) | $frame[2]; ym6_notes($divider, 1); // B
    $divider=(($frame[5]&0x0f)<<8) | $frame[4]; ym6_notes($divider, 2); // C

    echo "\n";
  }
  
  echo "         PA FA PB FB PC FC PN MX VA VB VC EH EL ES XD XD\n";

  fclose($file);
}

?>
