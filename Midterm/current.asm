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

global current

segment .data
;declare initialized arrays
current_1 db "The current on the first circuit is %.5lf amps.", 10, 0
current_2 db "The current on the second circuit is %.5lf amps.", 10, 0
total_current db "The total current is %.5lf amps.", 10, 0
;testing db "test test %.5lf %.5lf %.5lf",10, 0

segment .bss
;declare empty arrays

align 64
backup_storage_area resb 832

segment .text

current:

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

;storing resistances and electric force into non-volatile registers to use for calculations
movsd xmm0, xmm14
movsd xmm1, xmm13
movsd xmm2, xmm15

;testing block to make sure values were received
;mov rax, 3
;mov rdi, testing
;movsd xmm0, xmm14
;movsd xmm1, xmm13
;movsd xmm2, xmm15
;call printf

;calculate the current for circuit 1
movsd xmm10, xmm15
divsd xmm10, xmm14

;calculate the current for circuit 2
movsd xmm11, xmm15
divsd xmm11, xmm13

;calculate total current
movsd xmm12, xmm10
addsd xmm12, xmm11

;print results for current for circuit 1
mov rax, 1
mov rdi, current_1
movsd xmm0, xmm10
call printf

;print results for current for circuit 2
mov rax, 1
mov rdi, current_2
movsd xmm0, xmm11
call printf

;print results for total current
mov rax, 1
mov rdi, total_current
movsd xmm0, xmm12
call printf



;move the total current to stack for safekeeping while the sse registers are restored
mov rax, 0
push qword 0
movsd [rsp], xmm12

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;Store the total current to be sent back to electricity to send to main
movsd xmm0, [rsp] ;send back to driver
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
;End of the function compute_mean ====================================================================

