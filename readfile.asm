section .data
  filename db "words.txt", 0

section .bss
  buffer resb 1024

section .text
  global load_random_word

load_random_word:
  push rbp
  push r13
  push r14

  mov rax, 2
  mov rdi, filename
  mov rsi, 0
  mov rdx, 0
  syscall

  mov rdi, rax
  mov rax, 0
  mov rsi, buffer
  mov rdx, 1024
  syscall

  mov r13, rax

  xor rcx, rcx
  xor rbx, rbx

  count_loop:
    mov al, [buffer + rcx]
    cmp r13, rcx
    je exit_loop
    cmp al, 10
    jne move_next
    inc rbx ; word count
    jmp move_next

  move_next:
    inc rcx
    jmp count_loop

  exit_loop:
    mov rax, 201
    xor rdi, rdi
    syscall

    xor rdx, rdx
    div rbx

    mov r14, rdx ; random index

    xor rcx, rcx
    xor rbx, rbx

  get_random_word:
    cmp r14, 0
    je word_found_zero_index
    mov al, [buffer + rcx]
    cmp r13, rcx
    je return
    cmp al, 10
    jne next_word_position
    inc rbx
    cmp rbx, r14
    je word_found
    jne next_word_position

  word_found_zero_index:
    mov rdx, rcx
    jmp move_to_word_end

  word_found:
    inc rcx
    mov rdx, rcx
    jmp move_to_word_end

  move_to_word_end:
    cmp rdx, r13
    je trim
    mov al, [buffer + rdx]
    cmp al, 10
    je trim
    jne increase_word_end_counter

  increase_word_end_counter:
    inc rdx
    jmp move_to_word_end

  trim:
    mov byte [buffer + rdx] , 0
    jmp return

  next_word_position:
    inc rcx
    jmp get_random_word

  return:
    lea rax, [buffer + rcx] ; random word

    pop r14
    pop r13
    pop rbp

    ret
