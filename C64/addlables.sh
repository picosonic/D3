#!/bin/bash

dizzydasm="dizzy.dasm"

./findjumps.sh "${dizzydasm}" > targets
./findbranches.sh "${dizzydasm}" >> targets
./findvars.sh "${dizzydasm}" > foundvars

cat targets | sort | uniq > labels
rm targets

exec < "${dizzydasm}"
read -r inp

while [ "$inp" != "" ]
do
  # Determine address
  addr=`echo "${inp}" | awk '{ print $1 }'`

  # See if the address is a variable
  LC_ALL=C grep -q "^${addr}$" foundvars
  if [ $? -eq 0 ]
  then
    echo "				.v${addr}"
  fi

  # See if the address is a target
  LC_ALL=C grep -q "^${addr}$" labels
  if [ $? -eq 0 ]
  then
    echo "				.l${addr}"
  fi

  # Output current line
  echo "${inp}" | sed 's/JMP	\$/JMP	l/g' | sed 's/JSR	\$/JSR	l/g' | sed 's/BCC	\$/BCC	l/g' | sed 's/BCS	\$/BCS	l/g' | sed 's/BEQ	\$/BEQ	l/g' | sed 's/BNE	\$/BNE	l/g' | sed 's/BMI	\$/BMI	l/g' | sed 's/BPL	\$/BPL	l/g' | sed 's/BVC	\$/BVC	l/g' | sed 's/BVS	\$/BVS	l/g'

  # Read next line
  read -r inp
done
