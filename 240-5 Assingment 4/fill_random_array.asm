;Bryant Martinez
;CWID : 886742121

global fill_random_array  

extern isnan              

;===========================================================================================
section .text

fill_random_array:       ; Start of the fill_random_array function

    push    rbp          ; Backup base pointer to maintain the stack frame
    mov     rbp, rsp     ; Set the base pointer to the current stack pointer
    ; Save callee-saved registers that will be used
    push       rbx
    push       rcx
    push       rdx
    push       rsi
    push       rdi
    push       r8
    push       r9
    push       r10
    push       r11
    push       r12
    push       r13
    push       r14
    push       r15
    pushf                ; Save the flags register

    mov     r15, rdi     ; Store the address of the array in r15 (first argument)
    mov     r14, rsi     ; Store the size of the array in r14 (second argument)
    xor     r13, r13     ; Clear r13, which will be the index for filling the array
    sub     rsp, 800     ; Allocate 800 bytes on the stack for temporary storage

;=================================== start the loop  ======================================

start_loop:
    mov     rax, 0       ; Clear rax to use it for comparison
    cmp     r13, r14     ; Compare the current index with the size of the array
    jl      apply_array   ; If index < size, jump to fill the array
    jmp     exit          ; Otherwise, exit the function

;=================================== fill the empty array ======================================
apply_array:
    mov     rax, 0       ; Clear rax again
    rdrand  r12          ; Generate a random number and store it in r12
    mov     rdi, r12     ; Move the random number to rdi for processing
    push    r12          ; Push the random number onto the stack for further use
    movsd   xmm15, [rsp] ; Move the random number from stack to xmm15 (SSE register)
    pop     r12          ; Pop the random number back into r12 (clean up stack)

;=================================== check nan =========================================

    mov     rax, 0       ; Clear rax
    movsd   xmm0, xmm15   ; Move the random number from xmm15 to xmm0
    call    isnan         ; Call isnan to check if the number is NaN
    je      apply_array   ; If it is NaN, jump back to apply_array to generate a new number

;=================================== add the array nn =========================================

    mov     rax, 0       ; Clear rax
    movsd   [r15 + r13 * 8], xmm15 ; Store the valid random number in the array
    inc     r13          ; Increment the index
    jmp     start_loop   ; Jump back to the start of the loop

exit:     
    add     rsp, 800     ; Clean up the stack by removing the allocated space

    ; Restore flags and registers
    popf                  ; Restore the flags register
    pop        r15        ; Restore registers in reverse order
    pop        r14
    pop        r13
    pop        r12
    pop        r11
    pop        r10
    pop        r9
    pop        r8
    pop        rdi
    pop        rsi
    pop        rdx
    pop        rcx
    pop        rbx
    pop        rbp          ; Restore the base pointer

    ret                   ; Return from the function
