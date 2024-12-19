section .data
    name db "Please enter your first and last names: ", 0  ; Prompt for user name
    title db "Please enter your title such as Lieutenant, Chef, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc: ", 0  ; Prompt for user title
    thankyou_msg db "Thank you %s %s ", 10, 0  ; Thank you message
    invalid_response db "Invalid data detected. Try again", 0  ; Error message

    prompt_miles1 db "Enter the number of miles traveled from Fullerton to Santa Ana: ", 0  ; Miles (first leg)
    prompt_speed1 db "Enter your average speed during that leg of the trip: ", 0  ; Speed (first leg)
    prompt_miles2 db "Enter the number of miles traveled from Santa Ana to Long Beach: ", 0  ; Miles (second leg)
    prompt_speed2 db "Enter your average speed during that leg of the trip: ", 0  ; Speed (second leg)
    prompt_miles3 db "Enter the number of miles traveled from Long Beach to Fullerton: ", 0  ; Miles (third leg)
    prompt_speed3 db "Enter your average speed during that leg of the trip: ", 0  ; Speed (third leg)
    process_msg db "The inputted data are being processed", 10, 0  ; Processing message
    total_distance_msg db "The total distance traveled is %.2f miles", 10, 0  ; Total distance output
    total_time_msg db "The time of the trip is %.2f hours", 10, 0  ; Total time output
    average_speed_msg db "The average speed during this trip is %.2f mph", 10, 0  ; Average speed output

    stringform db "%s", 0  ; Format string

section .bss
    username resb 40  ; Buffer for username
    newTitle resb 40  ; Buffer for title
    mile1 resb 40  ; Buffer for miles (first leg)
    mile2 resb 40  ; Buffer for miles (second leg)
    mile3 resb 40  ; Buffer for miles (third leg)
    speed1 resb 40  ; Buffer for speed (first leg)
    speed2 resb 40  ; Buffer for speed (second leg)
    speed3 resb 40  ; Buffer for speed (third leg)
    total_distance resq 1  ; Variable for total distance
    total_time resq 1  ; Variable for total time
    average_speed resq 1  ; Variable for average speed

section .text
    global average, isfloat  ; Declare functions as global
    extern printf, fgets, strlen, stdin, atof  ; Import external functions

average:
    push rbp  ; Save the base pointer
    mov rbp, rsp  ; Establish a new base pointer
    push rdi  ; Save callee-saved registers 
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
    pushf  ; Save flags

    ; username call
    mov rax, 0  ;
    mov rdi, name  ; 
    call printf  ; Print the name prompt

    ; username read input
    mov rax, 0  ; 
    mov rdi, username  ; 
    mov rsi, 39  ; Max  length
    mov rdx, [stdin]  ; Input from standard input
    call fgets  ; Read input 

    mov rax, 0  ; 
    mov rdi, username  ; 
    call strlen  ; Get length of the username
    mov [username+rax-1], byte 0  ; Null-terminate the string

    ; title - Print prompt for title
    mov rax, 0  ; 
    mov rdi, title  ; Set prompt for title
    call printf  ; Print title prompt

    ; title - Read title 
    mov rax, 0  ; 
    mov rdi, newTitle  ; 
    mov rsi, 39  ; Max  length
    mov rdx, [stdin]  ; 
    call fgets  ; Read input 

    mov rax, 0  ; 
    mov rdi, newTitle  ; 
    call strlen  ; Get length of the title
    mov [newTitle+rax-1], byte 0  ; Null-terminate the string

    ; thank you
    mov rax, 0  ; Clear rax
    mov rdi, thankyou_msg  ; Set thank you message
    mov rsi, newTitle  ; Title argument
    mov rdx, username  ; Username argument
    call printf  ; Print thank you message

    ; prompt_miles1 response
    mov rax, 0  ; 
    mov rdi, prompt_miles1  ; 
    call printf  ; Print the prompt

    ; prompt_miles1 read input
    mov rax, 0  ; 
    mov rdi, mile1  ; 
    mov rsi, 39  ; Max  length
    mov rdx, [stdin]  ; Input from standard input
    call fgets  ; Read input 

    ; Convert mile1 input to float
    mov rax, [mile1]  ;  mile1 input
    call atof  ; Convert string to float
    movq [mile1], xmm0  ; Store as float

    ; prompt_speed1 print
    mov rax, 0  ; 
    mov rdi, prompt_speed1  ; 
    call printf  ; Print the prompt

    ; prompt_speed1 read input
    mov rax, 0  ; 
    mov rdi, speed1  ; 
    mov rsi, 39  ; Max  length
    mov rdx, [stdin]  ; Input from standard input
    call fgets  ; Read input 

    ; Convert speed1 input to float
    mov rax, [speed1]  ; 
    call atof  ; Convert string to float
    movq [speed1], xmm0  ; Store as float

    ; prompt_miles2 response
    mov rax, 0  ; 
    mov rdi, prompt_miles2  ; 
    call printf  ; Print the prompt

    ; prompt_miles2 read input
    mov rax, 0  ; 
    mov rdi, mile2  ; 
    mov rsi, 39  ; Max input length
    mov rdx, [stdin]  ; Input from standard input
    call fgets  ; Read input 

    ; Convert mile2 input to float
    mov rax, [mile2]  ;  mile2 input
    call atof  ; Convert string to float
    movq [mile2], xmm0  ; Store as float

    ; prompt_speed2 print
    mov rax, 0  ; 
    mov rdi, prompt_speed2  ; 
    call printf  ; Print the prompt

    ; prompt_speed2 read input
    mov rax, 0  ;
    mov rdi, speed2  ; 
    mov rsi, 39  ; Max  length
    mov rdx, [stdin]  ; Input from standard input
    call fgets  ; Read input 

    ; Convert speed2 input to float
    mov rax, [speed2]  ;  speed2 input
    call atof  ; Convert string to float
    movq [speed2], xmm0  ; Store as float

    ; prompt_miles3 response
    mov rax, 0  ;
    mov rdi, prompt_miles3  ; 
    call printf  ; Print the prompt
    
    ; prompt_miles3 read input
    mov rax, 0  ; 
    mov rdi, mile3  ; 
    mov rsi, 39  ; Max input length
    mov rdx, [stdin]  ; Input from standard input
    call fgets  ; Read input 

    ; Convert mile3 input to float
    mov rax, [mile3]  ;  mile3 input
    call atof  ; Convert string to float
    movq [mile3], xmm0  ; Store as float

    ; prompt_speed3 print
    mov rax, 0  ; 
    mov rdi, prompt_speed3  ; 
    call printf  ; Print the prompt

    ; prompt_speed3 read input
    mov rax, 0  ; 
    mov rdi, speed3  ; 
    mov rsi, 39  ; Max length 
    mov rdx, [stdin]  ; Input from standard input
    call fgets  ; Read input 

    ; Convert speed3 input to float
    mov rax, [speed3]  ;  speed3 input
    call atof  ; Convert string to float
    movq [speed3], xmm0  ; Store as float

    ; process_msg print
    mov rax, 0  ; 
    mov rdi, process_msg  ; Set processing message
    call printf  ; Print processing message

    ; Calculate total distance
    movq xmm0, [mile1]  ;  first mile
    addsd xmm0, [mile2]  ; Add second mile
    addsd xmm0, [mile3]  ; Add third mile
    movsd [total_distance], xmm0  ; Store total distance

    ; Calculate total time
    movq xmm1, [mile1]  ;  first mile
    movq xmm2, [speed1]  ;  first speed
    divsd xmm1, xmm2  ; Calculate 

    movq xmm2, [mile2]  ;  second mile
    movq xmm3, [speed2]  ;  second speed
    divsd xmm2, xmm3  ; Calculate 
    addsd xmm1, xmm2  ; Add second leg time

    movq xmm2, [mile3]  ;  third mile
    movq xmm3, [speed3]  ;  third speed
    divsd xmm2, xmm3  ; Calculate 
    addsd xmm1, xmm2  ; Add third leg time
    movsd [total_time], xmm1  ; Store total time

    ; Calculate average speed
    movq xmm0, [total_distance]  ;  total distance
    movq xmm1, [total_time]  ;  total time
    divsd xmm0, xmm1  ; Calculate 
    movsd [average_speed], xmm0  ; Store average speed

    ; Output total distance
    mov rdi, total_distance_msg  ;  message for total distance
    movsd xmm0, [total_distance]  ;  total distance
    call printf  ; Print total distance

    ; Output total time
    mov rdi, total_time_msg  ;  message for total time
    movsd xmm0, [total_time]  ;  total time
    call printf  ; Print total time

    ; Output average speed
    mov rdi, average_speed_msg  ;  message for average speed
    movsd xmm0, [average_speed]  ;  average speed
    call printf  ; Print average speed

    ; Restore GPRs
    popf  ; Restore flags
    pop r15  
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
    mov rax, average_speed  ; Set return value to average_speed buffer

    ; Restore the stack and return
    mov rsp, rbp
    pop rbp
    ret
