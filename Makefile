#Cross-compiler bin path
BIN="${HOME}/opt/cross/bin

#Target architecture
TARGET=i686-elf

#C compiler
CC=${BIN}/${TARGET}-gcc"

#Assembler
AS=${BIN}/${TARGET}-as"


all: os

os: boot.o kernel.o linker.ld
	${CC} -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

boot.o: boot.s
	${AS} boot.s -o boot.o

kernel.o: kernel.c
	${CC} -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

clean:
	rm ./*.o

