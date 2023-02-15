#!/bin/bash

workdir="$1"

cd "${workdir}"

# Set pixel resolution
xmax=256
ymax=192

# Tool names
img2beeb="./img2beeb"
exo="./exomizer"
beebasm="beebasm"

##############################################################

function refreshrequired()
{
  local target="$1"
  local targettime=`stat -c %Y ${target} 2>/dev/null`

  if [ "${targettime}" == "" ]
  then
    return 0
  fi
  
  for var in "$@"
  do
    local source="$var"
    local sourcetime=`stat -c %Y ${source} 2>/dev/null`
    
    if [ ${sourcetime} -gt ${targettime} ]
    then
      return 0
    fi
  done

  return 1
}

##############################################################

# Set filenames
srcscr="dizzy3_loader_beeb.png"
beebpal="dizzy3_beeb.pal"
beebscr="loadscr"
exoscr="XSCR"

# When source is newer, rebuild
if refreshrequired ${exoscr} ${beebpal} ${srcscr} ${beebscr}
then
  if [ ! -x ${img2beeb} ]
  then
    make ${img2beeb}

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
  ${img2beeb} -f "${beebpal}" -d1 -X${xmax} -Y${ymax} "${srcscr}" "${beebscr}"

  # Compress beeb format with exomizer
  #
  # -c required when LITERAL_SEQUENCES_NOT_USED = 1
  # -M256 required when MAX_SEQUENCE_LENGTH_256 = 1
  # -P+16 required when EXTRA_TABLE_ENTRY_FOR_LENGTH_THREE = 1
  # -P-32 required when DONT_REUSE_OFFSET = 1
  # -f required when DECRUNCH_FORWARDS = 1

  ${exo} level -M256 -P+16-32 -c ${beebscr}@0x0000 -o ${exoscr}
fi

##############################################################

# Set filenames
srcscr="dizzy2_picture.png"
beebpal="dizzy2_beeb.pal"
beebscr="TREPIC"

# When source is newer, rebuild
if refreshrequired ${beebscr} ${beebpal} ${srcscr}
then
  if [ ! -x ${img2beeb} ]
  then
    make ${img2beeb}

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
  ${img2beeb} -f "${beebpal}" -d1 -X${xmax} -Y${ymax} "${srcscr}" "${beebscr}"
fi

##############################################################

# Build exomiser'd loader screen loader if required
if refreshrequired EXOSCR os.asm consts.asm exomizer310decruncher.h.asm exomizer310decruncher.asm XSCR exoloader.asm
then
  ${beebasm} -v -i exoloader.asm
fi

# Build melody if required
if refreshrequired MELODY os.asm consts.asm internal.asm inkey.asm input.asm M02C1.bin M02C2.bin melody.asm
then
  ${beebasm} -v -i melody.asm
fi

# Build speech if required
if refreshrequired SPEECH os.asm consts.asm speech.bin speech.asm
then
  ${beebasm} -v -i speech.asm
fi

# Build roomdata if required
if refreshrequired RMDATA os.asm consts.asm rooms/room*.bin roomdata.asm
then
  ${beebasm} -v -i roomdata.asm

  echo

  swrsize=`stat -c %s "RMDATA"`
  maxsize=$((16*1024))
  bytesleft=$((${maxsize}-${swrsize}))
  percent=$((200*${swrsize}/${maxsize} % 2 + 100*${swrsize}/${maxsize}))

  if [ ${bytesleft} -ge 0 ]
  then
    echo "SWR A is ${percent}% used - ( ${bytesleft} bytes left )"
  else
    echo "OH NO - SWR A is ${percent}% used - it's gone ovey by "$((0-${bytesleft}))" bytes"
    exit 1
  fi

  echo
fi

# Build moredata if required
if refreshrequired XDATA os.asm consts.asm dizzyfrm.asm moredata.asm
then
  ${beebasm} -v -i moredata.asm

  echo

  swrsize=`stat -c %s "XDATA"`
  maxsize=$((16*1024))
  bytesleft=$((${maxsize}-${swrsize}))
  percent=$((200*${swrsize}/${maxsize} % 2 + 100*${swrsize}/${maxsize}))

  if [ ${bytesleft} -ge 0 ]
  then
    echo "SWR B is ${percent}% used - ( ${bytesleft} bytes left )"
  else
    echo "OH NO - SWR B is ${percent}% used - it's gone ovey by "$((0-${bytesleft}))" bytes"
    exit 1
  fi

  echo
fi

# Append loader asm to BASIC
if refreshrequired loadertok.bin loader.bas loader2.asm loader.asm
then
  # Tokenise the BASIC
  ${beebasm} -v -i loader.asm -do loader.ssd 2>/dev/null

  # Determine how big the tokenised BASIC file is from DFS catalogue
  baslen=`dd if=loader.ssd bs=1 count=2 skip=268 2>/dev/null | hexdump -C | head -1 | awk '{ print $3$2 }'`

  # Extract tokenised BASIC from disc image, then remove image
  dd if=loader.ssd bs=1 count=$((0x${baslen})) skip=512 > loadertok.bin 2>/dev/null
  rm loader.ssd >/dev/null 2>&1
fi

# Build main disk image if required
if refreshrequired dizzy3.ssd os.asm inkey.asm internal.asm consts.asm vars.asm varcode.asm rooms.asm frametable.bin framedefs.bin dizzyfrm.asm input.asm rand.asm gfx.asm objects.asm extra.asm hearts.asm loadertok.bin dizzy3.asm XDATA RMDATA
then
  ${beebasm} -v -i dizzy3.asm -do dizzy3.ssd -opt 3 -title 'DIZZY3'
fi
