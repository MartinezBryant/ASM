;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information 
;   name:  Bryant Martinez
;   email: Bryantmartinez322@csu.fullerton.edu
;   CWID:  886742121
;
;Program information
;  Program name: 240-05 Assignment6
;  Programming languages: 5 modules in x86_64 Intel i7 Assembly, and One Bash script
;  Date of last update: 2024-Dec-17
;  Files in this program: driver.asm, faraday.asm, atof.asm, ftoa.asm, strlen.asm, r.sh
;  Status: FULLY FUNCTIONAL, lacking some visuals, was tested within WSL Linux
;
;
;===== Begin code area ============================================================================================================
global _start
extern faraday                ; Declare the external Faraday function

section .data
    welcome_msg   db "Welcome to Electricity brought to you by Bryant Martinez.", 0xA, 0
    statement_msg db "This program will compute the resistance in your direct current circuit.", 0xA, 0
    end_msg       db "The driver received this number and will keep it until next semester.", 0xA, 0
    return_msg    db "A zero will be returned to the Operating System.", 0xA, 0
    newline       db 0xA, 0          ; Newline for formatting
    output_msg    db "The resistance in this circuit is ", 0, 10
    ohms_msg      db " ohms.", 0, 10

section .bss
    resistance    resq 1         ; To store the resistance value returned by faraday

section .text

_start:

driver:
    ; Print welcome message
    mov     rax, 1               ; syscall: write
    mov     rdi, 1               ; file descriptor: stdout
    mov     rsi, welcome_msg     ; address of message
    mov     rdx, 59              ; length of message (including newline)
    syscall

    ; Print statement message
    mov     rax, 1               ; syscall: write
    mov     rdi, 1               ; file descriptor: stdout
    mov     rsi, statement_msg   ; address of message
    mov     rdx, 74              ; length of message (including newline)
    syscall

    ; Call Faraday module (user interaction and resistance calculation)
    call    faraday              ; Perform user interaction and resistance computation

    ; Print resistance message
    mov     rax, 1               ; syscall: write
    mov     rdi, 1               ; file descriptor: stdout
    mov     rsi, output_msg      ; address of the message
    mov     rdx, 34              ; length of message (without resistance value)
    syscall


    ; Print "ohms" after the resistance
    mov     rax, 1               ; syscall: write
    mov     rdi, 1               ; file descriptor: stdout
    mov     rsi, ohms_msg        ; address of "ohms"
    mov     rdx, 10              ; length of "ohms."
    syscall

    ; Print return message
    mov     rax, 1               ; syscall: write
    mov     rdi, 1               ; file descriptor: stdout
    mov     rsi, return_msg      ; address of message
    mov     rdx, 50             ; length of message (including newline)
    syscall

    ; Exit program
    mov     rax, 60              ; syscall: exit
    xor     rdi, rdi             ; return value: 0
    syscall

print_float: