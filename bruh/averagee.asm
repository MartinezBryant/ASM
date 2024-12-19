section .data

    name db "Please enter your first and last names: ", 0
    title db "Please enter your title such as Lieutenant, Chef, Mr,Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc: ", 0
    thankyou_msg db "Thank you %s %s ", 10,0

    prompt_miles1 db "Enter the number of miles traveled from Fullerton to Santa Ana: ",0
    prompt_speed1 db "Enter your average speed during that leg of the trip: ",0
    prompt_miles2 db "Enter the number of miles traveled from Santa Ana to Long Beach: ",0
    prompt_speed2 db "Enter your average speed during that leg of the trip: ",0
    prompt_miles3 db "Enter the number of miles traveled from Long Beach to Fullerton: ",0
    prompt_speed3 db "Enter your average speed during that leg of the trip: ",0
    process_msg   db "The inputted data are being processed", 10, 0
    total_distance_msg db "The total distance traveled is %s miles", 10,0
    total_time_msg  db "The time of the trip is %s hours", 10, 0
    average_speed_msg db "The average speed during this trip is s% mph", 10, 0

    stringform db "%s", 0

section .bss
    username resb 40
    newTitle resb 40
    mile1 resb 40
    mile2 resb 40
    mile3 resb 40
    speed1 resb 40
    speed2 resb 40
    speed3 resb 40
    total_distance resq 1
    total_time resq 1
    average_speed resq 1

section .text
    global average
    extern printf, fgets, strlen, stdin, atof 

average:

    push rbp        ; base pointer
    mov rbp, rsp    ; new base pointer
    push rdi        ; Save callee-saved registers 
    push rsi
    push rdx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf 

    ; username calle
    mov rax, 0
    mov rdi, name
    call printf 

    ;username read input
    mov rax, 0
    mov rdi, username
    mov rsi, 39
    mov rdx, [stdin]
    call fgets

    mov rax, 0
    mov rdi, username
    call strlen ; This will get the length of the previos input
    mov [username+rax-1], byte 0 

       ; title - Print prompt for title
    mov rax, 0         
    mov rdi, title
    call printf ; This will print out the prompt for 'title'

    ; title - Read title 
    mov rax, 0
    mov rdi, newTitle
    mov rsi, 39
    mov rdx, [stdin]
    call fgets ; This will read the input from the stdin and store it within 'newTitle'

    ; title - Remove newline after the title response 
    mov rax, 0
    mov rdi, newTitle
    call strlen ; This will get the length of the previos input
    mov [newTitle+rax-1], byte 0

    ;thank you
    mov rax, 0
    mov rdi, thankyou_msg
    mov rsi, newTitle
    mov rdx, username
    call printf

    ;prompt_miles1 response
    mov rax, 0
    mov rdi, prompt_miles1
    call printf

    ;prompt_miles1 read input
    mov rax, 0
    mov rdi, mile1
    mov rsi, 39
    mov rdx, [stdin]
    call fgets

    ;prompt_speed1 print
    mov rax, 0
    mov rdi, prompt_speed1
    call printf 

    ;prompt_speed1 read input
    mov rax, 0
    mov rdi, speed1
    mov rsi, 39
    mov rdx, [stdin]
    call fgets

    ;prompt_miles2 response
    mov rax, 0
    mov rdi, prompt_miles2
    call printf

    ;prompt_miles2 read input
    mov rax, 0
    mov rdi, mile2
    mov rsi, 39
    mov rdx, [stdin]
    call fgets

    ;prompt_speed2 print
    mov rax, 0
    mov rdi, prompt_speed2
    call printf 

    ;prompt_speed2 read input
    mov rax, 0
    mov rdi, speed2
    mov rsi, 39
    mov rdx, [stdin]
    call fgets

    ;prompt_miles3 response
    mov rax, 0
    mov rdi, prompt_miles3
    call printf
    
    ;prompt_miles3 read input
    mov rax, 0
    mov rdi, mile3
    mov rsi, 39
    mov rdx, [stdin]
    call fgets

    ;prompt_speed3 print
    mov rax, 0
    mov rdi, prompt_speed3
    call printf 

    ;prompt_speed3 read input
    mov rax, 0
    mov rdi, speed3
    mov rsi, 39
    mov rdx, [stdin]
    call fgets

    ; Convert miles to float and sum them
    ; Assuming mile1, mile2, mile3 are strings with numeric values
    mov rdi, mile1
    call atof                ; Convert mile1 to float in xmm0
    movq xmm1, xmm0         ; Store in xmm1 (total distance)

    mov rdi, mile2
    call atof
    addpd xmm1, xmm0        ; Add mile2 to total distance

    mov rdi, mile3
    call atof
    addpd xmm1, xmm0        ; Add mile3 to total distance

    ; Store total distance
    movq [total_distance], xmm1

    ; Calculate total time
    ; Initialize total time in xmm2
    xorps xmm2, xmm2        ; Clear xmm2 for total time

    ; Calculate time for each segment
    ; For first segment
    mov rdi, mile1
    call atof                ; Convert mile1 to float in xmm0
    movq xmm3, xmm0         ; Store miles in xmm3

    mov rdi, speed1
    call atof                ; Convert speed1 to float in xmm0
    divpd xmm3, xmm0        ; Time = Distance / Speed
    addpd xmm2, xmm3        ; Add to total time

    ; For second segment
    mov rdi, mile2
    call atof
    movq xmm3, xmm0         ; Store mile2

    mov rdi, speed2
    call atof
    divpd xmm3, xmm0        ; Time = Distance / Speed
    addpd xmm2, xmm3        ; Add to total time

    ; For third segment
    mov rdi, mile3
    call atof
    movq xmm3, xmm0         ; Store mile3

    mov rdi, speed3
    call atof
    divpd xmm3, xmm0        ; Time = Distance / Speed
    addpd xmm2, xmm3        ; Add to total time

    ; Store total time
    movq [total_time], xmm2

    ; Calculate average speed
    movq xmm0, [total_distance]  ; Load total distance
    movq xmm3, [total_time]      ; Load total time
    divpd xmm0, xmm3              ; Average Speed = Total Distance / Total Time
    movq [average_speed], xmm0     ; Store average speed

    ; Print results
    mov rdi, total_distance_msg
    movq xmm0, [total_distance]   ; Load total distance
    call printf

    mov rdi, total_time_msg
    movq xmm0, [total_time]       ; Load total time
    call printf

    mov rdi, average_speed_msg
    movq xmm0, [average_speed]    ; Load average speed
    call printf
    

        ; Restore GPRs
    popf        ; restore flags 
    pop r15     ; restore calle-saved registers
    pop r14 
    pop r13 
    pop r12 
    pop r11 
    pop r10 
    pop r9 
    pop r8 
    pop rdx 
    pop rsi 
    pop rdi 
    mov rax, username; Set the return value to the username buffer

    ; Restore the stack and return
    mov rsp, rbp
    pop rbp
    ret