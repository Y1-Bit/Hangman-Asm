%include "../include/config.inc"

extern  call_test
global  main

section .text
main:
  push rbp

  call call_test

  mov eax, EXIT_SUCCESS
  pop rbp
  ret

section .note.GNU-stack noalloc noexec nowrite progbits
