echo "Now assembling driver.asm"
nasm -f elf64 -o driver.o driver.asm

echo "Now assembling faraday.asm"
nasm -f elf64 -o faraday.o faraday.asm

echo "Now assembling strlen.asm"
nasm -f elf64 -o strlen.o strlen.asm

echo "Now assembling ftoa.asm"
nasm -f elf64 -o ftoa.o ftoa.asm

echo "Now assembling atof.asm"
nasm -f elf64 -o atof.o atof.asm

ld -o run driver.o faraday.o strlen.o ftoa.o atof.o -e _start

echo "Running Driver"
./run