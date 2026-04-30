# Hangman - x86-64 Assembly

A classic hangman word-guessing game written in NASM x86-64 assembly for Linux.

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
