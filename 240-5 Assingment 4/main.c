// Bryant Martinez
// CWID : 886742121

#include <stdio.h>             

extern char* execute();       // Declare the external function execute, which returns a char pointer

int main() 
{
    // Print welcome message and author information
    printf("\nWelcome to Random Products, LLC.\n");  // Welcomes the user to the program
    printf("This software is maintained by Bryant Martinez\n"); // Displays the author's name

    char* name = execute();    // Call the execute function to retrieve the user's name

    // Print a farewell message that includes the user's name
    printf("\nOh, %s. We hope you enjoyed your arrays. Do come again.\n", name); // Personalized goodbye message
    printf("A zero will be returned to the operating system.\n"); // Message indicating exit status

    return 0;                  // Return 0 to the operating system indicating successful execution
}
