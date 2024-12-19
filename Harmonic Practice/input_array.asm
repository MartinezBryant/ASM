global input_array
extern fgets
extern strtod
extern stdin
extern isfloat
extern hsum
extern printf

true equ -1
false equ 0

segment .data
    msg_error db "An error was detected. Re-enter the number", 10, 0

segment .bss
    ; You may declare other variables if needed.

segment .text
input_array:
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

    mov     r15, rdi                ; Store the array pointer into r15
    mov     r14, rsi                ; Store the max array length into r14
    xor     r13, r13                ; Clear r13 as the counter
    sub     rsp, 1024               ; Reserve 1024 bytes on the stack for the user input

begin:
    ; Get the user input
    mov     rdi, rsp                ; Store the input into the reserved space
    mov     rsi, 1023               ; Input a max of 1023 characters, excluding the null terminator
    mov     rdx, stdin              ; Use the standard input stream
    call    fgets                   ; fgets returns 0 in rax if CTRL + D is pressed

    ; Check if user input is CTRL + D
    cmp     rax, 0 
    je      exit                    ; Jump to exit if equal

    ; Validate if the input is in the form of a float
    mov     rdi, rsp                ; Pass the pointer to the input memory space
    call    isfloat                 ; isfloat returns -1 if not a float, 0 if valid

    ; If input is not valid, jump to error handling
    cmp     rax, false              ; false is defined as 0
    je      handle_error

    ; Convert valid input from string to double and store it in the array
    mov     rdi, rsp                ; Pass pointer to the input memory
    mov     rsi, rsp                ; Store the string in rsi for strtod
    call    strtod                  ; Convert string to double, rax will hold the result

    ; Check for conversion error (optional, depends on strtod implementation)
    ; You might want to check if rax is zero or another error condition

    movsd   [r15 + r13 * 8], xmm0   ; Move the double into the array (8 bytes for a double)

    ; Increment loop counter and check against max length
    inc     r13 
    cmp     r13, r14
    jge     exit
    jmp     begin    

handle_error:
    ; Inform the user of invalid input
    mov     rdi, msg_error          ; Move error message to rdi
    call    printf                  ; Print the error message

    ; Jump back to the beginning for new input
    jmp     begin

exit:
    add     rsp, 1024               ; Clean up stack space
    mov     rax, r13                ; Set rax to counter for return value

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

    ret                             ; Return from input_array function
