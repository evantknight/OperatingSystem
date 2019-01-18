#Cross-compiler bin path
BIN="${HOME}/opt/cross/bin

#Target architecture
TARGET=i686-elf

#C compiler
CC=${BIN}/${TARGET}-gcc"

#Assembler
AS=${BIN}/${TARGET}-as"


all: myos

myos: boot.o kernel.o linker.ld
	${CC} -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

boot.o: boot.s
	${AS} boot.s -o boot.o

kernel.o: kernel.c
	${CC} -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

install: myos.bin grub.cfg
	mkdir -p isodir/boot/grub
	cp myos.bin isodir/boot/myos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o myos.iso isodir

clean:
	rm -rf isodir/ *.bin *.o *.iso

