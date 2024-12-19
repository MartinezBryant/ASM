section .data
    display_msg db 'These numbers were received and placed into the array:', 10, 0
    sum_msg db 'The sum of the %d numbers in this array is %ld.', 10, 0
    sorted_msg db 'This is the sorted array', 10, 0

section .text
global output_array

output_array:
    ; Display the array elements
    lea rdi, [display_msg]
    call printf

    mov rcx, [num_count]     ; Load count of numbers
    mov rbx, 0               ; Initialize index

print_loop:
    cmp rbx, rcx             ; Check if we've printed all numbers
    jge print_done           ; If index >= count, we're done

    ; Print each element in the array
    mov rdi, [array + rbx * 8]
    push rdi                 ; Push number to the stack for printf
    call printf              ; Call printf
    add rsp, 8               ; Clean up the stack
    inc rbx                  ; Increment index
    jmp print_loop           ; Repeat for the next number

print_done:
    ; Print sum message
    lea rdi, [sum_msg]
    mov rsi, [num_count]     ; Number of elements
    mov rdx, rax             ; Total sum from sum_array
    call printf              ; Call printf

    ; Print sorted message
    lea rdi, [sorted_msg]
    call printf              ; Call printf

    ; Print sorted array
    ; (You could add a loop here to print sorted numbers)

    ret                       ; Return to main
