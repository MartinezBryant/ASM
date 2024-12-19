global series                     ; Declare the global label for the series function
extern taylor                     ; Declare the external taylor function
extern printf                     ; Declare the external printf function
extern scanf                      ; Declare the external scanf function

segment .data
get_float db "Please enter a float number value for x: ",0          ; Message to prompt user for a float value
get_terms db "Please enter the number of terms to include in the Taylor sum: ",0 ; Message to prompt user for the number of terms
clock_time db "The time on the clock is now %lu tics and taylor has been called",0 ; Message to display start time
waiting_msg db "Thank you for waiting",0                           ; Message to thank the user for waiting
terminated_msg db "The time on the clock when Taylor terminated was %lu tics",0 ; Message to display end time
execution_time db "The exectution time was %lu tics.",0            ; Message to display execution time
approximation_msg db "The computed approximation of e^x is %f with precision of 8 digits right of the point",0 ; Message to display approximation
debug_msg db "Term %d: %f", 0                                      ; Message for debugging terms
sum_debug_msg db "%f", 10, 0                                       ; Message for debugging running sum
string_format db "%s", 0                                           ; Format specifier for strings
lu db "%lu", 0                                                     ; Format specifier for unsigned long
float_format db "%lf",0                                            ; Format specifier for float
newline db "", 10,0                                                ; Newline character

segment .bss
x   resq 1                                                         ; Reserve space for a float x
term    resd 1                                                     ; Reserve space for an integer term

segment .text

series:
push    rbp                                                        ; Save the base pointer
mov     rbp, rsp                                                   ; Set the base pointer to the current stack pointer
push    rbx                                                        ; Save general-purpose registers
push    rcx
push    rdx
push    rsi
push    rdi
push    r8
push    r9
push    r10
push    r11
push    r12
push    r13
push    r14
push    r15
pushf                                                             ; Save the flags register

;===================================================================================================

; Print get_float message
mov     rax, 0                                                     ; Zero out rax
mov     rdi, string_format                                         ; Load format specifier for string
mov     rsi, get_float                                             ; Load prompt message
call    printf                                                     ; Print the prompt

; Get the float value input from user
mov     rax, 0                                                     ; Zero out rax
mov     rdi, float_format                                          ; Load format specifier for float
push    qword 0                                                    ; Push zero on stack for scanf
push    qword 0
mov     rsi, rsp                                                   ; Set rsi to point to stack
call    scanf                                                      ; Call scanf to read input
movsd   xmm14, [rsp]                                               ; Move input float value to xmm14
pop     rax                                                        ; Clean up stack
pop     rax

; Print get_terms message
mov     rax, 0                                                     ; Zero out rax
mov     rdi, string_format                                         ; Load format specifier for string
mov     rsi, get_terms                                             ; Load prompt message
call    printf                                                     ; Print the prompt

; Get the number of terms input from user
mov     rax, 0                                                     ; Zero out rax
mov     rdi, lu                                                    ; Load format specifier for unsigned long
mov     rsi, rsp                                                   ; Set rsi to point to stack
push    qword 0                                                    ; Push zero on stack for scanf
push    qword 0
mov     rsi, rsp                                                   ; Set rsi to point to stack
call    scanf                                                      ; Call scanf to read input
movsd   xmm13, [rsp]                                               ; Move input value to xmm13
pop     rax                                                        ; Clean up stack
pop     rax

;===================================================================================================

; Record start time
xor     rax, rax                                                   ; Clear rax
xor     rdx, rdx                                                   ; Clear rdx
cpuid                                                             ; Synchronize processor
rdtsc                                                             ; Read time-stamp counter
shl     rdx, 32                                                   ; Shift high-order bits
or      rax, rdx                                                  ; Combine into rax
mov     r15, rax                                                  ; Store start time in r15

; Print new line
mov     rdi, string_format                                         ; Load format specifier for string
mov     rsi, newline                                               ; Load newline character
call    printf                                                     ; Print newline

; Print start time
mov     rdi, clock_time                                            ; Load start time message
mov     rsi, r15                                                   ; Load start time value
mov     rax, 0                                                     ; Clear rax
call    printf                                                     ; Print message with time

; Print new line
mov     rdi, string_format                                         ; Load format specifier for string
mov     rsi, newline                                               ; Load newline character
call    printf                                                     ; Print newline

;===================================================================================================

; Print thank you message
mov     rdi, waiting_msg                                           ; Load thank you message
call    printf                                                     ; Print message

;===================================================================================================

; Call taylor function
movq    xmm0, xmm14                                                ; Move x value to xmm0 (argument 1)
cvttsd2si rdi, xmm13                                               ; Convert n (xmm13) to integer (argument 2)
call    taylor                                                     ; Call the taylor function

movsd   xmm15, xmm0                                                ; Store result in xmm15

; Print approximation message
mov     rax, 1                                                     ; Set rax
mov     rdi, approximation_msg                                     ; Load approximation message
movsd   xmm0, xmm15                                                ; Load result for printing
call    printf                                                     ; Print message with result

;===================================================================================================

; Record end time
xor     rax, rax                                                   ; Clear rax
xor     rdx, rdx                                                   ; Clear rdx
cpuid                                                             ; Synchronize processor
rdtsc                                                             ; Read time-stamp counter
shl     rdx, 32                                                   ; Shift high-order bits
or      rax, rdx                                                  ; Combine into rax
mov     r14, rax                                                  ; Store end time in r14

; Print new line
mov     rdi, string_format                                         ; Load format specifier for string
mov     rsi, newline                                               ; Load newline character
call    printf                                                     ; Print newline

; Print end time
mov     rdi, terminated_msg                                        ; Load end time message
mov     rsi, r14                                                   ; Load end time value
mov     rax, 0                                                     ; Clear rax
call    printf                                                     ; Print message with time

;===================================================================================================

; Compute execution time
sub     r14, r15                                                   ; Subtract start time from end time

; Print new line
mov     rdi, string_format                                         ; Load format specifier for string
mov     rsi, newline                                               ; Load newline character
call    printf                                                     ; Print newline

; Print execution time
mov     rax, 0                                                     ; Clear rax
mov     rdi, execution_time                                        ; Load execution time message
mov     rsi, r14                                                   ; Load execution time value
call    printf                                                     ; Print message with time

; Print new line
mov     rdi, string_format                                         ; Load format specifier for string
mov     rsi, newline                                               ; Load newline character
call    printf                                                     ; Print newline

;===================================================================================================

; Restore registers
popf                                                              ; Restore flags register
pop     r15                                                       ; Restore general-purpose registers
pop     r14
pop     r13
pop     r12
pop     r11
pop     r10
pop     r9
pop     r8
pop     rdi
pop     rsi
pop     rdx
pop     rcx
pop     rbx
pop     rbp                                                       ; Restore base pointer
ret                                                              ; Return from function
