#!/bin/bash

dd if=${1}.uef bs=1 skip=338 count=65535 | hexdump -v -C > ${1}.hex
