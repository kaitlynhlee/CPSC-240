;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Kaitlyn Lee
;  Author email: kaitlynlee@csu.fullerton.edu
;  CWID: 886374479
;  Class: 240-03 Section 03
;  Date: March 20, 2024
;  240-3 Midterm Program
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

extern printf

extern scanf

extern atof

global electricity

extern current

extern isfloat

string_size equ 48

segment .data
;declare initialized arrays

floatform db "%s", 0
eforce db "Please enter the electric force in circuits (volts): ", 0
resistance_1 db "Please enter the resistance in circuit number 1 (ohms): ", 0
resistance_2 db "Please enter the resistance in circuit number 2 (ohms): ", 0
thanks db "Thank you.", 10, 0
badinput db "Invalid input. Try again: ", 0

segment .bss
;declare empty arrays

align 64
backup_storage_area resb 832


segment .text

electricity:

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


input_loop_e:
;prompt the user for electric force
mov rax, 0
mov rdi, eforce
call printf

;make room on the stack then obtain user's input for electric force
push qword 0
push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf

;check that electric force is a valid float number
mov rdi, rsp
call isfloat
cmp rax, 0
je  bad_input_e

;if electric force is valid float number, save value and jump to get resistance for circuit 1
mov rax, 0
mov rdi, rsp
call atof
movsd xmm15, xmm0
pop r9
pop r9
jmp input_loop_r1


;input for electric force is invalid, have user input again
bad_input_e:
pop rax
pop rax

;print message telling user input is bad and to try again
mov rax, 0
mov rdi, badinput
call printf

;have user input float for electric force again
push qword 0
push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf

;check new input for electric force is a valid float number
mov rdi, rsp
call isfloat
cmp rax, 0
je  bad_input_e

;if electric force is valid float number, save value and jump to get resistance for circuit 1
mov rax, 0
mov rdi, rsp
call atof
movsd xmm15, xmm0
pop r9
pop r9
jmp input_loop_r1



input_loop_r1:
;prompt the user for resistance in circuit 1
mov rax, 0
mov rdi, resistance_1
call printf

;make room on the stack then obtain user's input for resistance of circuit 1
push qword 0
push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf

;check that input for resistance of circuit 1 is a valid float
mov rdi, rsp
call isfloat
cmp rax, 0
je  bad_input_r1

;if resistance for circuit 1 is valid float number, save and jump to get resistance for circuit 2
mov rax, 0
mov rdi, rsp
call atof
movsd xmm14, xmm0
pop r9
pop r9
jmp input_loop_r2


;input for resistance of circuit 1 is invalid, ask user to to input again
bad_input_r1:
pop rax
pop rax

;print message telling user input is invalid and try again
mov rax, 0
mov rdi, badinput
call printf

;obtain user's new input for resistance of circuit 1
push qword 0
push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf

;check new resistance of circuit 1
mov rdi, rsp
call isfloat
cmp rax, 0
je  bad_input_r1

;if new resistance for circuit 1 is valid float number, save and jump to get resistance for circuit 2
mov rax, 0
mov rdi, rsp
call atof
movsd xmm14, xmm0
pop r9
pop r9
jmp input_loop_r2



input_loop_r2:
;prompt the user for resistance in circuit 2
mov rax, 0
mov rdi, resistance_2
call printf

;make room on the stack then obtain user's input for resistance in circuit 2
push qword 0
push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf

;check resistance in circuit 2 is valid float
mov rdi, rsp
call isfloat
cmp rax, 0
je  bad_input_r2

;if resistance in circuit 2 is valid float number, save value and jump to calc
mov rax, 0
mov rdi, rsp
call atof
movsd xmm13, xmm0
pop r9
pop r9
jmp calc


;resistance in circuit 2 is invalid, ask user to to input again
bad_input_r2:
pop rax
pop rax

;print message telling user invalid input and try again
mov rax, 0
mov rdi, badinput
call printf

;obtain new input for resistance in circuit 2
push qword 0
push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf

;check new resistance in circuit 2 is valid float
mov rdi, rsp
call isfloat
cmp rax, 0
je  bad_input_r2

;if resistance in circuit 2 is valid float number, save value and jump to calc
mov rax, 0
mov rdi, rsp
call atof
movsd xmm13, xmm0
pop r9
pop r9
jmp calc


calc:
;print message thanking user for inputs
mov rax, 0
mov rdi, thanks
call printf

;send electric force and resistance of both circuits to current to calculate currents
;call current function
mov rax, 3
movsd xmm0, xmm14
movsd xmm1, xmm13
movsd xmm2, xmm15
call current


;move results of total current from current function to stack
mov rax, 0
push qword 0
movsd [rsp], xmm0 ;move total current to stack to restore sse registers

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;Send back total current
movsd xmm0, [rsp] ;move total current from top of stack to xmm0 to send back to driver
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

