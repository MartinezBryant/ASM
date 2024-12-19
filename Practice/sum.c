#include <stdio.h>
#include <math.h>

int sum(int nice_array[], int count)
{
    int s = 0;
    for (size_t i = 0; i < count; i++)
    {
        s += nice_array[i];
    }

    return s;
}