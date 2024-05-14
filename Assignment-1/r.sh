#/bin/bash

#Program name "Average Driving Time"
#Author: Kaitlyn Lee
#Author Email: kaitlynlee@csu.fullerton.edu
#CWID: 886374479
#Class: 240-03 Section 03
#This file is the script file that accompanies the "Average Driver Time" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file average.asm"
nasm -f elf64 -l avg.lis -o avg.o average.asm

echo "Compile the source file driver.c"
gcc  -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o calc.out avg.o driver.o -std=c2x -Wall -z noexecstack

echo "Execute the program"
chmod +x calc.out
./calc.out

echo "This bash script will now terminate."
