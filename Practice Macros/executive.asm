
global executive
extern printf
%include "macros.inc"



segment .data
msg_output db "your lucky number %d", 10,0
format db "%d ", 0
msg_secrete db "your secret number is %d %d %d %d" , 10,0
nice_arrray dq 1,2,3,4,5,6,7 

segment .bss

segment .text

executive:

push    rbp
mov     rbp, rsp

;backup_registers
backup_registers


mov     rax, 0 ; we use rax 0 because we dont use float number
mov     rdi, msg_output
set_rsi 99
call    printf

mov     rax, 0 ; we use rax 0 because we dont use float number
mov     rdi, msg_secrete
set_rsi 99, 42, 50, 33
call    printf


add_num 25,75
mov     r15, rax

mov     rax, 0
mov     rdi, msg_output
mov     rsi, r15
call    printf


print_debug msg_output, 9898


min_num  1111,572
mov      r14, rax

print_debug msg_output, r14
;----------------------------------------------------------------------------------------------------
;Array Problem

output_array nice_arrray, 7, format



restore_registers
;restore_registers

pop     rbp
ret