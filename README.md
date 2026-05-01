# Hangman - x86-64 Assembly

A classic hangman word-guessing game written in NASM x86-64 assembly for Linux.

## Hangman ASM — Project Progress

- [x] Random word loading from file (`words.txt`)
- [x] Word guessing logic (letter search & display update)
- [x] Display current state (`______` → `_a_a_a` → `banana`)
- [x] Attempt counter with display
- [x] Win/loss conditions
- [x] Modular architecture (`hangman.asm` + `readfile.asm`)

- [ ] Code refactoring & cleanup
- [ ] Start menu (New Game / Exit)
- [ ] Game restart after win/loss
- [ ] ASCII gallows drawing
- [ ] Input validation (letters only, single character)
- [ ] Track already entered letters (no duplicate penalty)

- [ ] Dockerfile for easy distribution
- [ ] Makefile for build automation
- [ ] README.md with project description

## How to play

You have 6 attempts to guess the hidden word, one letter at a time. Each correct guess reveals the letter's position(s) in the word.

## Build

Requires `nasm` and `gcc`:

```sh
nasm -f elf64 hangman.asm -o hangman.o
gcc hangman.o -o hangman -no-pie
```

## Run

```sh
./hangman
```
