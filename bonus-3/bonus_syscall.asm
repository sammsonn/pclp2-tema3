section .rodata:
	; taken from fnctl.h
	O_RDONLY	equ 00000
	O_WRONLY	equ 00001
	O_TRUNC		equ 01000
	O_CREAT		equ 00100
	S_IRUSR		equ 00400
	S_IRGRP		equ 00040
	S_IROTH		equ 00004

section .text
	global	replace_marco

;; void replace_marco(const char *in_file_name, const char *out_file_name)
;  it replaces all occurences of the word "Marco" with the word "Polo",
;  using system calls to open, read, write and close files.

replace_marco:
	push	ebp
	mov 	ebp, esp

	leave
	ret