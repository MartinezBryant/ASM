#include <stdio.h>
#include <string.h>

extern void input_array();    // Assembly function to input array
extern long sum_array();      // Assembly function to sum array
extern void sort_array();     // Assembly function to sort array
extern void output_array();    // Assembly function to output array
extern long array[];          // External array
extern long num_count;        // External count of numbers

int main() {
    char name[50];

    // Introductory messages
    printf("Welcome to Marvelous Arrays\n");
    printf("Bought to you by Jessica Ward\n");

    // Get user's name
    printf("Please enter your name: ");
    fgets(name, sizeof(name), stdin);
    // Remove newline character if present
    name[strcspn(name, "\n")] = 0;

    // Process array input
    input_array();

    // Calculate sum
    long total_sum = sum_array();
    
    // Sort array
    sort_array();

    // Output results
    output_array(total_sum);

    // Exit message
    printf("This program will return execution to the main function.\n");
    printf("I hope you liked your arrays %s\n", name);
    printf("Main will return 0 to the operating system. Bye.\n");

    return 0; // Return success to the OS
}
