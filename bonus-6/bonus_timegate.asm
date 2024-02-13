section .text
	global get_rand

get_rand:
	push	ebp
	mov 	ebp, esp

rdrand_here:
	xor 	eax, eax ; delete me

	leave
	ret
