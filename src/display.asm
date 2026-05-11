default rel

global print_file_read_error
global print_file_empty_error
global print_success

extern printf

section .rodata
file_read_error_msg:  db "Could not read words file", 10, 0
file_empty_error_msg: db "Words file is empty", 10, 0
success_msg:          db "Success", 10, 0

section .text

print_file_read_error:
  lea rdi, [file_read_error_msg]
  jmp print_message

print_file_empty_error:
  lea rdi, [file_empty_error_msg]
  jmp print_message

print_success:
  lea rdi, [success_msg]
  jmp print_message

print_message:
  push rbp
  mov  rbp, rsp

  xor eax, eax
  call printf wrt ..plt

  mov rsp, rbp
  pop rbp
  ret

section .note.GNU-stack noalloc noexec nowrite progbits
