;name: Kaitlyn Lee
;email: kaitlynlee@csu.fullerton.edu
;class number: CPSC 240-3
;date: May 13, 2024

;declarations

extern atof
extern printf
extern scanf
extern isfloat
global dot

segment .data
;declare initialized arrays
first_prompt db "Please enter two floats separated by ws for the first vector: ", 0
second_prompt db "Thank you. Please enter two floats separated by ws for the second vector: ", 0
thanks db "Thank you.", 10, 10, 0

result db "The dot product is %.1lf", 10, 0
enjoy db "Enjoy your dot product.", 10, 0

error_msg db "Invalid float number. Try again: ", 0

float_form db "%s", 0

segment .bss
;declare empty arrays

align 64
backup_storage_area resb 832


segment .text

dot:

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

mov r14, 0

mov rax, 0
mov rdi, first_prompt
call printf

input_num:
push qword 0
push qword 0
mov rax, 0
mov rdi, float_form
mov rsi, rsp
call scanf

mov rdi, rsp
call isfloat
cmp rax, 0
je  invalid_float

mov rax, 0
mov rdi, rsp
call atof
movsd xmm15, xmm0
pop r9
pop r9

push qword 0
push qword 0
mov rax, 0
mov rdi, float_form
mov rsi, rsp
call scanf

mov rdi, rsp
call isfloat
cmp rax, 0
je  invalid_float

mov rax, 0
mov rdi, rsp
call atof
movsd xmm14, xmm0
pop r9
pop r9

mov rax, 0
mov rdi, second_prompt
call printf

push qword 0
push qword 0
mov rax, 0
mov rdi, float_form
mov rsi, rsp
call scanf

mov rax, 0
mov rdi, rsp
call atof
movsd xmm13, xmm0
pop r9
pop r9

push qword 0
push qword 0
mov rax, 0
mov rdi, float_form
mov rsi, rsp
call scanf

mov rax, 0
mov rdi, rsp
call atof
movsd xmm12, xmm0
pop r9
pop r9
jmp calc

invalid_float:
;inform user that the input is invalid and will not be counted, before jumping back to is_less to allow the user to try again
mov rax, 0
mov rdi, error_msg
call printf
pop r9
pop r9
jmp input_num


calc:
mov rax, 0
mov rdi, thanks
call printf

mulsd xmm15, xmm13
mulsd xmm14, xmm12

addsd xmm15, xmm14

;print results
mov rax, 1
movsd xmm0, xmm15
mov rdi, result
call printf

mov rax, 0
mov rdi, enjoy
call printf


;move results to stack
mov rax, 0
push qword 0
movsd [rsp], xmm15 

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;Send back
movsd xmm0, [rsp] 
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
