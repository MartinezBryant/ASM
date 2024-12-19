// Bryant Martinez 
// CWID: 886742121

#include <stdio.h>
#include <stdlib.h>

// Function prototypes
void input_array(float *array, int size);
void show_array(const float *array, int size);
extern float dot(float *array1, float *array2, int size); // Declare the assembly function

double manager() {
    int size; // store the size of the array

    // Prompt the user to enter the size of the arrays
    printf("Enter the size of the arrays: ");
    scanf("%d", &size);

    // Allocate memory for arrays
    float *array1 = (float *)malloc(size * sizeof(float));
    float *array2 = (float *)malloc(size * sizeof(float));

    // Input the arrays A
    printf("Input first array:\n");
    input_array(array1, size);
    // Input the arrays B
    printf("Input second array:\n");
    input_array(array2, size);

    // Compute dot product
    float result = dot(array1, array2, size);

    // Output the arrays
    show_array(array1, size);
    show_array(array2, size);

    // Free allocated memory
    free(array1);
    free(array2);

    return result;  // Return the result of the dot product
}
