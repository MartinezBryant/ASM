;Bryant Martinez
;CWID : 886742121

global isnan

segment .text

isnan:              

;=========== Back up all the GPRs  =========================================================

    push    rbp          ; Backup base pointer to maintain the stack frame
    mov     rbp, rsp     ; Set the base pointer to the current stack pointer
                         ; Save callee-saved registers that will be used
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
    pushf                ; Save the flags register


;move our number to a r register
  movsd xmm15, xmm0

; Compare the number against itself to check for NaN
  ucomisd xmm15, xmm15
  jp nan
  mov rax, 1
  jmp exit

nan:
  mov rax, 0   ; Set return value to 0 (indicating NaN)

exit:
; Restore the GPR's
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
    pop rbp   ;Restore rbp to the base of the activation record of the caller program
    ret