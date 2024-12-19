#!/bin/bash

echo "Now Assembling Manager.asm"
nasm -f elf64 -o manager.o manager.asm

echo "Now Assembling Isinteger.asm"
nasm -f elf64 -o isinteger.o isinteger.asm


echo "Now Compiling The Source File Main.c"
gcc -c -Wall -m64 -no-pie main.c -std=c2x -o main.o

echo "Now Linking All Files"
gcc -m64 -no-pie -o run  manager.o isinteger.o  main.o -std=c2x


echo "Running Array"
./run
