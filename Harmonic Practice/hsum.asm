global hsum
extern printf
extern input_array

segment .data
    debug db "debug = %lf", 10, 0
    one_point_o dq 1.0           ; This could be used for harmonic calculations

segment .bss
    align 64
    storedata resb 832           ; Reserve 832 bytes for potential use

segment .text

hsum:
    ; 15 pushes to backup registers
    push    rbp                     ; 1. Backup rbp
    mov     rbp, rsp                 ; Set rbp as the base pointer
    push    rdi                     ; 2. Backup rdi
    push    rsi                     ; 3. Backup rsi
    push    rdx                     ; 4. Backup rdx
    push    rcx                     ; 5. Backup rcx
    push    r8                      ; 6. Backup r8
    push    r9                      ; 7. Backup r9
    push    r10                     ; 8. Backup r10
    push    r11                     ; 9. Backup r11
    push    r12                     ; 10. Backup r12
    push    r13                     ; 11. Backup r13
    push    r14                     ; 12. Backup r14
    push    r15                     ; 13. Backup r15
    push    rbx                     ; 14. Backup rbx
    pushf                           ; 15. Backup rflags

    ; Prepare registers for summation
    mov     r15, rdi                ; r15 points to the array
    mov     r14, rsi                ; r14 holds the max array length
    xor     r13, r13                ; Clear r13 to use as index
    xorpd   xmm13, xmm13            ; Clear xmm13 to accumulate the sum

begin:
    ; Check if index has reached the maximum length
    cmp     r13, r14
    jge     exit                    ; Exit if r13 >= r14

    ; Load the next double from the array into xmm14
    movsd   xmm14, [r15 + 8 * r13]  ; Each double is 8 bytes

    ; If calculating harmonic sum, compute the reciprocal
    ; movsd   xmm14, one_point_o      ; Uncomment if using for harmonic sum
    ; divsd   xmm14, xmm14            ; Uncomment to compute 1/x for harmonic sum

    ; Perform the summation
    addsd   xmm13, xmm14            ; Add current double to the sum

    inc     r13                      ; Increment index
    jmp    begin                     ; Repeat the loop

exit:
    ; Move the result into xmm0 for return
    movsd   xmm0, xmm13              ; Store the result in xmm0

    ; 15 pops to restore registers
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

    ret                             ; Return from hsum
