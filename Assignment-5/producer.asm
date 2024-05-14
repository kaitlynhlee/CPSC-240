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
;  File name: producer.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l producer.lis -o producer.o producer.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l producer.lis -o producer.o producer.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double producer();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

global producer
extern sin
extern atof
extern ftoa

;const global variables
pi dq 3.141592653589793238462643383279502884197
two dq 2.0
straight dq 180.0

segment .data
;declare initialized arrays
side_1_msg db "Please enter the length of side 1: ", 0
side_2_msg db "Please enter the length of side 2: ", 0
angle_msg db "Please enter the degrees of the angle between: ", 0

area_msg_1 db 10, "The area of this triangle is ", 0
area_msg_2 db " square feet.", 10, 0
thanks_msg db "Thank you for using a Kaitlyn product.", 10, 0

STDOUT equ 1
SYS_write equ 1
STDIN equ 0
SYS_read equ 0

segment .bss
;declare empty arrays
side_1 resq 20
side_2 resq 20
angle resq 20
area resq 20

align 64
backup_storage_area resb 832

segment .text

producer:

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


;Print out our first side prompt
mov rax, STDOUT
mov rdi, SYS_write
mov rsi, side_1_msg
mov rdx, 36
syscall

;Get user input for side length 1
mov rax, STDIN
mov rdi, SYS_read
mov rsi, side_1
mov rdx, 20
syscall

;change side length 1 from string to float
mov rax, 0
mov rdi, side_1
call atof

;store side 1 in xmm15 for calculations
movsd xmm15, xmm0       ;saves side length 1 in xmm15


;Print out our second side prompt
mov rax, STDOUT
mov rdi, SYS_write
mov rsi, side_2_msg
mov rdx, 36
syscall

;Get user input for side length 2
mov rax, STDIN
mov rdi, SYS_read
mov rsi, side_2
mov rdx, 20
syscall

;change side length 2 from string to float
mov rax, 0
mov rdi, side_2
call atof

;store side 2 in xmm14 for calculations
movsd xmm14, xmm0       ;saves side length 2 in xmm14

;Print out our angle prompt
mov rax, STDOUT
mov rdi, SYS_write
mov rsi, angle_msg
mov rdx, 48
syscall

;Get user input for our angle in degrees
mov rax, STDIN
mov rdi, SYS_read
mov rsi, angle
mov rdx, 20
syscall

;change angle from string to float
mov rax, 0
mov rdi, angle
call atof

;store angle length in xmm13 for calculations
movsd xmm13, xmm0       ;saves angle length in xmm13

;change angle from degrees to radians
mulsd xmm13, [pi]
divsd xmm13, [straight]

;call sin function with angle in radians to find sin(C) for calculating area
mov rax, 1
movsd xmm0, xmm13
call sin

;move sin(C) into xmm12 for area calculation
movsd xmm12, xmm0

;calculate area
;formula: 1/2 ab * sin(C)
mulsd xmm12, xmm15
mulsd xmm12, xmm14
divsd xmm12, [two]

;convert area from float to string for printing
mov rax, 1
movsd xmm0, xmm12
mov rdi, area
mov rsi, 20
call ftoa

;print area result message part 1 to user
mov rax, STDOUT
mov rdi, SYS_write
mov rsi, area_msg_1
mov rdx, 31
syscall

;print area number to user
mov rax, STDOUT
mov rdi, SYS_write
mov rsi, area
mov rdx, 20
syscall

;print area result message part 2 to user
mov rax, STDOUT
mov rdi, SYS_write
mov rsi, area_msg_2
mov rdx, 15
syscall

;thank user for using the program
mov rax, STDOUT
mov rdi, SYS_write
mov rsi, thanks_msg
mov rdx, 40
syscall

;mov the area result to stack for safekeeping while restoring non-gprs
mov rax, 0
push qword 0
movsd [rsp], xmm12

;restore the values to non-gprs
mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]

;store area result back in xmm0 to send back to director
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
;End of the function producer ====================================================================

