;****************************************************************************************************************************
;Program name: "Amazing Triangles".  This program calculates for the third side of a triangle based on the user's input for the other two sides and the angle between them
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
;  Program name: Amazing Triangles
;  Programming languages: One module in C, one in X86, and one in bash.
;  Date program began: 2024-Feb-22
;  Date of last update: 2024-Feb-24
;  Files in this program: main.c, compute_triangles.asm, isfloat, r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program is a driving time, speed, and distance calculator based on the user's input
;
;This file:
;  File name: compute_triangle.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l triangle.lis -o triangle.o compute_triangle.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l triangle.lis -o triangle.o compute_triangle.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double compute_triangle();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

extern printf

extern fgets

extern stdin

extern strlen

extern atof

extern cos

extern isfloat

global compute_triangle

string_size equ 48
pi dq 3.141592653589793238462643383279502884197
two dq 2.0
straight dq 180.0


segment .data
;declare initialized arrays

prompt_for_name db 10, "Please enter your name: ",0
prompt_for_title db 10, "Please enter your title (Sergeant, Chief, CEO, President, Teacher, etc): ", 10, 0
gm_message db 10, "Good morning %s %s. We take care of all your triangles.", 10, 10, 0


side_1 db "Please enter the length of the first side: ", 0
side_2 db "Please enter the length of the second side: ", 0
angle db "Please enter the size of the angle in degrees: ", 0
invalid db "Invalid input. Try again: ", 0


results db 10, "Thank you %s. You entered %.6lf %.6lf and %.6lf.", 0
side_3 db 10, "The length of the third side is %.6lf.", 10, 0
sent db 10, "This length will be sent to the driver program.", 10, 0
starting_time db 10, "The starting time on the system clock is %lu tics", 10, 0
end_time db 10, "The final time on the system clock  is %lu tics", 10, 0
goodday db 10, "Have a good day %s %s.", 10, 0


numtest db 10, "%lf", 10, 0


segment .bss
;declare empty arrays

align 64
backup_storage_area resb 832

user_name resb string_size
user_title resb string_size

segment .text

compute_triangle:

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


;get starting time on system clock
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r12, rdx

;print starting time
mov rax, 0
mov rdi, starting_time
mov rsi, r12
call printf


;output instructions for user to input name
mov rax, 0
mov rdi, prompt_for_name
call printf

;input user names
mov rax, 0
mov rdi, user_name
mov rsi, string_size
mov rdx, [stdin]
call fgets

;remove newline
mov rax, 0
mov rdi, user_name
call strlen
mov [user_name+rax-1], byte 0

;output instructions for user to input title
mov rax, 0
mov rdi, prompt_for_title
call printf

;input user title
mov rax, 0
mov rdi, user_title
mov rsi, string_size
mov rdx, [stdin]
call fgets

;remove newline
mov rax, 0
mov rdi, user_title
call strlen
mov [user_title+rax-1], byte 0

;good morning user
mov rax, 0
mov rdi, gm_message
mov rsi, user_title
mov rdx, user_name
call printf



input_loop_s1:
;prompt the user for first side length
mov rax, 0
mov rdi, side_1
call printf

;Have user input number for first side length as a string
sub rsp, 4096
mov rdi, rsp
mov rsi, 4096
mov rdx, [stdin]
call fgets

;remove newline
mov rax, 0
mov rdi, rsp
call strlen
mov[rsp + rax-1], byte 0

;check recent input is a valid float number
mov rax, 0
mov rdi, rsp
call isfloat

;if not valid float number, send to bad_input to try again
cmp rax, 0
je bad_input_s1

;if input is valid float number, save value and jump to next function
mov rax, 0
mov rdi, rsp
call atof
movsd xmm12, xmm0
add rsp, 4096
jmp input_loop_s2


;input is invalid, ask user to to input again
bad_input_s1:
mov rax, 0
mov rdi, invalid
call printf
add rsp, 4096

;Have user input number for first side length as a string again
sub rsp, 4096
mov rdi, rsp
mov rsi, 4096
mov rdx, [stdin]
call fgets

;remove newline
mov rax, 0
mov rdi, rsp
call strlen
mov[rsp + rax-1], byte 0

;check recent input is a valid float number
mov rax, 0
mov rdi, rsp
call isfloat

;if not valid float number, send to bad_input to try again
cmp rax, 0
je bad_input_s1

;if input is valid float number, save value and jump to next function
mov rax, 0
mov rdi, rsp
call atof
movsd xmm12, xmm0
add rsp, 4096
jmp input_loop_s2



input_loop_s2:
;prompt the user for second side length
mov rax, 0
mov rdi, side_2
call printf

;Have user input number for second side length as a string
sub rsp, 4096
mov rdi, rsp
mov rsi, 4096
mov rdx, [stdin]
call fgets

;remove newline
mov rax, 0
mov rdi, rsp
call strlen
mov[rsp + rax-1], byte 0

;check recent input is a valid float number
mov rax, 0
mov rdi, rsp
call isfloat

;if not valid float number, send to bad_input to try again
cmp rax, 0
je bad_input_s2

;if input is valid float number, save value and jump to next function
mov rax, 0
mov rdi, rsp
call atof
movsd xmm13, xmm0
add rsp, 4096
jmp input_loop_a


;input is invalid, ask user to to input again
bad_input_s2:
mov rax, 0
mov rdi, invalid
call printf
add rsp, 4096

;Have user input number for second side length as a string again
sub rsp, 4096
mov rdi, rsp
mov rsi, 4096
mov rdx, [stdin]
call fgets

;remove newline
mov rax, 0
mov rdi, rsp
call strlen
mov[rsp + rax-1], byte 0

;check recent input is a valid float number
mov rax, 0
mov rdi, rsp
call isfloat

;if not valid float number, send to bad_input to try again
cmp rax, 0
je bad_input_s2

;if input is valid float number, save value and jump to next function
mov rax, 0
mov rdi, rsp
call atof
movsd xmm13, xmm0
add rsp, 4096
jmp input_loop_a



input_loop_a:
;prompt the user for angle in degrees
mov rax, 0
mov rdi, angle
call printf

;Have user input number for angle in degrees as a string
sub rsp, 4096
mov rdi, rsp
mov rsi, 4096
mov rdx, [stdin]
call fgets

;remove newline
mov rax, 0
mov rdi, rsp
call strlen
mov[rsp + rax-1], byte 0

;check recent input is a valid float number
mov rax, 0
mov rdi, rsp
call isfloat

;if not valid float number, send to bad_input to try again
cmp rax, 0
je bad_input_a

;if input is valid float number, save value and jump to next function
mov rax, 0
mov rdi, rsp
call atof
movsd xmm14, xmm0
add rsp, 4096
jmp input_data


;input is invalid, ask user to to input again
bad_input_a:
mov rax, 0
mov rdi, invalid
call printf
add rsp, 4096

;Have user input number for angle in degrees as a string again
sub rsp, 4096
mov rdi, rsp
mov rsi, 4096
mov rdx, [stdin]
call fgets

;remove newline
mov rax, 0
mov rdi, rsp
call strlen
mov[rsp + rax-1], byte 0

;check recent input is a valid float number
mov rax, 0
mov rdi, rsp
call isfloat

;if not valid float number, send to bad_input to try again
cmp rax, 0
je bad_input_a

;if input is valid float number, save value and jump to next function
mov rax, 0
mov rdi, rsp
call atof
movsd xmm14, xmm0
add rsp, 4096
jmp input_data



input_data:
;print data inputted by user
mov rax, 3
movsd xmm0, xmm12
movsd xmm1, xmm13
movsd xmm2, xmm14
mov rdi, results
mov rsi, user_name
call printf


;multiply 2 * side 1 * side 2 to multiply with cos of the angle later
movsd xmm11, xmm12
mulsd xmm11, xmm13
mulsd xmm11, [two]

;convert angle in degrees to angle in radians
mulsd xmm14, [pi]
divsd xmm14, [straight]

;get the cos of the angle
mov rax, 1
movsd xmm0, xmm14
call cos
movsd xmm14, xmm0

;find square of side 1
mulsd xmm12, xmm12

;find square of side 2
mulsd xmm13, xmm13

;multiply 2 * side 1 * side 2 with cos of the angle
mulsd xmm14, xmm11

;calculate the missing side
movsd xmm15, xmm12
addsd xmm15, xmm13
subsd xmm15, xmm14
sqrtsd xmm15, xmm15

;print results
mov rax, 1
movsd xmm0, xmm15 ;move side 3 length in xmm15 to xmm0 to print
mov rdi, side_3
call printf

;tell user that length of 3rd side will be sent back
mov rax, 0
mov rdi, sent
call printf

;get final time on system clock
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r12, rdx

;print final time
mov rax, 0
mov rdi, end_time
mov rsi, r12
call printf

;wish user a good day
mov rax, 0
mov rdi, goodday
mov rsi, user_title
mov rdx, user_name
call printf


;move results to stack
mov rax, 0
push qword 0
movsd [rsp], xmm15 ;move side 3 length in xmm15 to stack to restore sse registers

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;Send back side 3 length
movsd xmm0, [rsp] ;move side 3 length from top of stack to xmm0 to send back to main
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
;End of the function average ====================================================================

