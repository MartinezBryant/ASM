#Bryant Maritnez
#CWID: 886742121

echo "Compiling main.c"
gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c


echo "Assembling executive.asm"
nasm -f elf64 -o executive.o executive.asm

gcc -m64 -no-pie -o run main.o executive.o -std=c2x -Wall -z noexecstack -lm

./run