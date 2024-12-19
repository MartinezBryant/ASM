; Bryant Martinez
; CWID : 886742121

global normalize_array      ; Declare normalize_array function as global

segment .bss                ; Uninitialized data segment
    align 64

segment .text               ; Code segment

normalize_array:
    ; Backup general-purpose registers (GPRs)
    push rbp                ; Save base pointer
    mov rbp, rsp            ; Set new base pointer
    push rbx                ; Backup registers
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
    pushf                   ; Backup flags



    mov r15, rdi            ; r15 = base address of the array
    mov r14, rsi            ; r14 = number of values to normalize
    mov r13, 0              ; Initialize counter

capacity:
    cmp r13, r14            ; Compare counter with number of values
    jl normalized            ; If counter < number of values, normalize
    jmp exit                ; Otherwise, exit

normalized:
    movsd xmm15, [r15 + r13 * 8] ; Load the value from the array
    push qword 0            ; Push a placeholder onto the stack
    movsd [rsp], xmm15      ; Store the value into the stack
    pop r12                 ; Pop the value back into r12
    shl r12, 12             ; Shift left to prepare for normalization
    shr r12, 12             ; Shift right to clear the unwanted bits
    mov rax, 0x3FF0000000000000 ; Load the exponent for normalization
    or r12, rax             ; Combine the normalized value with the exponent
    
    push r12                ; Push the normalized value onto the stack
    movsd xmm15, [rsp]      ; Load the normalized value into xmm15
    pop r12                 ; Pop it back into r12

    movsd [r15 + r13 * 8], xmm15 ; Store the normalized value back to the array
    inc r13                 ; Increment counter
    jmp capacity      ; Check the next value

exit:

    ; Restore general-purpose registers
    popf                     ; Restore flags
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
    pop rbp                 ; Restore base pointer

    ret                      ; Return from function
