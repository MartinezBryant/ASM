global sum
extern printf

segment .data
    debug db "Debug = %d", 10, 0

segment .bss

segment .text

sum:
    ;15 pushes
    push    rbp                     ; Backup rbp
    mov     rbp,rsp                 ; The base pointer now points to top of stack
    push    rdi                     ; Backup rdi
    push    rsi                     ; Backup rsi
    push    rdx                     ; Backup rdx
    push    rcx                     ; Backup rcx
    push    r8                      ; Backup r8
    push    r9                      ; Backup r9
    push    r10                     ; Backup r10
    push    r11                     ; Backup r11
    push    r12                     ; Backup r12
    push    r13                     ; Backup r13
    push    r14                     ; Backup r14
    push    r15                     ; Backup r15
    push    rbx                     ; Backup rbx
    pushf                           ; Backup rflags

    mov     r15, rdi                ; Store the array pointer into r15
    mov     r14, rsi                ; Store the count of the array into r14
    mov     r13, 0                  ; Set r13 as the counter
    mov     r12, 0                  ; Set r12 as the accumulator
    
begin:
    ; Add individual value from the array to the accumulator.
    add     r12, [r15 + r13 * 4]    ; r15 is the base address, r13 * 4 is how much address will be displaced, 4 is 4 bytes = 1 integer

    ; Increase the counter. Check if the counter >= the count of the array. 
    ; If it is, return. If it is not, jump back to the beginning
    inc     r13
    cmp     r13, r14
    jge     exit
    jmp     begin

exit:
    ; Set the accumulator as the return before returning
    mov     rax, r12

    ;15 pop
    popf                            ; Restore rflags
    pop     rbx                     ; Restore rbx
    pop     r15                     ; Restore r15
    pop     r14                     ; Restore r14
    pop     r13                     ; Restore r13
    pop     r12                     ; Restore r12
    pop     r11                     ; Restore r11
    pop     r10                     ; Restore r10
    pop     r9                      ; Restore r9
    pop     r8                      ; Restore r8
    pop     rcx                     ; Restore rcx
    pop     rdx                     ; Restore rdx
    pop     rsi                     ; Restore rsi
    pop     rdi                     ; Restore rdi
    pop     rbp                     ; Restore rbp

    ret