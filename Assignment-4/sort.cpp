//****************************************************************************************************************************
//Program name: "Non-deterministic random numbers".  This program takes an input from the user for how many values to create in an array, then generates random numbers into the array and normalizes and sorts them.
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
//Program name: Non-deterministic random numbers
//Programming languages: Two modules in C++, five in x86, and one in bash
//Date program began: 2024-Apr-3
//Date of last update: 2024-Apr-14
//Files in this program: main.cpp, executive.asm, fill_random_array.asm, normalize_array.asm, isnan.asm, show_array.asm, sort.cpp, r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program: This program takes an input from the user for how many values to create in an array, then generates random numbers into the array and normalizes and sorts them.
//  
//This file
//  File name: sort.cpp
//  Language: C++ language
//  Max page width: 124 columns
//  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o sort.o sort.cpp
//  Link: g++ -m64 -o output.out executive.o fill_array.o main.o show_array.o isnan.o normalize_array.o sort.o -fno-pie -no-pie -std=c++20

#include <stdio.h>
#include <cstring>
#include <iostream>
using namespace std;

extern "C" void sort( double* my_array, int array_size);

void sort(double* my_array, int array_size)
{
  double hold;
  for (int i = 0; i < array_size; i++)
    {
      for (int j = 0; j < array_size-i-1; j++)
      {
        if (my_array[j] > my_array[j+1])
        {
          hold = my_array[j];
          my_array[j] = my_array[j+1];
          my_array[j+1] = hold;
        }
      }
    }
}
