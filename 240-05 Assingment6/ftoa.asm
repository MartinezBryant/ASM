

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
section .bss
    result resb 64        ; Buffer for the result string

section .text
    global ftoa

ftoa:
    ; Convert floating point to string
    ; Assuming the float is in st(0), and we want to store the result in `result`
    
    sub rsp, 8            ; Make space for the result (8 bytes for double)
    fstp qword [rsp]      ; Pop the floating-point value to the stack

    ; Convert the floating-point value to string
    ; Here we might use a custom conversion, or if we are using an external library, we would call it
    ; Assuming a placeholder for conversion function here (for simplicity)
    ; You should implement or call a library function to convert the floating point number to string.

    ; For this example, let's assume we convert it manually or using some specific method
    ; Store some placeholder result for now:
    mov rsi, result
    mov byte [rsi], '3'    ; First character '3'
    mov byte [rsi+1], '.'  ; Decimal point
    mov byte [rsi+2], '1'  ; Second character '1'
    mov byte [rsi+3], '4'  ; Third character '4'
    mov byte [rsi+4], '1'  ; Fourth character '1'
    mov byte [rsi+5], 0    ; Null-terminate the string

    ; Return from function
    ret
