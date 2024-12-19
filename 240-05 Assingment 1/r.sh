#!/bin/bash

echo "Compile welcome.cpp"
g++ -c -Wall -m64 -no-pie welcome.cpp -std=c++2a -o welcome.o

echo "Assemble hello"
nasm -f elf64 -o hello.o hello.asm

echo "Linking files"
g++ -m64 -no-pie -o welcome welcome.o hello.o

echo "Running the program"
./welcome
