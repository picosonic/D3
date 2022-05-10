#!/bin/bash

workdir=$1

cd "${workdir}"

# Set filenames
img2beeb="img2beeb"
beebpal="dizzy3_beeb.pal"
beebscr="loadscr"
srcscr="dizzy3_loader_beeb.png"

# Check loader screen has changed before rebuilding it
beebdate=`stat -c %Y ${beebscr} 2>/dev/null`
srcdate=`stat -c %Y ${srcscr} 2>/dev/null`

# If no loader screen found, force build
if [ "${beebdate}" == "" ]
then
  beebdate=0
fi

# When source is newer, rebuild
if [ ${srcdate} -gt ${beebdate} ]
then
  if [ ! -x ${img2beeb} ]
  then
    echo "Can't find img2beeb"
    exit 1
  fi

  rm "${beebscr}" >/dev/null 2>&1
  ./${img2beeb} -f "${beebpal}" "${srcscr}" "${beebscr}"
fi

#beebasm -v -i downloader.asm
beebasm -v -i dizzy3.asm -do dizzy3.ssd -opt 3 -title 'DIZZY3'
