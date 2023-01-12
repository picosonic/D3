#!/bin/bash

workdir=$1

cd "${workdir}"

# Set pixel resolution
xmax=256
ymax=192

##############################################################

# Set filenames
img2beeb="img2beeb"
exo="exomizer"
beebpal="dizzy3_beeb.pal"
beebscr="loadscr"
exoscr="XSCR"
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
    make img2beeb

    if [ ! -x ${img2beeb} ]
    then
      echo "Can't find img2beeb"
      exit 1
    fi
  fi

  if [ ! -x ${exo} ]
  then
    echo "Can't find exomizer"
    exit 1
  fi

  # Remove old screen
  rm "${beebscr}" >/dev/null 2>&1

  # Convert from image to beeb format
  ./${img2beeb} -f "${beebpal}" -d1 -X${xmax} -Y${ymax} "${srcscr}" "${beebscr}"

  # Compress beeb format with exomizer
  #
  # -c required when LITERAL_SEQUENCES_NOT_USED = 1
  # -M256 required when MAX_SEQUENCE_LENGTH_256 = 1
  # -P+16 required when EXTRA_TABLE_ENTRY_FOR_LENGTH_THREE = 1
  # -P-32 required when DONT_REUSE_OFFSET = 1
  # -f required when DECRUNCH_FORWARDS = 1

  ./${exo} level -M256 -P+16-32 -c ${beebscr}@0x0000 -o ${exoscr}
fi

##############################################################

# Set filenames
img2beeb="img2beeb"
beebpal="dizzy2_beeb.pal"
beebscr="TREPIC"
srcscr="dizzy2_picture.png"

# Check screen has changed before rebuilding it
beebdate=`stat -c %Y ${beebscr} 2>/dev/null`
srcdate=`stat -c %Y ${srcscr} 2>/dev/null`

# If no screen found, force build
if [ "${beebdate}" == "" ]
then
  beebdate=0
fi

# When source is newer, rebuild
if [ ${srcdate} -gt ${beebdate} ]
then
  if [ ! -x ${img2beeb} ]
  then
    make img2beeb

    if [ ! -x ${img2beeb} ]
    then
      echo "Can't find img2beeb"
      exit 1
    fi
  fi

  if [ ! -x ${exo} ]
  then
    echo "Can't find exomizer"
    exit 1
  fi

  # Remove old screen
  rm "${beebscr}" >/dev/null 2>&1

  # Convert from image to beeb format
  ./${img2beeb} -f "${beebpal}" -d1 -X${xmax} -Y${ymax} "${srcscr}" "${beebscr}"
fi

##############################################################

beebasm -v -i exoloader.asm
beebasm -v -i melody.asm
beebasm -v -i speech.asm
beebasm -v -i roomdata.asm
beebasm -v -i dizzy3.asm -do dizzy3.ssd -opt 3 -title 'DIZZY3'

##############################################################

echo

swrsize=`stat -c %s "RMDATA"`
maxsize=$((16*1024))
bytesleft=$((${maxsize}-${swrsize}))
percent=$((200*${swrsize}/${maxsize} % 2 + 100*${swrsize}/${maxsize}))

if [ ${bytesleft} -ge 0 ]
then
  echo "SWR is ${percent}% used - ( ${bytesleft} bytes left )"
else
  echo "OH NO - SWR is ${percent}% used - it's gone ovey by "$((0-${bytesleft}))" bytes"
fi

echo
