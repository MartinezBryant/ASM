// Bryant Martinez 
// Bryantmartinez322@csu.fullert.edu
// 10/17/2024
// Course Id: CPSC240-5
// CWID: 886742121
// Purpose of Assingment: Input two arrays and find the dot product between both

#include <stdio.h>

// Declare the manager function
extern double dot(double* arrayA, double* arrayB, int length);

int main() {
    printf("\nWelcome To Dot Product Production\n");
    printf("This program is run by Bryant Martinez\n");

    int length = 3; // size of the array
    double arrayA[] = {4.5, 2.2, 3.0}; // Declare and initialize the first array with double values
    double arrayB[]= {1.0, 7.5, 2.3}; // Declare and initialize the second array with double values

    double result = dot(arrayA, arrayB, length);// Print the result of the dot product
    
    printf("\nDot product result: %.2f\n", result);
    printf("The program will now execute 0. Bye!\n");
    return 0;
}
