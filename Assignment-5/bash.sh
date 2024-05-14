#/bin/bash

#Program name "Areas of triangles"
#Author: Kaitlyn Lee
#Author Email: kaitlynlee@csu.fullerton.edu
#CWID: 886374479
#Class: 240-03 Section 03
#This file is the script file that accompanies the "Areas of triangles" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file producer.asm"
nasm -f elf64 -o producer.o producer.asm

echo "Assemble the source file sin.asm"
nasm -f elf64 -o sin.o sin.asm

echo "Compile the source file ftoa.cpp"
g++ -c -m64 -Wall -o ftoa.o ftoa.cpp -fno-pie -no-pie -std=c++20

echo "Compile the source file director.c"
gcc  -m64 -Wall -no-pie -o director.o -std=c2x -c director.c

echo "Link the object modules to create an executable file"
g++ -m64 -o a.out producer.o sin.o ftoa.o director.o -fno-pie -no-pie -std=c++20

echo "Execute the program"
chmod +x a.out
./a.out

echo "This bash script will now terminate."

