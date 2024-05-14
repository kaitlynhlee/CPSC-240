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
;  File name: executive.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -o executive.o executive.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -o executive.o executive.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern char* executive();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

extern printf
extern fill_random_array
extern sort
extern show_array
extern normalize_array
extern scanf
extern fgets
extern stdin
extern strlen

global executive

string_size equ 48


segment .data                 ;Place initialized data here
prompt_for_name db "Please enter your name: ",0
prompt_for_title db "Please enter your title (Mr, Ms, Sergeant, Chief, Project Leader, etc): ", 10, 0
nice_message db "Nice to meet you %s %s.", 10, 10, 0

program_msg db "This program will generate 64-bit IEEE float numbers.", 10, 0
amount db "How many numbers do you want. Today's limit is 100 per customer. ", 0
bad_size db "Size not in range. Try again.", 10, 0
intformat db "%d", 0

stored_msg db "Your numbers have been stored in an array. Here is that array.", 10, 10, 0
normalized_msg db 10, "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array.", 10, 10, 0
sorted_msg db 10, "The array will now be sorted.", 10, 10, 0

goodbye_msg db 10, "Good bye %s. You are welcome any time.", 10, 10, 0


segment .bss      ;Declare pointers to un-initialized space in this segment.
align 64
backup_storage_area resb 832

user_name resb string_size
user_title resb string_size
my_array resq 100 ; <name> <data-type> <size>


segment .text
executive:

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

;send the user a nice message
mov rax, 0
mov rdi, nice_message
mov rsi, user_title
mov rdx, user_name
call printf


;obtain the size the array should be from the user
get_size:
mov rax, 0
mov rdi, program_msg
call printf

;prompt the user for the size of the array
mov rax, 0
mov rdi, amount
call printf

;obtain user input for how big they want the array to be
push qword 0
push qword 0
mov rax, 0
mov rdi, intformat
mov rsi, rsp
call scanf
mov r15, [rsp]
pop rax
pop rax

;jump to tell user size is not in limits if it is too small
cmp r15, 0
jl wrong_size

;jump to tell user size is not in limits if it is too big
cmp r15, 100
jg wrong_size

;if size is within limits, jump to create the array
jmp continue

;if the size given by user is not in limits, let them know and return to try again
wrong_size:
mov rax, 0
mov rdi, bad_size
call printf
jmp get_size


;if the array size is within the limits, generate an array of random numbers with that number of values
continue:
mov rax, 0
mov rdi, my_array
mov rsi, r15
call fill_random_array

;tell the user the array of random numbers will be printed
mov rax, 0
mov rdi, stored_msg
call printf

;print the array of random numbers
mov rax, 0
mov rdi, my_array
mov rsi, r15
call show_array


;normalize the array of random numbers
mov rax, 0
mov rdi, my_array
mov rsi, r15
call normalize_array

;tell the user the normalized array will now print
mov rax, 0
mov rdi, normalized_msg
call printf

;print the normalized array
mov rax, 0
mov rdi, my_array
mov rsi, r15
call show_array


;sort the normalized array
mov rax, 0
mov rdi, my_array
mov rsi, r15
call sort

;tell the user the sorted array will now print
mov rax, 0
mov rdi, sorted_msg
call printf
  
;print the sorted array
mov rax, 0
mov rdi, my_array
mov rsi, r15
call show_array

;print a message saying goodbye to the user
mov rax, 0
mov rdi, goodbye_msg
mov rsi, user_title
call printf

;Restore the values to non-GPRs/sse registers
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;send the name of the user back to main to be printed
mov rax, user_name

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
;End of the function executive ====================================================================

