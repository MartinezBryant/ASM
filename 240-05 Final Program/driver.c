#include <stdio.h>
#include <stdlib.h>

// Declare the external variable that holds the variance value
extern double variance_value;

// Declare the manager function which is implemented in assembly
extern void manager(void);

int main() {
    // Display the welcome message
    printf("Welcome to Variance Programming\n");

    // Display the introduction message
    printf("This program is maintained by Bryant Martinez\n");

    // Call manager to handle input, computations, and output
    manager();

    // Print the variance value returned from the assembly function
    printf("The variance is: %.2f\n", variance_value);

    printf("\nThe Program Will Now Return 0\n");

    printf("\n 0\n");

    return 0;
}
