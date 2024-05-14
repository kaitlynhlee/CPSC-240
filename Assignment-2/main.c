//****************************************************************************************************************************
//Program name: "Amazing Triangles".  This program calculates for the third side of a triangle based on the user's input for the other two sides and the angle between them
// Copyright (C) 2024  Kaitlyn Lee.          *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************
//****************************************************************************************************************************

//Author: Kaitlyn Lee
//Author email: kaitlynlee@csu.fullerton.edu
//CWID: 886374479
//Class: 240-03 Section 03
//Program name: Amazing Triangles
//Programming languages: One module in C, one in X86, and one in bash.
//Date program began: 2024-Feb-21
//Date of last update: 2024-Feb-24
//Files in this program: main.c, compute_triangle.asm, isfloat.asm, r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program calculates for the third side of a triangle based on the user's input for the other two sides and the angle between them
//This file
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
//  Link: gcc -m64 -no-pie -o calc.out triangle.o isfloat.o main.o -std=c2x -Wall -z noexecstack





#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

extern double compute_triangle();

int main(void)
{printf("Welcome to Amazing Triangles programmed by Kaitlyn Lee on February 22, 2024.\n\n");
 double count = 0;
 count = compute_triangle();
 printf("\nThe driver has received this number %.10lf and will simply keep it.\n\n",count);
 printf("An integer zero will now be sent to the operating system. Bye.\n");
}
