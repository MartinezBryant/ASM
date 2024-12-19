#include <stdio.h>

extern long array[];         // Declare the external array
extern long num_count;       // Declare the external count of numbers

void sort_array() {
    long temp;
    for (long i = 0; i < num_count - 1; i++) {
        for (long j = 0; j < num_count - i - 1; j++) {
            // Compare adjacent elements
            if (array[j] > array[j + 1]) {
                // Swap if they are in the wrong order
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}
