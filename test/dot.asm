segment .data

zero dq 0.0

segment .bss

section .text

global dot
extern input_array
extern manager


dot:

     ; 15 pushes to save registers and flags
    push    rbp
    mov     rbp, rsp
    push    rdi
    push    rsi
    push    rdx
    push    rcx
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    push    rbx
    pushf


    ; rdi = arrayA, rsi = arrayB, rdx = length
    ; Initialize sum to 0
    movsd   xmm0, [rel zero]        ; xmm0 will store the result (dot product)
    xor     rcx, rcx                ; rcx will act as the index counter
    
dot_loop:
    ; Check if rcx >= length (rdx)
    cmp     rcx, rdx
    jge     end_dot

    ; Load the next values from arrayA and arrayB
    movsd   xmm1, [rdi + rcx * 8]   ; Load element from arrayA into xmm1
    movsd   xmm2, [rsi + rcx * 8]   ; Load element from arrayB into xmm2

    ; Multiply xmm1 and xmm2 and add to xmm0
    mulsd   xmm1, xmm2
    addsd   xmm0, xmm1

    ; Increment index and continue loop
    inc     rcx
    jmp     dot_loop

end_dot:
    ; 15 pops to restore registers and flags
    popf
    pop     rbx
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rcx
    pop     rdx
    pop     rsi
    pop     rdi
    pop     rbp

    ret