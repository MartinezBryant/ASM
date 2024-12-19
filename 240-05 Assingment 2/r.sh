#!/bin/bash

echo "Assemble the X86 file average.asm"
nasm -f elf64 -l average.lis -o average.o average.asm

echo "Assemble isfloat"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile the C file driver.c"
g++ -c -m64 -Wall -fno-pie -no-pie -o driver.o driver.c -std=c++17

echo "Link the files together"
g++ -m64 -fno-pie -no-pie -o driver driver.o average.o isfloat.o -std=c++17

echo "Program Driver Will Run"
./driver
