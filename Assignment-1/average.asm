;****************************************************************************************************************************
;Program name: "Average Driving Time".  This program calculates the average driving speed and time it took to go a certain distance based on user input
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
;  Program name: Average Driving Time
;  Programming languages: One module in C, one in X86, and one in bash.
;  Date program began: 2024-Jan-30
;  Date of last update: 2024-Feb-4
;  Files in this program: driver.c, average.asm, r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program is a driving time, speed, and distance calculator based on the user's input
;
;This file:
;  File name: average.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l avg.lis -o avg.o average.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l avg.lis -o avg.o average.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: unsigned long helloword();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

extern printf

extern scanf

extern fgets

extern stdin

extern strlen

global average

string_size equ 48

segment .data
;declare initialized arrays

prompt_for_name db "Please enter your first and last names: ",0
prompt_for_title db "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc: ",0
thanks_message db "Thank you %s %s.",10,0
distance_F2S db 10, "Enter the number of miles traveled from Fullerton to Santa Ana: ", 0
distance_S2L db 10, "Enter the number of miles traveled from Santa Ana to Long Beach: ", 0
distance_L2F db 10, "Enter the number of miles traveled from Long Beach to Fullerton: ", 0
speed db "Enter your average speed during that leg of the trip: ", 0
processing db 10, "The inputted data are being processed", 10, 10, 0
results_distance db "The total distance traveled is %.8lf miles.", 10, 0
results_time db "The time of the trip is %.8lf hours.", 10, 0
results_speed db "The average speed during this trip is %.8lf mph", 10, 0
num db "%lf", 0

segment .bss
;declare empty arrays

align 64
backup_storage_area resb 832

user_name resb string_size
user_title resb string_size

segment .text

average:

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

;Remove newline
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

;Remove newline
mov rax, 0
mov rdi, user_title
call strlen
mov [user_title+rax-1], byte 0

;thank user
mov rax,0
mov rdi, thanks_message
mov rsi, user_title
mov rdx, user_name
call printf


;prompt user for distance from Fullerton to Santa Ana
mov rax, 0
mov rdi, distance_F2S
call printf

;input distance from Fullerton to Santa Ana
mov rax, 0
push qword 0
push qword 0
mov rdi, num
mov rsi, rsp
call scanf
movsd xmm10, [rsp] ;put user-input distance into xmm10
pop rax
pop rax

;prompt user for speed from Fullerton to Santa Ana
mov rax, 0
mov rdi, speed
call printf

;input speed from Fullerton to Santa Ana
mov rax, 0
push qword 0
push qword 0
mov rdi, num
mov rsi, rsp
call scanf
movsd xmm11, [rsp] ;put user-input speed into xmm11
pop rax
pop rax

;add distance from Fullerton to Santa Ana to total
movsd xmm13, xmm10 ;since nothing in xmm13 yet, move first distance in xmm10 into xmm13 (will hold sum of all distance values)

;calculate time taken to go from Fullerton to Santa Ana
divsd xmm10, xmm11 ;divide distance in xmm10 by speed in xmm11 to get time
movsd xmm14, xmm10 ;since nothing in xmm14 yet, move first time in xmm10 into xmm13 (will hold sum of all time values)


;prompt user for distance from Santa Ana to Long Beach
mov rax, 0
mov rdi, distance_S2L
call printf

;input distance from Santa Ana to Long Beach
mov rax, 0
push qword 0
push qword 0
mov rdi, num
mov rsi, rsp
call scanf
movsd xmm10, [rsp] ;put user-input distance into xmm10
pop rax
pop rax

;prompt user for speed from Santa Ana to Long Beach
mov rax, 0
mov rdi, speed
call printf

;input speed from Santa Ana to Long Beach
mov rax, 0
push qword 0
push qword 0
mov rdi, num
mov rsi, rsp
call scanf
movsd xmm11, [rsp] ;put user-input speed into xmm11
pop rax
pop rax

;add distance from Santa Ana to Long Beach to total
addsd xmm13, xmm10 ;add distance in xmm10 to total distance in xmm13

;calculate time taken to go from Santa Ana to Long Beach
divsd xmm10, xmm11 ;divide distance in xmm10 by speed in xmm11 to get time
addsd xmm14, xmm10 ;add time in xmm10 to total time in xmm14


;prompt user for distance from Long Beach to Fullerton
mov rax, 0
mov rdi, distance_L2F
call printf

;input distance from Long Beach to Fullerton
mov rax, 0
push qword 0
push qword 0
mov rdi, num
mov rsi, rsp
call scanf
movsd xmm10, [rsp] ;put user-input distance into xmm10
pop rax
pop rax

;prompt user for speed from Long Beach to Fullerton
mov rax, 0
mov rdi, speed
call printf

;input speed from Long Beach to Fullerton
mov rax, 0
push qword 0
push qword 0
mov rdi, num
mov rsi, rsp
call scanf
movsd xmm11, [rsp] ;put user-input speed into xmm11
pop rax
pop rax

;add distance from Long Beach to Fullerton to total
addsd xmm13, xmm10 ;add distance in xmm10 to total distance in xmm13

;calculate time taken to go from Long Beach to Fullerton
divsd xmm10, xmm11 ;divide distance in xmm10 by speed in xmm11 to get time
addsd xmm14, xmm10 ;add time in xmm10 to total time in xmm14


;send message about processing data
mov rax, 0
mov rdi, processing
call printf

;calculate average speed
movsd xmm15, xmm13 ;move total distance from xmm13 into xmm15 to divide for average speed
divsd xmm15, xmm14 ;divide total distance in xmm15 by total time in xmm14 to get average speed


;print results for distance
mov rax, 1
movsd xmm0, xmm13 ;move total distance in xmm13 to xmm0 to print
mov rdi, results_distance
call printf

;print results for time
mov rax, 1
movsd xmm0, xmm14 ;move total time in xmm14 to xmm0 to print
mov rdi, results_time
call printf

;print results for speed
mov rax, 1
movsd xmm0, xmm15 ;move average speed in xmm15 to xmm0 to print
mov rdi, results_speed
call printf

;move results to stack
mov rax, 0
push qword 0
movsd [rsp], xmm15 ;move average speed in xmm15 to stack to restore sse registers

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;Send back average speed
movsd xmm0, [rsp] ;move average speed from top of stack to xmm0 to send back to driver
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

