echo "Now assembling driver.asm"
nasm -f elf64 -o driver.o driver.asm

ld -o run driver.o 

echo "Running Driver"
./run


