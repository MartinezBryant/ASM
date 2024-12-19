// Bryant Martinez
// CWID : 886742121

#include <stdio.h>
#include <math.h>

extern char * manager();           // Declare the external manager function

int main() {
    char * Manager;                // Pointer to store the returned name

    printf("\nWelcome to Marvelous Arrayss\n");  // Welcome message
    printf("Brought to you by Bryant Martinez\n"); // Author information

    Manager = manager();           // Call manager and get the user's name

    printf("\nI hope you liked your array %s\n", Manager); // Feedback message
    printf("Main will now return 0 to the operating system. Bye. \n"); // Exit message

    return 0;                     // Return 0 to indicate successful execution
}
