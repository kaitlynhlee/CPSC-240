//****************************************************************************************************************************
//Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, along with the variance of the numbers.
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
//Program name: Arrays of Floating Point Numbers
//Programming languages: Two modules in C, four in x86, one in C++, and one in bash
//Date program began: 2024-Mar-8
//Date of last update: 2024-Mar-17
//Files in this program: main.c, manager.asm, input_array.asm, compute_mean.asm, isfloat.asm, output_array.c, compute_variance.cpp, r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program: This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, along with the variance of the numbers.
//  
//This file
//  File name: output_array.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64 -Wall -no-pie -o output.o -std=c2x -c output_array.c
//  Link: g++ -m64 -no-pie -o arr.out manage.o input.o mean.o isfloat.o output.o main.o variance.o -std=c2x -Wall -z noexecstack -lm


#include <stdio.h>

void output_array(double array[], int array_length)
{
//loop through array until each value in array has been printed for user to see
    for (int i = 0; i < array_length; i++)
    {
        printf("%1.5f  ", array[i]);
    }
    printf("\n");
}
