#!/bin/bash

# Check if user provided a filename
if [ -z "$1" ]; then
    echo "Usage: $0 <filename_without_extension>"
    exit 1
fi

FILENAME="$1"

# Assemble
nasm -f elf32 "${FILENAME}.asm" -o "${FILENAME}.o"
if [ $? -ne 0 ]; then
    echo "Assembly failed."
    exit 1
fi

# Link
ld -m elf_i386 "${FILENAME}.o" -o "$FILENAME"
if [ $? -ne 0 ]; then
    echo "Linking failed."
    exit 1
fi

# Run
echo "Running ./$FILENAME"
./"$FILENAME"
