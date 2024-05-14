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
//  File name: compute_variance.cpp
//  Language: C++ language
//  Max page width: 124 columns
//  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o variance.o compute_variance.cpp
//  Link: g++ -m64 -no-pie -o arr.out manage.o input.o mean.o isfloat.o output.o main.o variance.o -std=c2x -Wall -z noexecstack -lm


#include <stdio.h>
#include <cstring>
#include <iostream>
#include <math.h>
using namespace std;

//declaration of function in order to be used in external files
extern "C" double compute_variance(double array[], int array_length, double mean);

double compute_variance(double array[], int array_length, double mean)
{
//variable declarations
	double sum = 0;
	double temp;
	double result = 5;
	
	//loop to add together the sum of (each array value subtracted by the mean of all the array
	//values) squared
	for (int i = 0; i < array_length; i++)
	{
		temp = array[i] - mean;
		temp = temp * temp;
		sum += temp;
        }
        
        //find variance by dividing the sum found previously by the number of values subtracted by 1
        result = (sum/(array_length - 1));
        
        //send the variance found back to manager
        return result;
}
