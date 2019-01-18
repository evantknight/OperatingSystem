/*Designate entry point*/
ENTRY(_start)

/*Designate sections*/
SECTIONS {
	/*Start sections at 1 MiB*/
	. = 1M;

	/*Text data (multiboot goes first)*/
	.text BLOCK(4K) : ALIGN(4K) {
		*(.multiboot)
		*(.text)
	}

	/*Read-only data*/
	.rodata BLOCK(4K) : ALIGN(4K) {
		*(.rodata)
	}

	/*Initialized RW data*/
	.data BLOCK(4K) : ALIGN(4K) {
		*(data)
	}

	/*Unitialized RW data and stack*/
	.bss BLOCK(4K) : ALIGN(4K) {
		*(COMMON)
		*(.bss)
	}

	/*Future sections go here*/

}

