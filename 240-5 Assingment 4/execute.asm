; Bryant Martinez
; CWID: 886742121

global execute

; External function declarations
extern fill_random_array
extern show_array
extern normalize_array
extern sort

; Constants for buffer sizes
array_string equ 50
name2 equ 48
title2 equ 48

section .data
    ; Prompt messages and output formats
    Prompt_name db "Please enter your name: ", 10, 0
    Prompt_title db "Please enter your title (Mr, Ms, Sergeant, Chief, Project, Leader, etc): ", 10, 0
    Ouput_name_title db "Nice to meet you %s %s", 10, 0
    IEEfloats db "This program will generate 64-bit IEEE float numbers.", 10, 0
    Insertnum db "How many numbers do you want? Today's limit is 100 per customer.", 10, 0
    Insert_array db "Your numbers have been stored in an array. Here is that array: ", 10, 0
    Normalized_array db "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array:", 10, 0
    Stored_array db "The array will now be sorted.", 10, 0
    Goodbye_msg db "Goodbye %s. You are welcome any time.", 10, 0
    empty_space db "", 10, 0
    float_form dq "%lf", 0
    int_form db "%d", 0

section .bss
    align 64
    backup_storage resb 832  ; Space to back up registers

    user_name resb name2      ; Buffer for user's name
    title resb title2          ; Buffer for user's title
    the_array resq array_string ; Array to store float numbers

section .text

extern printf, stdin, fgets, strlen, scanf

execute:
; Backup General Purpose Registers (GPRs)
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

; Save current state of XMM registers
    mov rax, 7
    mov rdx, 0
    xsave [backup_storage]

; Prompt user for their name
    mov rax, 0
    mov rdi, Prompt_name
    call printf

; Read user's name from input
    mov rdi, user_name
    mov rsi, name2
    mov rdx, [stdin]
    call fgets

; Remove newline character from the name
    mov rax, 0
    mov rdi, user_name
    call strlen
    mov [user_name + rax - 1], byte 0  ; Replace newline with null terminator

; Prompt for user's title
    mov rdi, Prompt_title
    call printf

; Read user's title from input
    mov rdi, title
    mov rsi, title2
    mov rdx, [stdin]
    call fgets

; Remove newline character from the title
    mov rax, 0
    mov rdi, title
    call strlen
    mov [title + rax - 1], byte 0  ; Replace newline with null terminator

; Output the full name and title
    mov rdi, Ouput_name_title
    mov rsi, title
    mov rdx, user_name
    call printf

; Notify user about float generation
    mov rdi, IEEfloats
    call printf

; Prompt user for number of elements
    mov rdi, Insertnum
    call printf

; Retrieve number of elements for the array
    mov rdi, int_form
    mov rsi, rsp
    call scanf
    mov r15, [rsp]  ; Store number of elements in r15

; Call function to fill array with random floats
    mov rdi, the_array
    mov rsi, r15   ; Pass the number of items to fill_random_array
    call fill_random_array

; Inform user about stored numbers
    mov rax, 0
    mov rdi, Insert_array
    call printf

; Add a blank line for aesthetics
    mov rdi, empty_space
    call printf

; Display the filled array
    mov rdi, the_array
    mov rsi, r15
    call show_array

; Call normalization function on the array
    mov rdi, the_array
    mov rsi, r15
    call normalize_array

; Notify user about normalization
    mov rdi, Normalized_array
    call printf

; Add a blank line for aesthetics
    mov rdi, empty_space
    call printf

; Show the normalized array
    mov rdi, the_array
    mov rsi, r15
    call show_array

; Notify user that the array will be sorted
    mov rdi, Stored_array
    call printf

; Add a blank line for aesthetics
    mov rdi, empty_space
    call printf

; Call sorting function
    mov rdi, the_array
    mov rsi, r15
    call sort

; Display the sorted array
    mov rdi, the_array
    mov rsi, r15
    call show_array

; Output goodbye message to the user
    mov rdi, Goodbye_msg
    mov rsi, title
    call printf

; Restore XMM registers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage]

; Move the user's name to rax for return to main
    mov rax, user_name

; Restore GPRs and return
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp   ; Restore the base pointer
    ret
