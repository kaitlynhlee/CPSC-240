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

//Purpose of this program: The purpose of this program is to compute the area of a triangle given the lengths of two sides and the angle (degrees) between those two sides.
//  
//This file
//  File name: ftoa.cpp
//  Language: C++ language
//  Max page width: 124 columns
//  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o ftoa.o ftoa.cpp
//  Link: g++ -m64 -o a.out producer.o sin.o ftoa.o director.o -fno-pie -no-pie -std=c++20

#include <iostream>
#include <string>
#include <stdio.h>

extern "C" void ftoa(double num, char *arr, int size);

void ftoa(double num, char *arr, int size) {
  // Convert the float to a string
  std::string str = std::to_string(num);

  // Copy the string into the provided array
  // Ensure the string does not exceed the array size
  int copySize = std::min(static_cast<std::string::size_type>(str.size()),
                          static_cast<std::string::size_type>(size - 1));
  std::copy(str.begin(), str.begin() + copySize, arr);

  // Null-terminate the array
  arr[copySize] = '\0';
}
