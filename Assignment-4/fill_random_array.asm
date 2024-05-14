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
;  File name: fill_random_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -o fill_array.o fill_random_array.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -o fill_array.o fill_random_array.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void fill_random_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

extern printf
extern isnan

global fill_random_array

segment .data                 ;Place initialized data here
intformat db 10, "%d  %d", 10, 0 
int_float dq "%18.13g",0

segment .bss      ;Declare pointers to un-initialized space in this segment.

segment .text
fill_random_array:

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
mov r15, rdi ;our array
mov r14, rsi ;number of values

;set counter to 0 to keep track of if array has been filled
mov r13, 0

;check if all space in array has been filled
check_capacity:
cmp r13, r14
jl is_less

;if array has been filled jump to exit the function
jmp exit

;jump here if array is not full yet to continue generating numbers
is_less:

;while array is not full, generate a random number into r12, push it onto the stack then move it to xmm15 to check it
fill_array:
mov rax, 0
rdrand r12
mov rdi, r12
push r12
push r12
movsd xmm15, [rsp]
pop r12
pop r12

;check if random number is a nan, if it is: jump to fill_array to generate a new number
movsd xmm0, xmm15
call isnan
cmp rax, 0
je fill_array

;if number is not a nan, move into array
movsd [r15+r13*8], xmm15
    
;add to counter that a value has been added to array, then jump to check if array is still not full
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
;End of the function fill_random_array ====================================================================

