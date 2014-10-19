all: fib.o
	gcc -o fib fib.o
	
fib.o: fib.asm
	nasm -f elf64 -g -F stabs fib.asm

clean:
	rm fib.o fib
