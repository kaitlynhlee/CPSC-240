//name: Kaitlyn Lee
//email: kaitlynlee@csu.fullerton.edu
//class number: CPSC 240-3
//date: May 13, 2024

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern double dot();

int main(void)
{printf("Welcome to the CS 240-3 final exam.\nThis program is maintained by Kaitlyn Lee\n\n");
 double answer = 0;
 answer = dot();
 printf("\nThe driver received %.1lf and will keep it.\n", answer);
 printf("A 0 will be sent to the OS. Bye.\n");
}
