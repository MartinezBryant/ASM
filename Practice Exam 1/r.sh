
echo "Compiling main.c"
gcc -m64 -Wall -no-pie -o main.o main.c -std=c2x

echo "Assembling current.asm"
nasm -f elf64 -o current.o current.asm

echo "Assembling electricity.asm"
nasm -f elf64 -o electricity.o electricity.asm

echo "Linking all o files"
gcc -m64 -no-pie -o volt.shock main.o electricity.o -std=c2x 

echo "Volt.Shock will now run"
./volt.shock


