section .data
	; declare global vars here
	vowels db "aeiou", 0

section .text
	global reverse_vowels
	extern strchr

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:
	push ebp
	push esp
	pop ebp

	;; registrii ce trebuie salvati
	push ebx
	push esi
	push edi

	push dword [ebp + 8]
	pop eax ; sirul de caractere

	xor edx, edx

	push dword [eax]
	pop edx
	and edx, 255
	cmp dl, 0
	je end ; daca prima litera e nula, se termina programul

	xor ebx, ebx ; lungime

;; calculeaza lungimea sirului
count:
	inc ebx
	push dword [eax + ebx] ; litera curenta
	pop edx
	and edx, 255 ; transforma in byte
	cmp dl, 0
	jne count


	xor ecx, ecx ; contorul
	dec ebx ; lungimea

	xor edi, edi ; prima litera
	xor esi, esi ; a doua litera

reverse:
	push eax ; salvam sirul

	push dword [eax + ecx]
	pop edi
	and edi, 255 ; transforma in byte prima litera

	push dword [eax + ebx]
	pop esi
	and esi, 255 ; transforma in byte a doua litera

	;; apeleaza strchr
	push ecx
	push edx
	push ecx
	push edi
	push vowels
	call strchr
	add esp, 8
	pop ecx
	pop edx
	pop ecx

	push eax
	pop edi ; rezultatul lui strchr pt prima litera

	;; apeleaza strchr
	push ecx
	push edx
	push ecx
	push esi
	push vowels
	call strchr
	add esp, 8
	pop ecx
	pop edx
	pop ecx

	push eax
	pop esi ; rezultatul lui strchr pt a doua litera

	pop eax ; scoatem sirul

	cmp edi, 0
	jne first_is_vowel
	inc ecx
	jmp first_is_not_vowel

first_is_vowel:
	cmp esi, 0
	jne switch
	dec ebx
	jmp done

first_is_not_vowel:
	cmp esi, 0
	jne done
	dec ebx
	jmp done

switch:
	push dword [eax + ecx]
	pop edi
	and edi, 255 ; transforma in byte prima litera

	push dword [eax + ebx]
	pop esi
	and esi, 255 ; transforma in byte a doua litera

	push edi
	pop edx ; copie a primei litere

	cmp edi, esi
	jg first_is_bigger ; daca prima litera e mai mare lexicografic
	jl add_first

	inc ecx
	dec ebx
	jmp done

;; transforma prima litera in a doua
add_first:
	inc byte [eax + ecx]
	push dword [eax + ecx]
	pop edi
	and edi, 255 ; transforma in byte prima litera
	cmp edi, esi
	jne add_first

;; transforma a doua litera in prima
sub_second:
	dec byte [eax + ebx]
	push dword [eax + ebx]
	pop esi
	and esi, 255 ; transforma in byte a doua litera
	cmp esi, edx
	jne sub_second

	inc ecx
	dec ebx
	jmp done

first_is_bigger:
;; transforma prima litera in a doua
sub_first:
	dec byte [eax + ecx]
	push dword [eax + ecx]
	pop edi
	and edi, 255 ; transforma in byte prima litera
	cmp edi, esi
	jne sub_first

;; transforma a doua litera in prima
add_second:
	inc byte [eax + ebx]
	push dword [eax + ebx]
	pop esi
	and esi, 255 ; transforma in byte a doua litera
	cmp esi, edx
	jne add_second

	inc ecx
	dec ebx
	jmp done

done:
	cmp ecx, ebx
	jl reverse ; daca capetele nu s-au intalnit

end:
	pop edi
	pop esi
	pop ebx

	push ebp
	pop esp
	pop ebp
	ret