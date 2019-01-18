/*Constants*/
.set ALIGN, 	1<<0 		 /*Align loaded modules on page boundaries*/
.set MEMINFO, 	1<<1 		 /*Provide memory map*/
.set FLAGS, 	ALIGN | MEMINFO  /*Multiboot flags*/
.set MAGIC,	0x1BADB002	 /*Magic number for bootloader to find header*/
.set CHECKSUM, 	-(MAGIC + FLAGS)

/*Multiboot Header*/
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/*Stack Definition*/
.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:

/*Entry Point*/
.section .text
.global _start
.type _start, @function
_start:
	/*Set up esp*/
	mov $stack_top, %esp

	/*TODO: Initialize floating point and instruction set extensions*/

	/*TODO: Load GDT*/

	/*TODO: Enable Paging*/

	/*Enter high-level kernel*/
	call kernel_main

	/*Full halt system*/
	cli
1:	hlt
	jmp 1b

/*Set size of _start symbol for debugging purposes*/
.size _start, . - _start

