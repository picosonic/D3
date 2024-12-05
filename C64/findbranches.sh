#!/bin/bash

egrep '(BCC	\$|BCS	\$|BEQ	\$|BNE	\$|BMI	\$|BPL	\$|BVC	\$|BVS	\$)' "$1" | awk '{ print $NF }' | tr -d '$' | sort | uniq
