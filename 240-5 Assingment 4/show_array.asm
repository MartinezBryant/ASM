; Bryant Martinez
; CWID : 886742121

global show_array         ; Declare show_array function as global

extern printf             ; Declare printf for printing

segment .data             ; Initialized data segment
    title db "IEEE754                  Scientific Decimal", 10, 0  ; Title string for output
    output_form db "0x%016lx %18.13e", 10, 0  ; Format for output
    empty_space db "", 10, 0  ; Newline character for formatting

segment .bss              ; Uninitialized data segment
    align 64
segment .text             ; Code segment

show_array:
    ; Backup general-purpose registers (GPRs)
    push rbp               ; Save base pointer
    mov rbp, rsp           ; Set new base pointer
    push rbx               ; Backup registers
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
    pushf                  ; Backup flags

    mov r15, rdi           ; r15 = base address of the array
    mov r14, rsi           ; r14 = number of values to print
    mov r13, 0             ; Initialize counter

    ; Print the title
    mov rdi, title         ; Load title into rdi
    call printf            ; Print title

capacity:
    cmp r13, r14           ; Compare counter with number of values
    jl show_ouput       ; If counter < number of values, output element
    jmp exit               ; Otherwise, exit

show_ouput:
    ; Load the floating-point value from the array
    mov rax, [r15 + r13 * 8]   ; Load IEEE754 float as long


    mov rdi, output_form        ; Load output format string
    mov rsi, rax                ; Set hex value for output
    movsd xmm0, [r15 + r13 * 8] ; Load float for scientific output
    call printf                 ; Print both formats

    inc r13                     ; Increment counter
    jmp capacity          ; Check next value

exit:
    ; Print a newline after all elements
    mov rdi, empty_space
    call printf

    ; Restore general-purpose registers
    popf                        ; Restore flags
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
    pop rbp                    ; Restore base pointer

    ret                         ; Return from function
