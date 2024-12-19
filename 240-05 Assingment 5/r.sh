# Bryant Martinez
# CWID: 886742121

echo "Compiling main.c"                   # Compile the C source file 'main.c' into an object file 'main.o'
gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

echo "Assembling series.asm"             # Assemble the assembly source file 'series.asm' into 'series.o'
nasm -f elf64 -o series.o series.asm

echo "Assembling taylor.asm"             # Assemble the assembly source file 'taylor.asm' into 'taylor.o'
nasm -f elf64 -o taylor.o taylor.asm

echo "Now linking all files"            # Link all object files ('main.o', 'series.o', 'taylor.o') into a final executable
gcc -m64 -no-pie -o run main.o series.o taylor.o -std=c2x -Wall -z noexecstack -lm

echo "Running Program"                   # Run the compiled executable 'run'
./run
