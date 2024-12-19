

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
section .text
global strlen

strlen:
    xor rax, rax            ; Clear rax (to store length)
    xor rcx, rcx            ; Clear rcx (counter)

find_null:
    cmp byte [rsi + rcx], 0 ; Compare byte at address rsi+rcx with null (0)
    je done                 ; If null byte found, jump to done
    inc rcx                 ; Otherwise, increment rcx
    jmp find_null           ; Loop until null byte is found

done:
    mov rax, rcx            ; Return length (in rax)
    ret
