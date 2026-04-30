section .data
  curr_state db "Current progress: ", 0, 0
  display db "______", 10, 0
  ask_letter db "Enter a letter: ", 0
  secret_word db "banana", 0
  win_message db "Congratulations! You guessed the word: %s", 10, 0
  lost_message db "Game over! You ran out of attempts", 10, 0
  incorrect_letter db "Wrong guess! Letter not found in the word.", 10, 0
  attempts db 6


section .bss
  letter resb 256

section .text
  global main
  extern fgets
  extern stdin
  extern printf
  extern strlen


main:
  push rbp
  push r12
  push r13
  push r14

  xor rcx, rcx

  mov rdi, secret_word
  call strlen
  mov r14, rax

  general_loop:

    mov rdi, curr_state
    xor eax, eax
    call printf

    mov rdi, display
    xor eax, eax
    call printf

    mov rdi, ask_letter
    xor eax, eax
    call printf

    mov rdi, letter
    mov rsi, 256
    mov rdx, [stdin]
    call fgets

    xor rcx, rcx
    xor r12, r12
    jmp find_letter_loop

find_letter_loop:
  mov al, [secret_word + rcx]
  cmp al, 0
  je check_attempts

compare_letter:
  cmp al, [letter]
  je update_display
  inc rcx
  jmp find_letter_loop

check_attempts:
  cmp r12, 0
  jne check_win
  dec byte [attempts]
  cmp byte [attempts], 0
  je lost
  jne general_loop

check_win:
  cmp r13, r14
  je win
  jne general_loop

update_display:
  mov [display + rcx], al
  inc r12
  inc r13
  jmp next_char

next_char:
  inc rcx
  jmp find_letter_loop

lost:
  mov rdi, lost_message
  xor eax, eax
  call printf
  jmp exit

win:
  mov rdi, win_message
  mov rsi, display
  xor eax, eax
  call printf

  jmp exit

exit:
  pop r14
  pop r13
  pop r12
  pop rbp
  xor eax, eax
  ret
