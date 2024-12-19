global manager

extern printf         ; C function to print messages
extern output_array   ; Function to output the array
extern input_array    ; Function to input the array
extern hsum           ; Function to compute harmonic sum

segment .data
    enter_sequence db "Enter a sequence of 64-bit floats separated by white space." 
    db "After the last input press enter followed by Control+D", 10, 0
    print db "debug = %lf", 10, 0
    result dq 0.0
segment .bss
    align 64
    storedata resb 832  ; Reserve space for 13 64-bit floats (832 bits)

segment .text

manager:
    ; 15 Pushes to back up registers
    push    rbp                     ; 1. Backup rbp
    mov     rbp,rsp                 ; Set rbp as the base pointer
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

    ; Set up function calls
    ; Print the message asking the user to enter the sequence
    mov     rdi, enter_sequence     ; rdi is the first argument for printf
    call    printf                  ; Call printf
    add     rsp, 8                  ; Adjust stack after calling printf (64-bit mode)

    ; Call input_array to get the data from the user
    mov     rdi, input_array_pointer
    mov     rsi, MAX_ARRAY_LENGTH
    call    input_array

    ; Call hsum to compute the harmonic sum
    mov     rdi, input_array_pointer
    mov     rsi, rax
    call    hsum

    movsd   [result], xmm0 

    ; Call output_array to display the results
    call    output_array


    ; 15 Pops to restore registers
    popf                            ; 1. Restore rflags
    pop     rbx                     ; 2. Restore rbx
    pop     r15                     ; 3. Restore r15
    pop     r14                     ; 4. Restore r14
    pop     r13                     ; 5. Restore r13
    pop     r12                     ; 6. Restore r12
    pop     r11                     ; 7. Restore r11
    pop     r10                     ; 8. Restore r10
    pop     r9                      ; 9. Restore r9
    pop     r8                      ; 10. Restore r8
    pop     rcx                     ; 11. Restore rcx
    pop     rdx                     ; 12. Restore rdx
    pop     rsi                     ; 13. Restore rsi
    pop     rdi                     ; 14. Restore rdi
    pop     rbp                     ; 15. Restore rbp

    ret                             ; Return from the manager function
