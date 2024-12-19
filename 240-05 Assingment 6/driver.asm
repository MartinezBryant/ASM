global driver
global _start


segment .data

    welcome_msg db "Welcome to Electricity brought to you by Bryant Martinez.", 0 ,10
    statement_msg db "This program will compute the resistance in your direct current circuit.", 0, 10
    end_msg db "The driver received this number %lf, and will keep it until next semester.", 0, 10
    return_msg db "A zero will be returned to the Operating System.", 0, 10



segment .bss



segment .text
extern printf


_start:
    
;print welcome msg

mov     rax, 0
mov     rdi, welcome_msg
call    printf

;print statement msg

mov     rax, 0
mov     rdi, statement_msg
call    printf


mov rax, 60         ; syscall number for exit
xor rdi, rdi        ; exit code 0
syscall
