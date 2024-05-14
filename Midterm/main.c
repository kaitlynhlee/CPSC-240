
//Author: Kaitlyn Lee
//Author email: kaitlynlee@csu.fullerton.edu
//CWID: 886374479
//Class: 240-03 Section 03
//Date: March 20, 2024
//240-3 Midterm Program



#include <stdio.h>
//#include <math.h>
#include <string.h>
#include <stdlib.h>

//declaration for external function
extern double electricity();

int main(void)
{
//inform user about the program and author
 printf("\nWelcome to West Beach Electric Company.\n");
 printf("This software is maintained by Kaitlyn Lee\n\n");
 
 //call the manager function to start running the program
 double count = 0;
 count = electricity();
 
 //inform user of the result of the program before bidding farewell
 printf("\nThe main received this number %.5lf and will keep it for later.\n",count);
 printf("A zero will be returned to the operating system. Bye.\n");
}
