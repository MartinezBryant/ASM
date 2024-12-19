// CWID:886742121
// Section 240-5
// Bryant Martinez
#include <stdio.h>
#include <stdlib.h> // For malloc, if used in assembly

extern "C" char* average(); 

int main() {
    printf("Welcome to Time Advantage maintained by Bryant Martinez\n");

    char *total = average();
    
    printf("The driver has received this number: %s ", total);
    printf("and will keep it for future use.\n");
    printf("Have a great day\n\n");
    printf("A zero will be sent to the operating system as a signal of a successful execution.\n");

    return 0;
}
