global manager                     ; Declare the manager function as global
extern input_array                 ; Declare external functions and variables
extern output_array
extern isinteger
extern printf                      ; External C library function for printing
extern strlen                      ; External C library function for string length
extern stdin                       ; Standard input stream
extern fgets                       ; External C library function for reading a string

segment .data
    max_array_size equ 832        ; Define the maximum size of the integer array
    prompt_name db "Please enter your name: ", 10, 0   ; Prompt for user's name
    intro_msg db "This program will sum your array of integers", 10,
                db "Enter a sequence of long integers separated by white space.", 10,
                db "After the last input press enter followed by Control+D:", 10, 0  ; Introductory message
    received_msg db "These numbers were received and placed into the array:", 10, 0  ; Confirmation message
    sum_msg db "The sum of the %d numbers in this array is %ld.", 10, 0  ; Format for displaying the sum
    sorted_msg db "This is the sorted array:", 10, 0  ; Message for sorted array display
    return_msg db "This program will return execution to the main function.", 10, 0  ; Return message


segment .bss
    array_int resq max_array_size  ; Reserve space for the array of integers
    name resb 99                    ; Reserve space for the name input
    sum resq 1                      ; Reserve space for the sum of the integers

segment .text

manager:
    push       rbp                  ; Backup base pointer
    mov        rbp, rsp             ; Set stack frame pointer

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
    pushf                          ; Backup flags

   ; Request the username 
    mov     rax, 0
    mov     rdi, prompt_name    ; Load address of prompt_name into rdi
    call    printf               ; Call printf to display the prompt

    ; username - read name 
    mov     rax, 0
    mov     rdi, name       ; Load address of name to store input
    mov     rsi, 99         ; Maximum number of bytes to read
    mov     rdx, [stdin]
    call    fgets

    mov     rax, 0
    mov     rdi, name               ; Get the length of the name
    call    strlen
    mov     [name+rax-1], byte 0        ; Null-terminate the string

    ; Print intro_msg       
    lea     rdi, [intro_msg]            ; Load address of intro_msg into rdi
    call    printf                   ; Display the intro message

    ;pring received_msg
    lea     rdi, [received_msg]     ; Load address of received_msg into rdi
    call    printf              ;print

    ; print sum_msg
    lea     rdi, [sum_msg]          ; Load address of received_msg into rdi
    call    printf              ;print

    ; print sorted_msg
    lea     rdi, [sorted_msg]           ; Load address of received_msg into rdi
    call    printf          ;print

    ;return name       

    mov rax,name            ; Move the address of name into rax for return


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
