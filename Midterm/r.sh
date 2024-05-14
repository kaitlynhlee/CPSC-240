#/bin/bash

#Author: Kaitlyn Lee
#Author email: kaitlynlee@csu.fullerton.edu
#CWID: 886374479
#Class: 240-03 Section 03
#Date: March 20, 2024
#240-3 Midterm Program

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file electricity.asm"
nasm -f elf64 -l electric.lis -o electric.o electricity.asm

echo "Assemble the source file current.asm"
nasm -f elf64 -l current.lis -o current.o current.asm

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile the source file main.c"
gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o circuit.out electric.o current.o isfloat.o main.o -std=c2x -Wall -z noexecstack -lm

echo "Execute the program"
chmod +x circuit.out
./circuit.out

echo "This bash script will now terminate."
