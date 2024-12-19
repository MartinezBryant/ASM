global variance

section .text

variance:
    ; Backup registers
    push    rbx
    push    rdi
    push    rsi

    ; Initialize variance accumulator to 0
    xorps   xmm0, xmm0        ; xmm0 = 0 (variance accumulator)

    ; Loop through the array to calculate (a[i] - mean)^2
    mov     rbx, 0            ; rbx = 0 (index counter)

variance_loop:
    cmp     rbx, rsi          ; Compare index to length of array
    jge     variance_done     ; If index >= length, exit loop

    ; Load array element into xmm2
    movsd   xmm2, [rdi + rbx*8]  ; Load array[rdi + rbx*8] into xmm2

    ; Calculate (a[i] - mean) => xmm2 = xmm2 - xmm1
    subsd   xmm2, xmm1

    ; Square the difference => xmm2 = (a[i] - mean)^2
    mulsd   xmm2, xmm2

    ; Add to variance accumulator => xmm0 += xmm2
    addsd   xmm0, xmm2

    ; Increment index counter
    inc     rbx
    jmp     variance_loop

variance_done:
    ; Divide accumulated variance by length to get the final variance
    cvtsi2sd xmm2, rsi         ; Convert length to double and store in xmm2
    divsd   xmm0, xmm2         ; xmm0 = variance

    ; Return from function (variance value in xmm0)
    pop     rsi
    pop     rdi
    pop     rbx
    ret
