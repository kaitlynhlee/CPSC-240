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
;  Program name: Arrays of Floating Point Numbers
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
;  File name: input_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l input.lis -o input.o input_array.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l input.lis -o input.o input_array.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double input_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

extern printf

extern scanf

extern atof

extern isfloat

global input_array


segment .data                 ;Place initialized data here
  floatformat db "%s", 0
  not_a_float db "The last input was invalid and not entered into the array", 10, 0
  full_message db "The array has been filled.", 10, 0


segment .bss      ;Declare pointers to un-initialized space in this segment.
  align 64
  backup_storage_area resb 832
  
segment .text
input_array:

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

;backup other registers/sse registers
mov rax,7
mov rdx,0
xsave [backup_storage_area]

;store array address and array max size in non-volatile registers to use when inputting values into array as well as ensuring the number of values stays within the maximum
mov r15, rdi
mov r14, rsi


;set r13 to zero in order to use as a counter for the float point numbers for both array length and to ensure the number of values is within the limits
mov r13, 0

;ensure the number of values in the array are within its maximum size
check_capacity:
;compare the counter to the max array size and jump to is_less for user float number inputs if array is not full yet, otherwise jump to is_full for function end
cmp r13, r14
jl is_less
; if counter greater/equal to array max size then jump to is_full function for function end
jmp is_full

; if number of values in the array is still less than size of array jump here to allow user to input floats
is_less:
;make room on the stack then obtain user's floating point number input to put into the array
push qword 0
push qword 0
mov rax, 0
mov rdi, floatformat
mov rsi, rsp
call scanf

;check whether user has input control+d in order to end the function/stop inputting values into function
cdqe
cmp rax, -1
je control_d

; Check if user's input is a valid float, jumping to not_float to send user an error message and allow them to try again
mov rdi, rsp
call isfloat
cmp rax, 0
je  not_float

;convert the floating point number in the string into a float value after checking it is valid
;Setting up atof
mov rax, 0
mov rdi, rsp
call atof
movsd xmm15, xmm0
pop r9
pop r9

;store the floating point number into its own address, the counters index in the array
movsd [r15+r13*8], xmm15

;increase the counter for array size/number of values inputted so far, then jump back to check_capacity to allow user to continue inputting float numbers if the array is not yet full
inc r13
jmp check_capacity

;jump here if capacity of the array has been met/number of array values have reached the maximum size
is_full:
;inform user that the array is now full, before jumping to function end
mov rax, 0
mov rdi, full_message
call printf
jmp exit

;jump here if the user has not inputted a valid floating point number
not_float:
;inform user that the input is invalid and will not be counted, before jumping back to is_less to allow the user to try again
mov rax, 0
mov rdi, not_a_float
call printf
pop r9
pop r9
jmp is_less

;jump here if user inputs control+d to end their input of floats
control_d:
;pop values off stack to avoid segmentation fault before going to function end
pop r9
pop r9
jmp exit

;restore registers and send array length back to manager for use in other functions
exit:
;restore the values to non-GPRs/sse registers
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;store the length of the array/float counter into rax to be sent back to manager
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
;End of the function input_array ====================================================================

