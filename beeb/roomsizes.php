<?php

$offsfile="RMTABLE";
$lh=fopen($offsfile, "rb");
$ls=filesize($offsfile);
$rooms=$ls/2;
$offs=fread($lh, $ls);
$offs=array_values(unpack(sprintf('v%d', $rooms), $offs));
fclose($lh);

for ($count=0; $count<($rooms-1); $count++)
{
  printf("$count = %X (%d)\n", $offs[$count], $offs[$count+1]-$offs[$count]);
}
?>
