#!/bin/sh

aarch64-linux-gnu-gcc code.S -o code.o -nostdlib
aarch64-linux-gnu-objcopy -O binary --only-section=.text code.o code.text

rm code.o
