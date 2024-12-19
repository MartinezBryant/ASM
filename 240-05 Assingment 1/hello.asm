section .data
    ; Strings used for prompts and messages, with the null terminators 
    name db "Please enter your first and last names: ", 0
    title db "Please enter your title (Ms, Mr, Engineer, Programmer, Mathematician, Genius, etc): ", 0
    day db "Hello %s %s. How has your day been so far? ", 0
    niceDay db "%s is really nice." , 10, 0
    salary db "What is your salary in dollars: ", 0
    response_salary db "Oh, $%s is very nice too for a %s.", 10,  0
    final db "This concludes the demonstration of the Hello program written in x86 assembly.", 10, 0



    stringform db "%s", 0 ; Format string for printing single strings

section .bss
    ; Unitialized for storage for the input by the user
    username resb 40     ; Buffer to store the name
    newTitle resb 40     ; Buffer to store the title 
    newDay resb 40       ; Buffer to store the description of the day
    newSalary resb 40    ; Buffer to store the salary

section .text
    global hello
    extern printf, fgets, strlen, stdin

hello:
    ; Save registers
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
    pushf           ; Save flags

    ; username - Print prompt for username
    mov rax, 0         
    mov rdi, name
    call printf ; This will print out the prompt for 'name'

    ; username - Read username
    mov rax, 0
    mov rdi, username
    mov rsi, 39
    mov rdx, [stdin]  
    call fgets ; This will read the input from the stdin and store it with 'username'

    ; username -Remove newline after the username response 
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

    ; day - Print prompt for day
    mov rax, 0         
    mov rdi, day
    mov rsi, newTitle   ; This brings over the 'newTitle'
    mov rdx, username   ; This brings over the 'username'
    call printf ; This will print out the prompt for 'day'

    ; day - Read day input
    mov rax, 0
    mov rdi, newDay
    mov rsi, 39
    mov rdx, [stdin]    
    call fgets  ; This will read the input from the stdin and store it within 'newDay'

    ; Remove newline character from title
    mov rax, 0
    mov rdi, newDay
    call strlen     ; This will get the length of the previos input
    mov [newDay+rax-1], byte 0

    ; day - Remove newline character from day
    mov rax, 0
    mov rdi, niceDay
    mov rsi, newDay
    call printf    ; This will print out the prompt for 'niceDay' and brings over 'newDay'

    ; salary - Print prompt for salary
    mov rax, 0         
    mov rdi, salary
    call printf ; This will print out the prompt for 'salary'

    ; salary - Read salary input
    mov rax, 0
    mov rdi, newSalary
    mov rsi, 39
    mov rdx, [stdin]
    call fgets  ; This will read the input from the stdin and store it within 'newSalary'

    ; salary - Remove newline character from salary
    mov rax, 0
    mov rdi, newSalary
    call strlen ; This will get the length of the previos input
    mov [newSalary+rax-1], byte 0

    ; salary - Print response for salary
    mov rax, 0 
    mov rdi, response_salary
    mov rsi, newSalary
    mov rdx, newTitle
    call printf ; This will print out the prompt for 'response_salary' and bring over the 'newSalary' and 'newTitle' and combine into one print

    ; final - Print final message
    mov rax, 0         
    mov rdi, final
    call printf ; This will print out the prompt for 'final'

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
    mov rax, username ; Set the return value to the username buffer

    ; Restore the stack and return
    mov rsp, rbp
    pop rbp
    ret
