#/bin/bash

#Program name "Amazing Triangles"
#Author: Kaitlyn Lee
#Author Email: kaitlynlee@csu.fullerton.edu
#CWID: 886374479
#Class: 240-03 Section 03
#This file is the script file that accompanies the "Amazing Triangles" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file compute_triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o compute_triangle.asm

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile the source file main.c"
gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o calc.out triangle.o isfloat.o main.o -std=c2x -Wall -z noexecstack -lm

echo "Execute the program"
chmod +x calc.out
./calc.out

echo "This bash script will now terminate."
