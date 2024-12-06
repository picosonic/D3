#!/bin/bash

if [ $# -lt 2 ]
then
  echo "Specify two .vsf files to compare"
  exit 0
fi

vsfa="$1"
vsfb="$2"

dd if="${vsfa}" bs=1 skip=153 count=65536 2>/dev/null | hexdump -v -C > ${vsfa}.vsfcomp
dd if="${vsfb}" bs=1 skip=153 count=65536 2>/dev/null | hexdump -v -C > ${vsfb}.vsfcomp

meld ${vsfa}.vsfcomp ${vsfb}.vsfcomp 2>&1
rm ${vsfa}.vsfcomp ${vsfb}.vsfcomp >/dev/null 2>&1
