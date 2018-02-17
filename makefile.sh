#!/bin/sh

if [ $# -lt 3 ]; then
	echo "Usage: $0 [kernel file] [ramdisk file] [output file]"
	exit 1
fi

if [ ! -f  "$1" ]; then
    echo "Kernel File not found!"
	exit 1
fi

if [ ! -f  "$2" ]; then
    echo "Ramdisk File not found!"
	exit 1
fi

if [ -f  "$3" ]; then
    echo "Output File already exists!"
	exit 1
fi

fallocate -l 67108864 "$3"

echo -ne "\xDE\xC0\xDE\xC0\x00\x00\x00\x00" | dd of="$3" bs=1 seek=0 conv=notrunc,noerror
echo -ne "KERNELY" | dd of="$3" bs=1 seek=8 conv=notrunc,noerror
echo -ne "INITCPIO" | dd of="$3" bs=1 seek=16 conv=notrunc,noerror

dd if="code.text" of="$3" bs=1 seek=512 conv=notrunc,noerror

dd if="$1" of="$3" bs=1 seek=4096 conv=notrunc,noerror
dd if="$2" of="$3" bs=1 seek=33554432 conv=notrunc,noerror
