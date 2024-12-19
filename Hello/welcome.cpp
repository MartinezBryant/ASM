// Bryant Martinez
// 240-5 Assingment 1
// CWID: 886742121

#include <iostream> // required iostream library for the input and output

extern "C" char* hello(); // Declare the external C function named 'hello' which returns a char pointer

using namespace std; // avoid adding std:: in front of functions

int main () {
    char *name; // Declare a pointer to return to 'hello'
    // Print a welcome message 
    cout << "Welcome to this friendly 'Hello' program created by Bryant Martinez" << endl; 
    // Call the external 'hello' function in order to store the string in 'name'
    name = hello();
    // Print a message including thr string returned by 'hello'
    cout << "Have a nice day " << name << "." << endl;
    // Print the final goodbye message
    cout << "Bye. The integer zero will now be returned to the operating system." << endl;
    // Return 0 to clear the successful execution
    return 0;
}
