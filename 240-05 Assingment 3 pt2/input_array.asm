global input_array
extern sscanf
extern max_array_size

section .bss
input_buffer   resb 100             ; Buffer for user input

section .data
int_format     db "%ld", 0          ; Format for sscanf

section .text

input_array:


    push    rbp                     ; Backup base pointer
    mov     rbp, rsp                ; Set stack frame pointer
     ; Backup registers
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
    pushf                      

    ; Variables
    mov     rdi, rsi                ; rdi points to the array
    mov     rsi, max_array_size     ; rsi holds the max size
    xor     rcx, rcx                ; rcx will count the number of integers read

.read_input:
    ; Read input from stdin
    mov     rax, 0                  ; syscall number for read
    mov     rdi, 0                  ; file descriptor for stdin
    lea     rsi, [input_buffer]     ; buffer to store input
    mov     rdx, 100                ; maximum number of bytes to read
    syscall                          ; call kernel

    ; Check if end of input (0 bytes read)
    test    rax, rax
    jz      .end_input              ; Jump to end if nothing was read

    ; Parse integers from the input buffer
    mov     rdi, input_buffer       ; Pointer to input buffer
.parse_loop:
        ; Try to read an integer
        lea     rsi, [input_buffer]  ; Pointer to the current buffer position
        lea     rdx, [int_format]    ; Format for sscanf
        call    sscanf               ; Call sscanf to parse the integer

        ; If sscanf fails, exit the loop
        test    rax, rax
        jz      .end_input           ; Exit if no more integers

        ; Store the integer in the array
        mov     [rdi + rcx * 8], rax ; Store in array, 8 bytes per integer
        inc     rcx                  ; Increment count of integers

        ; Check if we reached the max array size
        cmp     rcx, rsi
        jb      .parse_loop          ; Repeat if we have not reached max size

.end_input:

   ; Restore flags and registers
    popf                              ; Restore flags
    pop        r15                    ; Restore registers
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
    pop        rbp                    ; Restore base pointer

    ret                               ; Return from manager function
