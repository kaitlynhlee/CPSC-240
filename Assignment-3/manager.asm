;****************************************************************************************************************************
;Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, along with the variance of the numbers.
; Copyright (C) 2024  Kaitlyn Lee.          *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Kaitlyn Lee
;  Author email: kaitlynlee@csu.fullerton.edu
;  CWID: 886374479
;  Class: 240-03 Section 03
;
;Program information
;  Program name: Arrays of floating point numbers
;  Programming languages: Two modules in C, four in x86, one in C++, and one in bash
;  Date program began: 2024-Mar-8
;  Date of last update: 2024-Mar-17
;  Files in this program: main.c, manager.asm, input_array.asm, compute_mean.asm, isfloat.asm,
;  output_array.c, compute_variance.cpp, r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program takes floating point number inputs from the user and puts them in an array. The array
;  values are then printed, along with the variance of the numbers.
;
;This file:
;  File name: manager.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l manage.lis -o manage.o manager.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l manage.lis -o manage.o manager.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double manager();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

extern printf

extern input_array

extern compute_mean

extern output_array

extern compute_variance

global manager

segment .data                 ;Place initialized data here
msg_1 db "This program will manage your arrays of 64-bit floats", 10, 0
msg_2 db "For the array enter a sequence of 64-bit floats separated by white space.", 10, 0
msg_3 db "After the last input press enter followed by Control+D:", 10, 0
msg_4 db "These numbers were received and placed into an array", 10, 0
msg_5 db "The mean of the numbers in the array is %.6lf", 10, 0
msg_6 db "The variance of the inputted numbers is %.6lf", 10, 0
floatformat db 10, "%lf", 10, 0

segment .bss      ;Declare pointers to un-initialized space in this segment.
align 64
backup_storage_area resb 832

my_array resq 12 ; <name> <data-type> <size>


segment .text
manager:

;backup GPRs
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;backup other registers
mov rax,7
mov rdx,0
xsave [backup_storage_area]

;inform user what the program does/how it works in creating floating point number arrays
mov rax, 0
mov rdi, msg_1
call printf

;inform the user how to input float values into the array
mov rax, 0
mov rdi, msg_2
call printf

;inform user how to end the input prompt before the array is full
mov rax, 0
mov rdi, msg_3
call printf

;call input_array function in order to obtain the float values from user and place them into array
mov rax, 0
mov rdi, my_array
mov rsi, 12
call input_array

;store the array length from input_array function in a non-volatile register to use for other functions
mov r13, rax

;tell user that these were the values received before printing the array values
mov rax, 0
mov rdi, msg_4
call printf

;call output_array function to loop through the array and print each value for the user to see
mov rax, 0
mov rdi, my_array
mov rsi, r13
call output_array

;call compute_mean function in order to calculate the mean of all the user submitted values in the array
mov rax, 0
mov rdi, my_array
mov rsi, r13
call compute_mean

;store array length and the mean of the array values in non-volatile registers for later use
mov r13, rax
movsd xmm15, xmm0

;tell user the mean of the floating point numbers in the array
mov rax, 1
mov rdi, msg_5
movsd xmm0, xmm15
call printf

;call compute_variance to find the variance between the different floating point numbers inputted into the array by the user
mov rax, 1
mov rdi, my_array
mov rsi, r13
movsd xmm0, xmm15
call compute_variance

;store the variance number in a non-volatile register to save it for later use and for printing
movsd xmm14, xmm0

;tell user the results of computing the variance of the different inputted floating point numbers in the array
mov rax, 1
mov rdi, msg_6
movsd xmm0, xmm14
call printf

;move the variance of the array inputs to stack for safekeeping while the sse registers are restored
mov rax, 0
push qword 0
movsd [rsp], xmm14

;Restore the values to non-GPRs/sse registers
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;store the variance of the array inputs in order to be sent back to main to be printed
movsd xmm0, [rsp] ;send back to driver
pop rax

;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the function manager ====================================================================

