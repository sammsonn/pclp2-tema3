	section .text
	global intertwine
	
	;; void intertwine(int * v1, int n1, int * v2, int n2, int * v);
	;
	; Take the 2 arrays, v1 and v2 with varying lengths, n1 and n2, 
	; and intertwine them
	; The resulting array is stored in v
intertwine:
	push rbp
	mov rbp, rsp
	
	push rdi
	push rsi
	push rdx
	
	mov rax, rdi ; v1
	mov rbx, rsi ; n1
	mov r9, rdx ; v2
	mov r10, rcx ; n2
	mov r11, r8 ; v
	
	xor r12, r12 ; contorul celor doi vectori
	xor r13, r13 ; contorul vectorului de construit
	
intertwine_loop:
	mov edx, dword [rax + r12 * 4] ; ia nr din v1
	mov dword [r11 + r13], edx ; pune nr in v
	add r13, 4
	mov edx, dword [r9 + r12 * 4] ; ia nr din v2
	mov dword [r11 + r13], edx ; pune nr in v2
	add r13, 4
	
	inc r12 
	cmp r12, rbx ; compara contorul cu n1
	je first_done
	cmp r12, r10 ; compara contorul cu n2
	je second_done
	jmp intertwine_loop

;; primul vector a fost parcurs
first_done:
	cmp r12, r10 ; daca si al doilea vector a fost parcurs
	je done
	mov edx, dword [r9 + r12 * 4] ; ia nr din v2
	mov dword [r11 + r13], edx ; pune nr in v2
	add r13, 4
	
	inc r12
	cmp r12, r10 ; compara contorul cu n2
	jl first_done
	
;; al doilea vector a fost parcurs
second_done:
	mov edx, dword [rax + r12 * 4] ; ia nr din v1
	mov dword [r11 + r13], edx ; pune nr in v
	add r13, 4
	
	inc r12
	cmp r12, rbx ; compara contorul cu n1
	jl second_done
	
done:
	pop rdx
	pop rsi
	pop rdi
	
	leave
	ret
