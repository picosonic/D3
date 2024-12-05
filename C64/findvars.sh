#!/bin/bash

egrep '(LDA	\$|LDY	\$|LDX \$|CMP	\$|CPY	\$|CPX	\$|INC	\$|DEC	\$|ROR	\$|ROL	\$|LSR	\$|ASL	\$|SBC	\$|ADC	\$|EOR	\$|AND	\$|ORA	\$|BIT	\$|STA	\$|STY	\$|STX	\$)' "$1" | awk '{ print $NF }' | awk -F',' '{ print $1 }' | tr -d '$' | sed -r 's/(^..$)/00\1/g' | sort | uniq
