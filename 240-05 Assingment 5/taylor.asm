global taylor                    ; Declare the global label for the taylor function
extern printf                    ; Declare the external printf function

segment .data
print_msg db "f%",0              ; Format specifier for printing a float value

segment .bss

segment .text

taylor:
    ; Backup registers
    push    rbp                  ; Save the base pointer
    mov     rbp, rsp             ; Set the base pointer to the current stack pointer
    push    rbx                  ; Save general-purpose registers
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf                         ; Save the flags register

xor         r14, r14             ; Clear r14 (used as a loop counter)
xor         r11, r11             ; Clear r11 (used for term calculation)
inc         r11                  ; Increment r11 to 1
cvtsi2sd    xmm11, r11           ; Convert r11 to a double-precision float in xmm11

xor         r13, r13             ; Clear r13 (used for term calculation)
inc         r13                  ; Increment r13 to 1
cvtsi2sd    xmm13, r13           ; Convert r13 to a double-precision float in xmm13

mov         r15, rdi             ; Move the number of terms (n) to r15
movsd       xmm15, xmm0          ; Move the input value (x) to xmm15

loop_begin:
cmp     r14, r15                 ; Compare the loop counter (r14) with the number of terms (r15)
jge     loop_end                 ; If r14 >= r15, jump to loop_end

inc         r14                   ; Increment loop counter r14
cvtsi2sd    xmm14, r14            ; Convert loop counter r14 to a double-precision float in xmm14

mulsd   xmm11, xmm15             ; Multiply xmm11 by the value of x (xmm15)
mulsd   xmm13, xmm14             ; Multiply xmm13 by the current loop counter (xmm14)

movsd   xmm10, xmm11             ; Move the product of xmm11 into xmm10
divsd   xmm10, xmm13             ; Divide xmm10 by the product of xmm13
addsd   xmm12, xmm10             ; Add the result to the running sum in xmm12

jmp     loop_begin               ; Jump back to the beginning of the loop

mov     rdi, print_msg           ; Load the format string for printing
movsd   xmm0, xmm12              ; Move the sum result to xmm0
xor     rax, rax                 ; Clear rax
call    printf                   ; Call printf to print the result

loop_end:

    ; Return sum
    movsd   xmm0, xmm12          ; Move the final sum into xmm0

    ; Restore registers
    popf                          ; Restore flags register
    pop     r15                   ; Restore general-purpose registers
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp                   ; Restore base pointer
    ret                           ; Return from the function
