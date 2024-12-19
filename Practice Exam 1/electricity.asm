segment .data 
    ; All text entries that will be prompted

    enter_force db "Please enter the electric force in the circuit (volts):", 0, 10
    enter_resistance1 db "Please enter the resistance in circuit number 1 (ohms):", 0
    enter_resistance2 db "Please enter the resistance in circuit number 2 (ohms):", 0,10
    thankyou_msg db "Thank you", 0
    first_current db "The current on the first circuit is %ld amps", 0, 10
    second_current db "The current on the second circuit is %ld amps", 0, 10

segment .bss

    ; stores data

    align       64
    storedata   resb 832

    store_resistance1 resb 40
    store_resistance2 resb 40
    store_electricity resb 99

segment .text

    global electricity
    extern printf
    extern fgets
    extern strlen
    extern stdin
    extern atoi


electricity:

    push       rbp                  ; Backup base pointer
    mov        rbp, rsp             ; Set stack frame pointer

   
    push    rbp                     ;Backup rbp
    mov     rbp,rsp                 ;The base pointer now points to top of stack
    push    rdi                     ;Backup rdi
    push    rsi                     ;Backup rsi
    push    rdx                     ;Backup rdx
    push    rcx                     ;Backup rcx
    push    r8                      ;Backup r8
    push    r9                      ;Backup r9
    push    r10                     ;Backup r10
    push    r11                     ;Backup r11
    push    r12                     ;Backup r12
    push    r13                     ;Backup r13
    push    r14                     ;Backup r14
    push    r15                     ;Backup r15
    push    rbx                     ;Backup rbx
    pushf                           ;Backup rflags


; prompt enter_force msg

    mov     rax, 0
    mov     rdi, enter_force
    call    printf


; clear for new line


    mov     rax, 0
    mov     rdi, enter_force
    call    strlen
    mov     [enter_force-1], byte 0

; print enter_resistance1 msg

    mov     rax, 0 
    mov     rdi, enter_resistance1
    call    printf

    mov     rax, 0
    mov     rdi, store_resistance1
    mov     rsi, 40
    mov     rdx, [stdin]
    call    fgets

; remove newline after response 

    mov     rdi, store_resistance1
    call    strlen
    dec     rax
    mov     byte [store_resistance1+rax], 0

    mov     rdi, store_resistance1
    call    atoi


exit:

    ;Restore all general purpose registers to their original values

    popf                                    ;Restore rflags
    pop rbx                                 ;Restore rbx
    pop r15                                 ;Restore r15
    pop r14                                 ;Restore r14
    pop r13                                 ;Restore r13
    pop r12                                 ;Restore r12
    pop r11                                 ;Restore r11
    pop r10                                 ;Restore r10
    pop r9                                  ;Restore r9
    pop r8                                  ;Restore r8
    pop rcx                                 ;Restore rcx
    pop rdx                                 ;Restore rdx
    pop rsi                                 ;Restore rsi
    pop rdi                                 ;Restore rdi
    pop rbp                                 ;Restore rbp


    mov rsp, rbp
    pop rbp
    ret     
