#!/bin/bash

rm memdump.hex built.hex 2>/dev/null

./make.sh

hexdump -C -v c64_built > built.hex
hexdump -C -v c64_memdump > memdump.hex

meld memdump.hex built.hex
