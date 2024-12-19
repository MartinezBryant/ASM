section .text
global sum_array

sum_array:
    mov rax, 0               ; Initialize sum to 0
    mov rcx, [num_count]     ; Load count of numbers

sum_loop:
    cmp rcx, 0               ; Check if we've processed all numbers
    je sum_done              ; If count is 0, we're done

    dec rcx                   ; Decrement the counter
    add rax, [array + rcx * 8] ; Add current number to sum
    jmp sum_loop             ; Repeat for the next number

sum_done:
    ret                       ; Return with the sum in RAX
