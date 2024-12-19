global manager
global variance_value
extern input_array
extern sum
extern variance
extern output_array
extern printf

section .data
    ; Messages for user instructions and outputs
    msg_instruction db "This program will sum your array of integers", 10, "Enter a sequence of long integers separated by white space.", 10, "After the last input press enter followed by Control+D:", 10, 0           
    msg_array_output db "These numbers were received and placed into the array:", 10, 0
    msg_array_sum db "The sum of the %d numbers in this array is %d", 10, 0
    msg_mean db "The Manager Computes The Mean = %d", 10, 0

section .bss
    variance_value resq 1        ; To store the computed variance
    nice_array resq MAX_ARRAY_COUNT
    MAX_ARRAY_COUNT equ 100

section .text

manager:
    ; Backup registers and flags
    push    rbp
    mov     rbp, rsp
    push    rdi
    push    rsi
    push    rdx
    push    rcx
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    push    rbx
    pushf

    ; Display the instruction message
    mov     rax, 0
    mov     rdi, msg_instruction
    call    printf

    mov     rdi, nice_array
    mov     rsi, MAX_ARRAY_COUNT
    call    input_array         ; Returns pointer to array in rdi, length in rsi
    mov     r15, rax            ; Store number of inputs in r15

    mov     rax, 0
    mov     rdi, msg_array_output
    call    printf

    mov     rdi, nice_array
    mov     rsi, r15
    call    sum
    mov     r14, rax            ; Store sum in r14

    mov     rax, 0
    mov     rdi, msg_array_sum
    mov     rsi, r15            ; Number of inputs
    mov     rdx, r14            ; Sum of array
    call    printf

    ; Convert sum (in r14) to floating-point
    mov     rax, r14
    cvtsi2sd    xmm0, rax      ; Convert sum to double (xmm0)

    ; Convert number of inputs (in r15) to floating-point
    mov     rax, r15
    cvtsi2sd    xmm1, rax      ; Convert count to double (xmm1)
    
    ; Calculate mean = sum / number of inputs
    divsd   xmm0, xmm1     ; xmm0 = xmm0 / xmm1 (mean)
    movsd   [variance_value], xmm0 

    mov     rax, 0
    mov     rdi, msg_mean      ; Format for mean output
    call    printf             ; Call printf to display mean

    ; Restore registers and flags
    popf
    pop     rbx
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rcx
    pop     rdx
    pop     rsi
    pop     rdi
    pop     rbp

    ret
