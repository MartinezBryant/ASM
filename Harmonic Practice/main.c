#include <stdio.h>
#include <math.h>

extern void manager();
extern float result;

int main() 
{
    printf("\nWelcome to Harmonic Arrays brought to you by Bryant Martinez");

    manager();

    printf("\nThe main functio received this numeber %f and plans to keep it\n",  result);
    printf("\nA 0 will now be returned to the operating system.\n");
    printf("\nHave a great next semester. Bye! \n");
    return 0;
}