#!/bin/bash

# Define the output executable name
OUTPUT_EXEC="marvelous_arrays"

# Define the source files
SRC_FILES="main.c sort.c manager.asm input_array.asm output_array.asm sum.asm"

# Compile the source files
echo "Compiling the source files..."
gcc -o $OUTPUT_EXEC $SRC_FILES -no-pie

# Check if the compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful. Running the program..."
    ./$OUTPUT_EXEC   # Run the executable
else
    echo "Compilation failed. Please check for errors."
fi
