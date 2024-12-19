#!/bin/bash

echo "Now Assembling Execute"
nasm -f elf64 -o execute.o execute.asm

echo "Now Assembling fill_random_array.asm"
nasm -f elf64 -o fill_random_array.o fill_random_array.asm

echo "Now Assembling isnan.asm"
nasm -f elf64 -o isnan.o isnan.asm

echo "Now Assembling normalize_array.asm"
nasm -f elf64 -o normalize_array.o normalize_array.asm


echo "Now Assembling show_array.asm"
nasm -f elf64 -o show_array.o show_array.asm

echo "Now Compiling The Source File Main.c"
gcc -c -Wall -m64 -no-pie main.c -std=c2x -o main.o

echo "Now Compiling The Source File sort.c"
gcc -c -Wall -m64 -no-pie sort.c -std=c2x -o sort.o

echo "Now Linking All Files"
gcc -m64 -no-pie -o run  main.o sort.o execute.o show_array.o fill_random_array.o normalize_array.o isnan.o -std=c2x

echo "Running Array"
./run
