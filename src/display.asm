%include "../include/config.inc"

extern  printf
global  call_test

section .rodata
test_message: db "Hello World!", 10, 0

section .text
call_test:
    push rbp

    mov rsi, rdi
    lea rdi, [rel test_message]
    xor eax, eax
    call printf wrt ..plt

    pop rbp
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
