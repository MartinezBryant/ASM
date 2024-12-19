// Bryant Martinez 
// Bryantmartinez322@csu.fullert.edu
// 11/24/2024
// Course Id: CPSC240-5
// CWID: 886742121
// Purpose of Assignment: Show how to measure the run time required by a block of assembly code

#include <stdio.h>                  // Include standard input-output header for printf

extern double series();              // Declare the external series function, which computes a value

int main() {
    // Display initial welcome message
    printf("\nWelcome to Taylor Series by Bryant Martinez\n");   // Print welcome message
    printf("This software will compute any power of 'e' that you may need\n\n");   // Explain the purpose of the software
    
    double number = series();         // Call the series function and store the result in 'number'
    
    // Display thank you and farewell messages
    printf("\n\nThank you for using the Bryant exponential calculator.");   // Print thank you message
    printf("\nPlease return another day. The computed value will be set to the caller functions"); // Print additional message
    printf("\nThis driver received this number %.8f and will keep it\n",number );  // Display the computed result with 8 decimal places
    printf("\nGood-bye\n");            // Print goodbye message
    
    return 0;                         // Return 0 to indicate successful execution
}
