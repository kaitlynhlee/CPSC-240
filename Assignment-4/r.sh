#/bin/bash

#Program name "Non-deterministic random numbers"
#Author: Kaitlyn Lee
#Author Email: kaitlynlee@csu.fullerton.edu
#CWID: 886374479
#Class: 240-03 Section 03
#This file is the script file that accompanies the "Non-deterministic random numbers" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file executive.asm"
nasm -f elf64 -o executive.o executive.asm

echo "Assemble the source file show_array.asm"
nasm -f elf64 -o show_array.o show_array.asm

echo "Assemble the source file fill_random_array.asm"
nasm -f elf64 -o fill_array.o fill_random_array.asm

echo "Assemble the source file isnan.asm"
nasm -f elf64 -o isnan.o isnan.asm

echo "Assemble the source file normalize_array.asm"
nasm -f elf64 -o normalize_array.o normalize_array.asm

echo "Compile the source file sort.cpp"
g++ -c -m64 -Wall -o sort.o sort.cpp -fno-pie -no-pie -std=c++20

echo "Compile the source file main.cpp"
g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++20

echo "Link the object modules to create an executable file"
g++ -m64 -o output.out executive.o fill_array.o main.o show_array.o isnan.o normalize_array.o sort.o -fno-pie -no-pie -std=c++20

echo "Execute the program"
chmod +x output.out
./output.out

echo "This bash script will now terminate."

