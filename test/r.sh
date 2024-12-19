#Bryant Maritnez
#CWID: 886742121

echo "Compiling main.c"
gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

echo "Compiling manager.c"
gcc  -m64 -Wall -no-pie -o manager.o -std=c2x -c manager.c


echo "Assembling input_array.asm"
nasm -f elf64 -o input_array.o input_array.asm

echo "Assembling show_array.asm"
nasm -f elf64 -o show_array.o show_array.asm

echo "Assembling dot.asm"
nasm -f elf64 -o dot.o dot.asm

echo "Linking the object modules to create an executable file"
gcc -m64 -no-pie -o run main.o dot.o show_array.o input_array.o manager.o -std=c2x -Wall -z noexecstack -lm

./run 

echo "This bash script will now terminate."