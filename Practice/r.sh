#bash! 

echo "Assebling Manager.asm"
nasm -f elf64 -o manager.o manager.asm

echo "Assebling input_array.asm"
nasm -f elf64 -o input_array.o input_array.asm

echo "Assebling output_array.asm"
nasm -f elf64 -o output_array.o output_array.asm

echo "Compiling Main.c"
gcc -m64 -Wall -no-pie -o main.o main.c -std=c2x

echo "Compiling sum.c"
gcc -m64 -Wall -no-pie -o sum.o sum.c -std=c2x

echo "Linking The Files"
gcc -m64 -no-pie -o run manager.o input_array.o output_array.o main.o sum.o -std=c2x

echo "Running Program"
./run
