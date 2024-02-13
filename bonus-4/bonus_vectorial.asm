section .text
	global vectorial_ops

;; void vectorial_ops(int *s, int A[], int B[], int C[], int n, int D[])
;  
;  Compute the result of s * A + B .* C, and store it in D. n is the size of
;  A, B, C and D. n is a multiple of 16. The result of any multiplication will
;  fit in 32 bits. Use MMX, SSE or AVX instructions for this task.

vectorial_ops:
	push		rbp
	mov		rbp, rsp

	; rdi - &s
	; rsi - A
	; rdx - B
	; rcx - C
	; r8  - n
	; r9  - D

	xor		rax, rax
	push		rdi

	; fill the ymm0 register with the value of s
	vpbroadcastd	ymm0, [rsp]

avx_loop:
	;; compute s * A
	;  store 8 values from A into ymm1
	vmovdqu		ymm1, [rsi + 4 * rax]

	;  multiply ymm0 and ymm1 and store the result in ymm2
	;  we store only the lower part of the multiplication
	vpmulld		ymm2, ymm0, ymm1
	
	;; compute B .* C; store the result in ymm5
	vmovdqu		ymm3, [rdx + 4 * rax]
	vmovdqu		ymm4, [rcx + 4 * rax]
	vpmulld		ymm5, ymm3, ymm4

	;; add the partial results in ymm2
	vpaddd		ymm2, ymm2, ymm5

	;; store the result in D
	vmovdqu		[r9 + 4 * rax], ymm2

	add		rax, 8
	cmp		rax, r8
	jl		avx_loop

exit:
	leave
	ret
