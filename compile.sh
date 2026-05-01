nasm -f elf64 readfile.asm -o readfile.o
nasm -f elf64 hangman.asm -o hangman.o
gcc readfile.o hangman.o -o hangman -no-pie


