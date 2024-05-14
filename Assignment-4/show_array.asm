;****************************************************************************************************************************
;Program name: "Non-deterministic random numbers".  This program takes an input from the user for how many values to create in an array, then generates random numbers into the array and normalizes and sorts them.
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
;  Program name: Non-deterministic random numbers
;  Programming languages: Two modules in C++, five in x86, and one in bash
;  Date program began: 2024-Apr-3
;  Date of last update: 2024-Apr-14
;  Files in this program: main.cpp, executive.asm, fill_random_array.asm, normalize_array.asm, isnan.asm, show_array.asm, sort.cpp, r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program takes an input from the user for how many values to create in an array, then generates
;  random numbers into the array and normalizes and sorts them.
;
;This file:
;  File name: show_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -o show_array.o show_array.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -o show_array.o show_array.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void show_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

extern printf

global show_array

segment .data                 ;Place initialized data here
header db "IEEE754			Scientific Decimal", 10, 0
output_format db "0x%016lX	%-18.13g",10, 0

segment .bss      ;Declare pointers to un-initialized space in this segment.

segment .text
show_array:

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

;obtain array address and size and store in nonvolatile registers
mov r15, rdi
mov r14, rsi

;set counter to 0 to keep track of if all of array values have been printed
mov r13, 0

;print a header for the array to show which value is hex and which is scientific notation
mov rax, 0
mov rdi, header
call printf

;check if all of array has been printed
check_capacity:
cmp r13, r14
jl is_less

;if array has finished printing jump to exit the function
jmp exit

;jump here if array is not done printing to continue printing
is_less:

;print out a value with its ieee form and scientific notation form
mov rax, 2
mov rdi, output_format
mov rsi, [r15+r13*8]
movsd xmm0, [r15+r13*8]
call printf

;add to counter and jump to check if all of array has printed yet
inc r13
jmp check_capacity

;exit the function when done
exit:
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
;End of the function show_array ====================================================================

