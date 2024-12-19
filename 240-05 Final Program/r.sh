echo "Assemble the source file driver.C"
gcc  -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c

echo "Assemble the source file manager.asm"
nasm -f elf64 -o manager.o manager.asm

echo "Assemble the source file sum.asm"
nasm -f elf64 -o sum.o sum.asm

echo "Assemble the source file input_array.asm"
nasm -f elf64 -o input_array.o input_array.asm

echo "Assemble the source file output_array.asm"
nasm -f elf64 -o output_array.o output_array.asm

echo "Assemble the source file variance.asm"
nasm -f elf64 -o variance.o variance.asm

echo "Assemble the source file isinteger.asm"
nasm -f elf64 -o isinteger.o isinteger.asm

echo "Link the object files to create the executable"
gcc -m64 -no-pie -o run driver.o manager.o sum.o input_array.o output_array.o variance.o isinteger.o -std=c2x -Wall -z noexecstack -lm

echo "Now running program"
./run
