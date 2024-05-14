;****************************************************************************************************************************
;Program name: "Areas of triangles".  The purpose of this program is to compute the area of a triangle given the lengths of two sides and the angle (degrees) between those two sides.
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
;  Program name: Areas of triangles
;  Programming languages: One module in C, two in x86, one in C++, and one in bash
;  Date program began: 2024-May-10
;  Date of last update: 2024-May-10
;  Files in this program: director.c, producer.asm, sin.asm, ftoa.cpp, bash.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  The purpose of this program is to compute the area of a triangle given the lengths of two sides and the angle (degrees) between those two sides.
;
;This file:
;  File name: sin.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l sin.lis -o sin.o sin.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l sin.lis -o sin.o sin.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double sin(double);
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

global sin

segment .data
;declare initialized arrays

segment .bss
;declare empty arrays

align 64
backup_storage_area resb 832

segment .text

sin:

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

;initialize values
movsd xmm9, xmm0 ; permanent copy of angle
movsd xmm8, xmm9; xmm8 = current term
mov r14, 0 ; counter
mov r13, 0
cvtsi2sd xmm10, r13 ; xmm10 = sin(x)


;check if counter has reached sufficient number of terms
check_num:
cmp r14, 20
jl is_less
jmp done


;jump here if not done calculating terms for sin
is_less:
;add term to total sin
addsd xmm10, xmm8

;multiplier/find the value of the term for multiplying
mov rbx, r14 ; rbx = counter
movsd xmm13, xmm9 ; xmm13 = x

;find numerator
mulsd xmm13, xmm13 ; xmm13 = x^2
mov r8, -1
cvtsi2sd xmm11, r8 ; xmm11 = -1.0
mulsd xmm13, xmm11 ; xmm13 = -(x^2) = numerator

;find denominator
imul rbx, 2
add rbx, 2 ; rbx = 2n + 2
mov rcx, rbx ; rcx = 2n + 2
inc rcx ; rcx = 2n + 3
imul rbx, rcx ; rbx = (2n + 2)(2n + 3) = denominator
cvtsi2sd xmm14, rbx ; xmm14 is the denominator

;divide numerator and denominator
divsd xmm13, xmm14 ; xmm13 has the answer

;multiply to get new term
mulsd xmm8, xmm13

;add to counter and check if need to continue
inc r14
jmp check_num


;jump here when done calculating sin
done:
;mov the sin to stack for safekeeping while restoring non-gprs
mov rax, 0
push qword 0
movsd [rsp], xmm10

;restore the values to non-gprs
mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]

;store sin back in xmm0 to send back
movsd xmm0, [rsp] ;send back
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
;End of the function sin ====================================================================

