//****************************************************************************************************************************

//Author: Kaitlyn Lee
//Author email: kaitlynlee@csu.fullerton.edu
//CWID: 886374479
//Class: 240-03 Section 03
//Program name: Average Driving Time
//Programming languages: One module in C, one in X86, and one in bash.
//Date program began: 2024-Jan-31
//Date of last update: 2024-Feb-4
//Files in this program: driver.c, average.asm, r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program is a driving time, speed, and distance calculator based on the user's input

//This file
//  File name: driver.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c
//  Link: gcc -m64 -no-pie -o calc.out avg.o driver.o -std=c2x -Wall -z noexecstack





#include <stdio.h>
//#include <string.h>
//#include <stdlib.h>

extern double average();

int main(void)
{printf("Welcome to Average Driving Time maintained by Kaitlyn Lee\n");
 double count = 0;
 count = average();
 printf("\nThe driver has received this number %.8lf and will keep it for future use.\nHave a great day.\n\n",count);
 printf("A zero will be sent to the operating system as a sign of a successful execution.\n");
}
