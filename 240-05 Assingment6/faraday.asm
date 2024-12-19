

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information 
;   name:  Bryant Martinez
;   email: Bryantmartinez322@csu.fullerton.edu
;   CWID:  886742121
;
;Program information
;  Program name: 240-05 Assingment6
;  Programming languages: 5 modules in x86_64 Intel i7 Assembly, and One Bash script
;  Date of last update: 2024-Dec-17
;  Files in this program: driver.asm, faraday.asm, atof.asm, ftoa.asm, strlen.asm, r.sh
;  Status: FULLY FUNCTIONAL, lacking some visuals, was tested within WSL Linux
;
;
;===== Begin code area ============================================================================================================
section .data
    prompt_name db "Please enter your full name: ", 0
    prompt_career db "Please enter the career path you are following: ", 0
    appreciate_career db "Thank you. We appreciate all ", 0
    prompt_emf db "Please enter the EMF of your circuit in volts: ", 0
    prompt_current db "Please enter the current in this circuit in amps: ", 0
    result_emf db "You entered ", 0
    result_current db "You entered ", 0
    result_resistance db "The resistance in this circuit is: %.2f", 0,10
    thank_you db "Thank you ", 0
    newline db 0xA, 0 ; Newline for formatting

section .bss
    name resb 64           ; Buffer for full name
    career resb 64         ; Buffer for career path
    emf resb 64            ; Buffer for EMF value
    current resb 64        ; Buffer for current value
    result_buffer resb 64  ; Buffer to store result for ftoa conversion

section .text
global faraday

; External function declarations
extern strlen            ; Declare the external strlen function
extern atof              ; Declare the external atof function (float conversion)
extern ftoa              ; Declare the external ftoa function (float to string)

faraday:
    ; Print prompt for name
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, prompt_name    ; Load address of prompt_name into rsi
    call sys_write          ; Call sys_write to print the message

    ; Read user input for name
    mov rdi, 0              ; File descriptor 0 (stdin)
    mov rsi, name           ; Load address of name buffer into rsi
    mov rdx, 64             ; Set buffer length for sys_read
    mov rax, 0              ; syscall: sys_read (0)
    syscall

    ; Calculate length of the name using strlen
    mov rsi, name           ; Load address of the name buffer into rsi
    call strlen             ; Call strlen to get the length of the name

    ; Write newline after name input
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, newline        ; Load newline address into rsi
    call sys_write          ; Call sys_write to print newline

    ; Print prompt for career
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, prompt_career  ; Load address of prompt_career into rsi
    call sys_write          ; Call sys_write to print the message

    ; Read user input for career
    mov rdi, 0              ; File descriptor 0 (stdin)
    mov rsi, career         ; Load address of career buffer into rsi
    mov rdx, 64             ; Set buffer length for sys_read
    mov rax, 0              ; syscall: sys_read (0)
    syscall

    ; Calculate length of the career path using strlen
    mov rsi, career         ; Load address of the career buffer into rsi
    call strlen             ; Call strlen to get the length of the career path

    ; Write newline after career input
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, newline        ; Load newline address into rsi
    call sys_write          ; Call sys_write to print newline

    ; Show appreciation for the career
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, appreciate_career  ; Load appreciation message into rsi
    call sys_write           ; Call sys_write to print the message
    mov rsi, career             ; Load career path into rsi
    call sys_write           ; Call sys_write to print the career path
    mov rsi, newline            ; Load newline into rsi
    call sys_write           ; Call sys_write to print newline

    ; Print prompt for EMF
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, prompt_emf     ; Load address of prompt_emf into rsi
    call sys_write          ; Call sys_write to print the message

    ; Read user input for EMF
    mov rdi, 0              ; File descriptor 0 (stdin)
    mov rsi, emf            ; Load address of emf buffer into rsi
    mov rdx, 64             ; Set buffer length for sys_read
    mov rax, 0              ; syscall: sys_read (0)
    syscall

    ; Output the EMF value entered
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, result_emf     ; Load result_emf message into rsi
    call sys_write          ; Call sys_write to print the result label
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, emf            ; Load address of emf buffer into rsi
    call sys_write          ; Output the EMF value
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, newline        ; Load newline into rsi
    call sys_write          ; Output newline after EMF

    ; Print prompt for current
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, prompt_current ; Load address of prompt_current into rsi
    call sys_write          ; Call sys_write to print the message

    ; Read user input for current
    mov rdi, 0              ; File descriptor 0 (stdin)
    mov rsi, current        ; Load address of current buffer into rsi
    mov rdx, 64             ; Set buffer length for sys_read
    mov rax, 0              ; syscall: sys_read (0)
    syscall

    ; Output the current value entered
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, result_current ; Load result_current message into rsi
    call sys_write          ; Call sys_write to print the result label
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, current        ; Load address of current buffer into rsi
    call sys_write          ; Output the current value
    mov rdi, 1              ; File descriptor 1 (stdout)
    mov rsi, newline        ; Load newline into rsi
    call sys_write          ; Output newline after current


    mov     rdi, 1
    mov     rsi, result_current
    call    sys_write
    mov     rdi, 1
    mov     rsi, result_resistance
    call    sys_write
    mov     rdi, 1
    mov     rsi, newline
    call    sys_write



    mov     rdi, 1
    mov     rsi, thank_you
    call    sys_write
    mov     rdi, 1
    mov     rsi, name
    call    sys_write

    ret

; Function to directly write a null-terminated string (sys_write)
sys_write:
    ; Calculate the length of the string using strlen
    call strlen             ; rax = length of the string in rsi

    mov rdx, rax            ; Length of the string (from strlen)
    mov rax, 1              ; syscall: sys_write
    syscall
    ret
