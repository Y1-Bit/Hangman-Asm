default rel

extern  fopen
extern  fread
extern  fclose

global  read_file

section .rodata
path:    db "words.txt", 0
mode:    db "rb", 0

section .bss
buffer: resb 4096

section .text
read_file:
  push rbp
  mov rbp, rsp

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

  mov  rdi, rbx
  call fclose wrt ..plt

  mov rax, r12
  jmp .exit

.open_failed:
  mov rax, -1
  jmp .exit

.exit:
  pop r12
  pop rbx

  mov rsp, rbp
  pop rbp
  ret

section .note.GNU-stack noalloc noexec nowrite progbits
