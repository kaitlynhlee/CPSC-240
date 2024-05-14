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
;  File name: compute_mean.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l mean.lis -o mean.o compute_mean.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l mean.lis -o mean.o compute_mean.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double compute_mean();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

extern printf

global compute_mean

segment .data
;declare initialized arrays
results db "%lf", 10, 0

segment .bss
;declare empty arrays

align 64
backup_storage_area resb 832

segment .text

compute_mean:

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

;store array address and array length in non-volatile registers to use when adding the registers together and calculating mean
mov r15, rdi
mov r14, rsi


;set r13 to zero in order to use as a counter for the float point numbers to check how many of the array values have been added together so far
mov r13, 0


;check how many of the array values have been added together so far
check_capacity:
;compare the counter of how many values have been added already to the number of values in the array to see if they have all been added yet
cmp r13, r14
jl is_less ;if less jump to is_less to continue adding together the values from the array
; if greater/equal to then jump to calc to calculate the mean of all the values
jmp calc

; if num is still less than size of array jump here to continue adding the float values to the cumulative sum
is_less:
;add a float value from the array to the sum
movsd xmm15, [r15+r13*8]
addsd xmm14, xmm15


;increase the counter of how many floats have been added together and jump to check_capacity to see if there are still values to be added
inc r13
jmp check_capacity


;jump here when all floating point number array values have been added together
calc:
;convert number of array values into a floating point number in order to divide the cumulative sum of them and find mean
cvtsi2sd xmm13, r13
divsd xmm14, xmm13


;print results of mean for testing
;mov rax, 1
;movsd xmm0, xmm14
;mov rdi, results
;call printf


;move the mean of the array inputs to stack for safekeeping while the sse registers are restored
mov rax, 0
push qword 0
movsd [rsp], xmm14

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;Store the mean of the array values to be sent back to manager for calculating variance
movsd xmm0, [rsp] ;send back to driver
pop rax

;store size of array to be sent back to manager for later use in other functions
mov rax, r13

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
;End of the function compute_mean ====================================================================

