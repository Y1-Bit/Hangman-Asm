section .data
  filename db "words.txt", 0
  total_words db "Words total: %d",10, 0
  random_index db "Random index: %d", 10, 0
  word_index db "Word index position: %d", 10, 0
  random_word db "Random word: %s", 10, 0

section .bss
  buffer resb 1024

section .text
  global main
  extern fgets
  extern stdin
  extern printf
  extern strlen


main:
  push rbp
  push r13
  push r14
  push r15

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

  mov rdi, buffer
  xor eax, eax
  call printf

  xor rcx, rcx
  xor rbx, rbx

  count_loop:
    mov al, [buffer + rcx]
    cmp r13, rcx
    je exit_loop
    cmp al, 10
    jne move_next
    inc rbx
    jmp move_next

  move_next:
    inc rcx
    jmp count_loop

  exit_loop:
    mov rdi, total_words
    mov rsi, rbx
    xor eax, eax
    call printf

    mov rax, 201
    xor rdi, rdi
    syscall

    xor rdx, rdx
    div rbx

    mov r14, rdx

    mov rdi, random_index
    mov rsi, r14
    xor eax, eax
    call printf

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
    mov r15, rcx

    mov rdi, word_index
    mov rsi, r15
    xor eax, eax
    call printf

    mov rdi, random_word
    lea rsi, [buffer + r15]
    xor eax, eax
    call printf

    pop r15
    pop r14
    pop r13
    pop rbp

    xor eax, eax
    ret
