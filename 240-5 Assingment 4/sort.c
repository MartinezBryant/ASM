// Bryant Martinez
// CWID: 886742121

#include <stdio.h>

// Function prototype for sorting
void sort(double *array, int size);

// Implementation of bubble sort (or any other sorting algorithm)
void sort(double *array, int size) {
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (array[j] > array[j + 1]) {
                // Swap
                double temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}
