%macro write_string_macro 1
    mov rsi, %1    ; Load the string address into rsi
    call write_string ; Call write_string procedure
%endmacro
