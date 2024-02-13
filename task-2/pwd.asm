section .data
	back db "..", 0
	curr db ".", 0
	slash db "/", 0
	; declare global vars here
	empty db "", 0

section .text
	global pwd
	extern strcmp
	extern strcat
	extern strcpy

;;	void pwd(char **directories, int n, char *output)
;	Adauga in parametrul output path-ul rezultat din
;	parcurgerea celor n foldere din directories
pwd:
	enter 0, 0

	;; registrii ce trebuie salvati
	push ebx
	push esi
	push edi

	mov eax, [ebp + 8] ; vectorul de foldere
	mov ebx, [ebp + 12] ; nr de foldere
	mov ecx, [ebp + 16] ; output

	xor edi, edi ; contor de foldere
	xor esi, esi ; contor de foldere finale
	imul ebx, 4 ; inmultim cu 4 pentru a fi mai usor de comparat cu contorul

next_folder:
	push esi ; salvam contorul in stiva
	mov edx, [eax + edi] ; cuvantul curent
	
	;; compara cuvantul curent cu "."
	push eax
	push ecx
	push edx
	push curr
	push edx
	call strcmp
	add esp, 8
	pop edx
	pop ecx

	mov esi, eax ; muta rezultatul in esi
	pop eax
	cmp esi, 0
	je stay ; daca e "."

	;; compara cuvantul curent cu ".."
	push eax
	push ecx
	push edx
	push back
	push edx
	call strcmp
	add esp, 8
	pop edx
	pop ecx

	mov esi, eax ; muta rezultatul in esi
	pop eax
	cmp esi, 0
	je go_back ; daca e ".."

	pop esi
	inc esi ; creste numarul de foldere finale
	push edx
	jmp done

stay:
	pop esi ; scoate contorul din stiva
	jmp done

go_back:
	pop esi ; scoate contorul din stiva
	cmp esi, 0
	je done
	dec esi
	pop edx ; scoate ultimul cuvant din stiva

done:
	add edi, 4
	cmp edi, ebx
	jl next_folder

build_directory:
	pop edx ; cuvantul
	
	mov edi, empty ; pune un sir gol in edi

	;; muta / in edi
	push eax
	push ecx
	push edx
	push slash
	push edi
	call strcpy
	add esp, 8
	pop edx
	pop ecx
	pop eax

	;; concateneaza pe edx la edi
	push eax
	push ecx
	push edx
	push edx
	push edi
	call strcat
	add esp, 8
	pop edx
	pop ecx
	pop eax
	
	;; concateneaza pe ecx la edi
	push eax
	push ecx
	push edx
	push ecx
	push edi
	call strcat
	add esp, 8
	pop edx
	pop ecx
	pop eax

	;; copiaza pe edi in ecx
	push eax
	push ecx
	push edx
	push edi
	push ecx
	call strcpy
	add esp, 8
	pop edx
	pop ecx
	pop eax

	dec esi
	cmp esi, 0
	jg build_directory

	;; concateneaza / la output-ul final
	push eax
	push ecx
	push edx
	push slash
	push ecx
	call strcat
	add esp, 8
	pop edx
	pop ecx
	pop eax

end:
	pop edi
	pop esi
	pop ebx

	leave
	ret