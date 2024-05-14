//****************************************************************************************************************************
//Program name: "Areas of Triangles".  The purpose of this program is to compute the area of a triangle given the lengths of two sides and the angle (degrees) between those two sides.
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
//Program name: Areas of Triangles
//Programming languages: One module in C, two in x86, one in C++, and one in bash
//Date program began: 2024-May-10
//Date of last update: 2024-May-10
//Files in this program: director.c, producer.asm, sin.asm, ftoa.cpp, bash.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  The purpose of this program is to compute the area of a triangle given the lengths of two sides and the angle (degrees) between those two sides.
//This file
//  File name: director.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64 -Wall -no-pie -o director.o -std=c2x -c director.c
//  Link: g++ -m64 -o a.out producer.o sin.o ftoa.o director.o -fno-pie -no-pie -std=c++20




#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern double producer();

int main(void)
{printf("Welcome to Marvelous Kaitlyn's Area Machine.\nWe compute all your areas\n\n");
 double answer = 0;
 answer = producer();
 printf("\nThe driver has received this number %.5lf and will keep it.\n", answer);
 printf("An zero will be sent to the OS as a sign of successful conclusion. \nBye.\n");
}
