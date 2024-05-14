#/bin/bash

#Program name "Arrays of Floating Point Numbers"
#Author: Kaitlyn Lee
#Author Email: kaitlynlee@csu.fullerton.edu
#CWID: 886374479
#Class: 240-03 Section 03
#This file is the script file that accompanies the "Arrays of Floating Point Numbers" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file manager.asm"
nasm -f elf64 -l manage.lis -o manage.o manager.asm

echo "Assemble the source input_array.asm"
nasm -f elf64 -l input.lis -o input.o input_array.asm

echo "Assemble the source compute_mean.asm"
nasm -f elf64 -l mean.lis -o mean.o compute_mean.asm

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile the source file output_array.c"
gcc  -m64 -Wall -no-pie -o output.o -std=c2x -c output_array.c

echo "Compile the source file main.c"
gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

echo "Compile the source file compute_variance.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o variance.o compute_variance.cpp

echo "Link the object modules to create an executable file"
g++ -m64 -no-pie -o arr.out manage.o input.o mean.o isfloat.o output.o main.o variance.o -std=c2x -Wall -z noexecstack -lm

echo "Execute the program"
chmod +x arr.out
./arr.out

echo "This bash script will now terminate."
