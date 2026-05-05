default rel

extern  fopen
extern  fread
extern  fclose
extern  printf

global  main

section .rodata
path:    db "words.txt", 0
mode:    db "rb", 0
fmt:     db "Read %zu bytes:", 10, "%.*s", 10, 0
err_fmt: db "Could not open file", 10, 0

section .bss
buffer: resb 4096

section .text
main:
  push rbp
  push rbx
  push r12

  lea  rdi, [path]
  lea  rsi, [mode]
  call fopen wrt ..plt

  test rax, rax
  jz   .open_failed

  mov rbx, rax

  lea  rdi, [buffer]
  mov  rsi, 1
  mov  rdx, 4095
  mov  rcx, rbx
  call fread wrt ..plt

  lea rdi, [buffer]
  mov r12, rax
  mov byte [rdi + r12], 0

  lea  rdi, [fmt]
  mov  rsi, r12
  mov  rdx, r12
  lea  rcx, [buffer]
  xor  eax, eax
  call printf wrt ..plt

  mov  rdi, rbx
  call fclose wrt ..plt

  xor eax, eax
  jmp .exit

.open_failed:
  lea  rdi, [err_fmt]
  xor  eax, eax
  call printf wrt ..plt

  mov eax, 1
  jmp .exit

.exit:
  pop r12
  pop rbx
  pop rbp
  ret

section .note.GNU-stack noalloc noexec nowrite progbits
