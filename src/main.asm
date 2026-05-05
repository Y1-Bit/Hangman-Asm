%include "../include/config.inc"

extern  call_test
extern  read_file
global  main

section .text
main:
  push rbp

  call call_test
  call read_file

  mov eax, EXIT_SUCCESS
  pop rbp
  ret

section .note.GNU-stack noalloc noexec nowrite progbits
