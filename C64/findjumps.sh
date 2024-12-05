#!/bin/bash

egrep '(JSR	|JMP	)' "$1" | awk '{ print $NF }' | tr -d '$' | sort | uniq

