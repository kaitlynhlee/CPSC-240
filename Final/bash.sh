#name: Kaitlyn Lee
#email: kaitlynlee@csu.fullerton.edu
#class number: CPSC 240-3
#date: May 13, 2024

#Delete some un-needed files
rm *.o
rm *.out

#echo "Assemble the source file producer.asm"
nasm -f elf64 -o dot.o dot.asm

#echo "Assemble the source file sin.asm"
nasm -f elf64 -o isfloat.o isfloat.asm

#echo "Compile the source file director.c"
gcc  -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c

#echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o a.out dot.o isfloat.o driver.o -std=c2x -Wall -z noexecstack -lm

#echo "Execute the program"
chmod +x a.out
./a.out

#echo "This bash script will now terminate."

