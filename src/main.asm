%include "../include/config.inc"

extern  call_test
extern  read_file
global  main

section .text
main:
  push rbp
  mov rbp, rsp

  call call_test
  call read_file

  mov eax, EXIT_SUCCESS

  mov rsp, rbp
  pop rbp
  ret

section .note.GNU-stack noalloc noexec nowrite progbits
