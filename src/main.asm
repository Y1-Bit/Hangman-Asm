%include "../include/config.inc"

extern  read_file
extern  print_file_read_error
extern  print_file_empty_error
extern  print_success
global  main

section .text
main:
  push rbp
  mov  rbp, rsp

  call read_file
  test rax, rax
  js   .file_read_error
  jz   .file_empty_error

  call print_success
  mov eax, EXIT_SUCCESS
  jmp .exit

.file_read_error:
  call print_file_read_error
  mov  eax, EXIT_FAILURE
  jmp  .exit

.file_empty_error:
  call print_file_empty_error
  mov  eax, EXIT_FAILURE
  jmp  .exit

.exit:
  mov rsp, rbp
  pop rbp
  ret

section .note.GNU-stack noalloc noexec nowrite progbits
