.686
.model flat

public _srednia_harm
public _srednia_arytmetyczna
public _srednia_potegowa_2
public _silnia
public _zapal
public _strcmp
public _hahaha
public _zlicz_falszerstwa
public _odleglosc
public _NWD
public _NWW
public _polacz
public _liczba
public _przesun
public _dodaj
public __mul_24
public _posortuj
public _liczba_pi
public _sortuj
public _wystapienia
public _float_to_FP24
public _parse_fen_element
public _set_bitboards_from_fen
public _zabawa
public _potega
public _wpisz
public _srednia_kwadratowa
public _mul_100
public _power_2
public _valueFunction
public _rootFunction
public _addMatrix
public _determinant_2x2
public _determinant_3x3
public _determinant
public _deletedMatrix

extern _malloc: PROC

.data
jeden dd 1.0

.code

_determinant_recursion PROC
	push ebp
	mov ebp, esp
	sub esp, 4

	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov eax, [ebp + 12]
	mov ebx, [ebp + 8]

	cmp eax, 3
	jne greater
	
	push ebx
	call _determinant_3x3
	add esp, 4
	mov dword PTR[ebp - 4], 0
	add dword PTR[ebp - 4], eax
	
	jmp koniec
greater:
	mov dword PTR[ebp - 4], 0 ; variable for result

	mov ecx, [ebp + 12]
	dec ecx
	mov edi, [ebp + 12]

licz:
	
	mov ebx, [ebp + 8]
	push ecx
	push edi
	push ebx
	call _deletedMatrix
	add esp, 12
	; eax - podmacierz
	dec edi
	push edi
	inc edi
	push eax
	call _determinant_recursion
	add esp, 8
	mov edx, 0
	mov ebx, [ebp + 8]
	lea ebx, [ebx + 4*ecx]
	
	push ecx
	mov ecx, dword PTR[ebx]
	mul ecx
	neg eax
	neg eax
	pop ecx

	bt ecx, 0
	jc nie
	add dword PTR[ebp - 4], eax
	jmp dal
nie:
	sub dword PTR[ebp - 4], eax
dal:
	
	dec ecx
	cmp ecx, 0
	jge licz

koniec:
    mov eax, dword PTR[ebp - 4]

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx

	add esp, 4

	pop ebp
	ret
_determinant_recursion ENDP

_determinant PROC
	push ebp
	mov ebp, esp
	sub esp, 4

	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov eax, [ebp + 12]
	mov ebx, [ebp + 8]

	cmp eax, 2
	jne greater
	
	push ebx
	call _determinant_2x2
	add esp, 4
	
	jmp koniec
greater:
	mov dword PTR[ebp - 4], 0 ; variable for result
	
	mov ebx, [ebp + 8]
	push dword PTR 0
	push dword PTR 4
	push ebx
	call _deletedMatrix
	add esp, 12
	; eax - podmacierz
	push eax
	call _determinant_3x3
	neg eax
	neg eax
	add esp, 4
	mov edx, 0
	mov ebx, [ebp + 8]
	mov ecx, dword PTR[ebx]
	mul ecx
	neg eax
	neg eax
	add dword PTR[ebp - 4], eax

	mov ebx, [ebp + 8]
	push dword PTR 1
	push dword PTR 4
	push ebx
	call _deletedMatrix
	add esp, 12
	; eax - podmacierz
	push eax
	call _determinant_3x3
	neg eax
	neg eax
	add esp, 4
	mov edx, 0
	mov ebx, [ebp + 8]
	mov ecx, dword PTR[ebx + 4]
	mul ecx
	neg eax
	neg eax
	sub dword PTR[ebp - 4], eax

	mov ebx, [ebp + 8]
	push dword PTR 2    
	push dword PTR 4
	push ebx
	call _deletedMatrix
	add esp, 12
	; eax - podmacierz
	push eax
	call _determinant_3x3
	neg eax
	neg eax
	add esp, 4
	mov edx, 0
	mov ebx, [ebp + 8]
	mov ecx, dword PTR[ebx + 8]
	mul ecx
	neg eax
	neg eax
	add dword PTR[ebp - 4], eax

	mov ebx, [ebp + 8]
	push dword PTR 3
	push dword PTR 4
	push ebx
	call _deletedMatrix
	add esp, 12
	; eax - podmacierz
	push eax
	call _determinant_3x3
	add esp, 4
	mov edx, 0
	mov ebx, [ebp + 8]
	mov ecx, dword PTR[ebx + 12]
	mul ecx
	neg eax
	neg eax
	sub dword PTR[ebp - 4], eax

koniec:
    mov eax, dword PTR[ebp - 4]

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx

	add esp, 4

	pop ebp
	ret
_determinant ENDP

_deletedMatrix PROC
	push ebp
	mov ebp, esp

	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov edx, 0
	mov eax, [ebp + 12]
	dec eax
	mov ecx, [ebp + 12]
	mul ecx
	
	mov ecx, eax

	push ecx
	mov ebx, ecx
	shl ebx, 2 ; mno¿ymy razy 4
	push ebx
	call _malloc
	add esp, 4

	pop ecx
	push eax

	mov ebx, 0 ; licznik kolumny
	;eax - nowa macierz o stopieñ mniejszy
	mov esi, [ebp + 12] ; wielkoœæ kolumny
	mov edi, [ebp + 16] ; zakazana kolumna
	mov edx, [ebp + 8] ; pierwotna macierz

	add edx, esi
	add edx, esi
	add edx, esi
	add edx, esi ; przechodzimy do kolejnej kolumny 

wpisuj:

 	cmp ebx, edi
	jne pomin
	add edx, 4 ; pomijamy komórkê macierzy
	inc ebx
	jmp kon

pomin:
	push ecx
	mov ecx, dword PTR[edx]
	mov dword PTR[eax], ecx	
	pop ecx

	add eax, 4
	add edx, 4

	inc ebx
kon:
	cmp ebx, esi
	jb zeruj
	mov ebx, 0
zeruj:

	loop wpisuj

	pop eax

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx

	pop ebp
	ret
_deletedMatrix ENDP

_determinant_3x3 PROC
	push ebp
	mov ebp, esp

	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov dword PTR[ebp - 4], 0 ; wynik
	mov ebx, [ebp + 8]
	
	mov edx, 0
	mov eax, dword PTR[ebx] ; first element
	mov ecx, dword PTR[ebx + 16]
	mul ecx
	mov ecx, dword PTR[ebx + 32]
	mul ecx

	add dword PTR[ebp - 4], eax

	mov edx, 0
	mov eax, dword PTR[ebx + 4] ; first element
	mov ecx, dword PTR[ebx + 20]
	mul ecx
	mov ecx, dword PTR[ebx + 24]
	mul ecx

	add dword PTR[ebp - 4], eax

	mov edx, 0
	mov eax, dword PTR[ebx + 8] ; first element
	mov ecx, dword PTR[ebx + 12]
	mul ecx
	mov ecx, dword PTR[ebx + 28]
	mul ecx

	add dword PTR[ebp - 4], eax

	mov edx, 0
	mov eax, dword PTR[ebx + 24] ; first element
	mov ecx, dword PTR[ebx + 16]
	mul ecx
	mov ecx, dword PTR[ebx + 8]
	mul ecx

	sub dword PTR[ebp - 4], eax

	mov edx, 0
	mov eax, dword PTR[ebx + 28] ; first element
	mov ecx, dword PTR[ebx + 20]
	mul ecx
	mov ecx, dword PTR[ebx]
	mul ecx

	sub dword PTR[ebp - 4], eax

	mov edx, 0
	mov eax, dword PTR[ebx + 32] ; first element
	mov ecx, dword PTR[ebx + 12]
	mul ecx
	mov ecx, dword PTR[ebx + 4]
	mul ecx

	sub dword PTR[ebp - 4], eax

	mov eax, dword PTR[ebp - 4]

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx

	pop ebp
	ret
_determinant_3x3 ENDP

_determinant_2x2 PROC
	push ebp
	mov ebp, esp

	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov dword PTR[ebp - 4], 0 ; wynik
	mov ebx, [ebp + 8]
	
	mov edx, 0
	mov eax, dword PTR[ebx] ; first element
	mov ecx, dword PTR[ebx + 12]
	mul ecx

	add dword PTR[ebp - 4], eax

	mov edx, 0
	mov eax, dword PTR[ebx + 4] ; first element
	mov ecx, dword PTR[ebx + 8]
	mul ecx

	sub dword PTR[ebp - 4], eax

	mov eax, dword PTR[ebp - 4]

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx

	pop ebp
	ret
_determinant_2x2 ENDP

_addMatrix PROC
	push ebp
	mov ebp, esp
	
	;matrixA - [ebp + 8]
	;matrixB - [ebp + 12]
	;xA - [ebp + 16]
	;yA - [ebp + 20]
	;xB - [ebp + 24]
	;yB - [ebp + 28]

	;sprawdzamy czy oba wymiary macierzy s¹ równe
	mov eax, [ebp + 16] ; xA
	mov ebx, [ebp + 24] ; xB
	cmp eax, ebx
	jne errorDimension

	mov eax, [ebp + 20] ; yA
	mov ebx, [ebp + 28] ; yB
	cmp eax, ebx
	jne errorDimension
	
	;obliczamy iloœæ elementów macierzy

	mov edx, 0
	mov eax, [ebp + 16]
	mov ecx, [ebp + 20]
	mul ecx
	mov ecx, eax
	push ecx
	;rezerwujemy pamieæ na wynikow¹ macierz

	mov edx, ecx
	shl edx, 2
	push edx
	call _malloc
	add esp, 4
	
	pop ecx

	push eax ; zapamiêtujemy wskaŸnik na tablicê
	mov ebx, [ebp + 8]
	mov edx, [ebp + 12]

	;dodajemy pokolei wszystkie elementy korzystaj¹c z faktu, ¿e wiersze le¿a jeden po drugim
dodawaj:
	mov dword PTR[eax], 0
	mov esi, dword PTR[ebx]
	add dword PTR[eax], esi
	mov esi, dword PTR[edx]
	add dword PTR[eax], esi

	add eax, 4
	add ebx, 4
	add edx, 4

	loop dodawaj

	pop eax
	jmp endFunction

errorDimension:
	mov eax, 0

endFunction:
	pop ebp
	ret
_addMatrix ENDP

_rootFunction PROC
	push ebp
	mov ebp, esp
	sub esp, 12

	finit

	mov dword PTR [ebp - 4], 0 ; begin
	mov dword PTR [ebp - 8], 3f800000h ; end

petla:
	FLD dword PTR [ebp - 4]
	FLD dword PTR [ebp - 8]
	FADDP
	FLD1
	FLD1
	FADDP
	FDIVP
	FST dword PTR [ebp - 12]
	push dword PTR [ebp - 12]
	call _valueFunction
	add esp, 4

	push dword PTR [ebp - 4] ; begin
	call _valueFunction	
	add esp, 4

	push dword PTR [ebp - 8] ; end
	call _valueFunction	
	add esp, 4
	
	;st(0) - end, st(1) - begin, st(2) - half

	fxch st(2)
	fmulp
	fldz
	fcomi st(0), st(1)
	fstp st(0)
	jb dodatni
ujemny:
	mov eax, dword PTR [ebp - 12] 
	mov dword PTR [ebp - 8], eax
	
	jmp dalej
dodatni:
	mov eax, dword PTR [ebp - 12] 
	mov dword PTR [ebp - 4], eax

dalej:
	fstp st(0)

	mov dword PTR [ebp - 12], 3089705fh
	FST dword PTR [ebp - 12]
	fcomi st(0), st(1)
	fstp st(0)
	;fstp st(0)
	ja petla

	FST dword PTR [ebp - 12]
	
	add esp, 12
	pop ebp
	ret
_rootFunction ENDP

_valueFunction PROC
	push ebp
	mov ebp, esp

	;finit
	mov eax, [ebp + 8]
	push eax
	call _power_10
	add esp, 4

	FLD dword PTR[ebp + 8]
	FSUBP

	mov dword PTR[ebp - 4], 3
	FILD dword PTR[ebp - 4]
	FSUBP

	pop ebp
	ret
_valueFunction ENDP

_power_10 PROC
	push ebp
	mov ebp, esp
	sub esp, 4

	;finit
	FLD dword PTR[ebp + 8]
	FLDL2T
	FMULP
	FSTP dword PTR[ebp - 4]
	call _power_2
	add esp, 4
	
	;add esp, 4
	pop ebp
	ret
_power_10 ENDP

_power_2 PROC
	push ebp
	mov ebp, esp
	
	;finit
	FLD dword PTR[ebp + 8]
	FLD dword PTR[ebp + 8]
	FRNDINT
	FSUBP ; st(0) = czesc u³amowa
	f2xm1
	FLD1
	FADDP

	FLD dword PTR[ebp + 8]
	FRNDINT
	FLD1
	FSCALE

	FXCH
	FSTP st(0)
	FMULP

	pop ebp
	ret
_power_2 ENDP

_mul_100 PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]
	mov ebx, eax
	mov ecx, eax

	shl eax, 6
	shl ebx, 5
	shl ecx, 2
	
	add eax, ebx
	add eax, ecx

	pop ebp
	ret
_mul_100 ENDP

_srednia_kwadratowa PROC
	push ebp
	mov ebp, esp

	FLD dword PTR [ebp + 8]
	FLD dword PTR [ebp + 8]
	FMULP
	FLD dword PTR [ebp + 12]
	FLD dword PTR [ebp + 12]
	FMULP
	FLD dword PTR [ebp + 16]
	FLD dword PTR [ebp + 16]
	FMULP

	FADDP
	FADDP

	FLD1
	FLD1
	FLD1
	FADDP
	FADDP
	FDIVP
	
	FSQRT
	
	pop ebp
	ret
_srednia_kwadratowa ENDP

_wpisz PROC
	push ebp
	mov ebp, esp
	sub esp, 12

	;obliczenie adresu w³aœciwego pola i - x, j - y
	;adres = poczatek + (j * m + i) * 4
	mov esi, [ebp + 8] ;poczatek tablicy
	mov edx, 0
	mov eax, [ebp + 20] ; m
	mov ecx, [ebp + 16] ; j
	mul ecx ; eax = j * m
	mov ecx, [ebp + 12] ; i
	add eax, ecx ; eax = (j * m + 4)
	shl eax, 2 ; eax = (j * m + 4) * 4

	add esi, eax
	mov ecx, [ebp + 24] ; a
	mov dword PTR[esi], ecx

	;[ebp - 4] - na lewo
	;[ebp - 8] - w górê
	;[ebp - 12] - w lewo, górê

	mov edx, esi
	sub edx, 4
	mov ecx, dword PTR [edx]
	mov dword PTR [ebp - 4], ecx

	mov edx, esi
	mov ebx, [ebp + 20] ; m
	shl ebx, 2
	sub edx, ebx
	mov ecx, dword PTR [edx]
	mov dword PTR [ebp - 8], ecx

	mov edx, esi
	mov ebx, [ebp + 20] ; m
	shl ebx, 2
	sub edx, ebx
	sub edx, 4
	mov ecx, dword PTR [edx]
	mov dword PTR [ebp - 12], ecx

	;szukamy min w [ebp - 4], [ebp - 8], [ebp - 12]
	mov eax, dword PTR[ebp - 4]
	mov ecx, dword PTR[ebp - 8]
	cmp eax, ecx
	ja dalej
	mov eax, ecx
dalej:
	mov ecx, dword PTR[ebp - 12]
	cmp eax, ecx
	ja dalej2
	mov eax, ecx
dalej2:
	;inc eax
	mov dword PTR[esi], eax

	;Pola w lewo, góre...
	;inc ecx
	;mov edx, esi
	;sub edx, 4
	;mov dword PTR[edx], ecx

	;inc ecx
	;mov edx, esi
	;add edx, 4
	;mov dword PTR[edx], ecx

	;inc ecx
	;mov edx, esi
	;mov ebx, [ebp + 20]
	;shl ebx, 2
	;sub edx, ebx
	;mov dword PTR[edx], ecx

	;inc ecx
	;mov edx, esi
	;mov ebx, [ebp + 20]
	;shl ebx, 2
	;add edx, ebx
	;mov dword PTR[edx], ecx
	
	add esp, 12
	pop ebp
	ret
_wpisz ENDP

_potega PROC
	push ebp
	mov ebp, esp
	sub esp, 4
	;pusha
	mov esi, [ebp + 8] ; x
	mov edi, [ebp + 12] ; n
	mov dword PTR[ebp - 4], esi	
	finit
	cmp edi, 0
	jne wr
	
	FLD1
	
	jmp koniec
wr:
	BT edi, 0
	jnc zero
jedenP:
	dec edi
	push edi
	push esi
	call _potega
	add esp, 8

	FLD dword PTR[ebp - 4]
	FMULP

	jmp koniec
zero:
	shr edi, 1
	push edi
	push esi
	call _potega
	add esp, 8

	FLDZ
	FADD st(0), st(1)
	FMULP

	jmp koniec
dalej:


koniec:
	;popa

	add esp, 4
	pop ebp
	ret
_potega ENDP

_zabawa PROC
	finit
	;fmul st(0), st(0)
	fsub st(0), st(0)
	fdiv st(0), st(0)
	mov eax, _sortuj
	call eax

_zabawa ENDP

_set_bitboards_from_fen PROC
	push ebp
	mov ebp, esp
	sub esp, 12

	push esi
	push edi

	mov esi, [ebp + 8]
	mov edi, [ebp + 12]

	mov dword PTR[esi], 0
	mov dword PTR[esi + 4], 0
	mov dword PTR[esi + 8], 0
	
	mov dword PTR[ebp - 12], 0 ; - aktualny przetwarzany kolor W:0, B:1

	mov ecx, 32
	;add edi, 3
	inc edi ; pomijamy pierwszy znak (W/B)
	inc edi ; pomijamy drugi znak (:)

przetwarzaj:
	cmp byte PTR[edi], 'W'
	jne d2
	mov dword PTR[ebp - 12], 0
	inc edi
	jmp d5
d2:
	cmp byte PTR[edi], 'B'
	jne d3
	mov dword PTR[ebp - 12], 1
	inc edi
	jmp d5
d3:
	cmp byte PTR[edi], ':'
	jne d4
	inc edi
	jmp przetwarzaj
d4:
	cmp byte PTR[edi], ','
	jne d5
	inc edi
d5:

	mov dword PTR [ebp - 4], 0 ;number
	mov dword PTR [ebp - 8], 0 ;king
	mov eax, ebp
	sub eax, 8
	push eax
	add eax, 4
	push eax
	push edi
	call _parse_fen_element
	add esp, 12
	mov edi, eax

	mov edx, 1
	dec dword PTR [ebp - 4]
	mov eax, ecx
	mov ecx, dword PTR[ebp - 4]
	shl edx, cl
	mov ecx, eax
	
	cmp dword PTR [ebp - 12], 0 ;sprawdzamy kolor gracza
	jne drugi
		or dword PTR[esi], edx
		jmp dalej
	drugi:
		or dword PTR[esi + 4], edx
		jmp dalej
dalej:
	cmp dword PTR [ebp - 8], 1
	jne nie
		or dword PTR [esi + 8], edx
nie:
	dec ecx
	cmp ecx, 0
	jne przetwarzaj

zakoncz:
	pop edi
	pop esi

	pop ebp
	ret
_set_bitboards_from_fen ENDP

_parse_fen_element PROC
	push ebp
	mov ebp, esp
	
	push esi
	push edi
	push ecx

	mov esi, [ebp + 8]; fen
	mov edi, [ebp + 12]; num
	mov edx, [ebp + 16]; king
	mov dword PTR [edx], 0
	cmp byte PTR [esi], 'K'
	je dama
	cmp byte PTR [esi], '0'
	jb blad
	cmp byte PTR [esi], '9'
	ja blad
	jmp liczba
dama:
	mov dword PTR [edx], 1
	inc esi
liczba:
	
	cmp byte PTR[esi + 1], ':'
	jne drugi
	jmp jeden1
drugi:
jeden1:
	cmp byte PTR[esi + 1], ','
	jne dwucyfrowa

jednocyfrowa:
	mov ebx, 0
	mov bl, byte PTR[esi]
	mov dword PTR[edi], ebx
	sub dword PTR[edi], '0'
	jmp koniec

dwucyfrowa:
   	xor ecx, ecx
	mov CH, byte PTR[esi]
	sub CH, '0'
	mov CL, byte PTR[esi]
	sub CL, '0'
	shl CH, 3
	shl CL, 1
	add CH, CL
	inc esi
	mov CL, byte PTR[esi]
	sub CL, '0'
	add CH, CL
	shr ecx, 8
	mov dword PTR[edi], ecx
	jmp koniec

blad:
	mov dword PTR [edi], 1
	neg dword PTR [edi]
	mov dword PTR [edx], 1
	neg dword PTR [edx]
	jmp zakoncz

koniec:
	inc esi
	mov eax, esi

zakoncz:
	pop ecx
	pop edi
	pop esi

	pop ebp
	ret
_parse_fen_element ENDP

_float_to_FP24 PROC
	push ebp
	mov ebp, esp
	;sub ax, ax

	shl ax, 16

	mov eax, [ebp + 8]
	mov ebx, eax
	and ebx, 7F800000h
	shr ebx, 23
	cmp ebx, 0
	je zero
	sub ebx, 127
	add ebx, 63
	shl ebx, 16
zero:
	mov ecx, eax
	and ecx, 80000000h
	shr ecx, 31
	shl ecx, 23
	or ebx, ecx
	
	mov ecx, eax
	and ecx, 8000000h
	shr ecx, 7
	or ebx, ecx
	mov eax, ebx

	pop ebp
	ret
_float_to_FP24 ENDP

_wystapienia PROC
	push ebp
	mov ebp, esp

	mov ecx, 256
	lea ecx, [ecx + ecx*4]
	push ecx
	call _malloc
	add esp, 4
	push eax

	mov ebx, eax
	mov ecx, 256
	mov edx, 0
zeruj:
	mov byte PTR[ebx], DL
	inc ebx
	mov dword PTR[ebx], 0
	add ebx, 4
	inc edx
	loop zeruj

	mov edx, [ebp + 8]
	mov ecx, [ebp + 12]

przegladaj:
	mov ebx, 0
	mov BL, byte PTR[edx]
	lea esi, [ebx + ebx*4]
	lea esi, [eax + esi]
	inc dword PTR[esi + 1]
	inc edx
	loop przegladaj

	pop eax
	pop ebp	
	ret
_wystapienia ENDP

_sortuj PROC
	push ebp
	mov ebp, esp

	push esi
	push edi

	mov esi, [ebp + 8]; adres 1
	mov edi, [ebp + 8]; adres 2
	mov ecx, [ebp + 12]; n
	mov ebx, [ebp + 12]; n

	add esi, 1
	add edi, 1

sortuj1:
	mov edi, [ebp + 8]
	add edi, 1
	mov ecx, [ebp + 12]
sortuj:
	mov eax, dword PTR[esi]
	mov edx, dword PTR[edi]
	cmp eax, edx
	jb dalej
	mov dword PTR[edi], eax
	mov dword PTR[esi], edx
	sub esi, 1
	sub edi, 1
	mov AL, byte PTR[esi]
	mov AH, byte PTR[edi]
	mov byte PTR[esi], AH
	mov byte PTR[edi], AL
	add esi, 1
	add edi, 1
dalej:
	add edi, 5
	
	loop sortuj
	dec ebx
	add esi, 5
	cmp ebx, 0
	jne sortuj1

	pop edi
	pop esi
	pop ebp
	ret
_sortuj ENDP

_liczba_pi PROC
	push ebp
	mov ebp, esp

	mov ecx, [ebp + 8]
	mov dword PTR [ebp - 4], 1 ; mianownik
	mov dword PTR [ebp - 8], 2 ; licznik

	finit
	FLD1
	FLD1
	FADDP

dzialaj:
	BT ecx, 0
	jc druga
	FILD dword PTR [ebp - 8]
	FILD dword PTR [ebp - 4]
	FDIVP
	FMULP
	add dword PTR [ebp - 4], 2
	jmp dalej
druga:
	FILD dword PTR [ebp - 8]
	FILD dword PTR [ebp - 4]
	FDIVP
	FMULP
	add dword PTR [ebp - 8], 2
dalej:
	loop dzialaj
	
	pop ebp
	ret
_liczba_pi ENDP

_posortuj PROC
	push ebp
	mov ebp, esp

	mov ebx, [ebp + 12]; ebx - s
	mov eax, [ebp + 16]; ecx - w
	
	mov edx, 0
	mul ebx
	mov ecx, eax
	mov eax, [ebp + 8]; eax - adres tablicy

wpisuj:
	mov byte PTR[eax], 12
	mov byte PTR[eax + 1], 12
	mov byte PTR[eax + 2], 12
	mov byte PTR[eax + 3], 12
	add eax, 4
	loop wpisuj

	pop ebp
	ret	
_posortuj ENDP

__mul_24 PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]
	mov ecx, [ebp + 12]
	lea edx, [ebp - 40]

	mov ebx, [eax]
	mov dword PTR [edx], ebx
	mov ebx, [eax + 4]
	mov dword PTR [edx], ebx
	mov ebx, [eax + 8]
	mov dword PTR [edx], ebx
	mov ebx, [eax + 12]
	mov dword PTR [edx], ebx

	mov ebx, [eax]
	mov dword PTR [ecx], ebx
	mov ebx, [eax + 4]
	mov dword PTR [ecx], ebx
	mov ebx, [eax + 8]
	mov dword PTR [ecx], ebx
	mov ebx, [eax + 12]
	mov dword PTR [ecx], ebx

	;push 3
	;push eax
	;call _przesun
	;add esp, 8
	
	pop ebp
	ret
__mul_24 ENDP

_dodaj PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]; adres a
	mov ebx, [ebp + 12]; adres b
	
	mov ecx, [ebx]
	add dword PTR[eax], ecx 
	mov ecx, [ebx + 4]
	adc dword PTR[eax + 4], ecx 
	mov ecx, [ebx + 8]
	adc dword PTR[eax + 8], ecx 
	mov ecx, [ebx + 12]
	adc dword PTR[eax + 12], ecx 

	pop ebp
	ret
_dodaj ENDP

_przesun PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8] ;adres liczby
	mov ecx, [ebp + 12] ; n

przesuwaj:
	shl dword PTR [eax], 1
	rcl dword PTR [eax + 4], 1
	rcl dword PTR [eax + 8], 1
	rcl dword PTR [eax + 12], 1
	loop przesuwaj

	pop ebp
	ret
_przesun ENDP

_liczba PROC
	push ebp
	mov ebp, esp
	
	mov eax, 0
	mov ecx, [ebp + 8]
	mov ax, word PTR [ecx]

	mov dword PTR [ebp - 4], eax
	FILD dword PTR [ebp - 4]
	
	mov eax, 4
	push eax
	call _malloc
	add esp, 4	
	FSTP dword PTR [eax]

	mov eax, [eax]

	pop ebp
	ret
_liczba ENDP

_polacz PROC
	push ebp ;ebp + 4
	push edi ;ebp + 8
	push esi ;ebp + 12
	mov ebp, esp
	
	;[ebp + 16] - tab1
	;[ebp + 20] - tab2
	mov eax, [ebp + 24]; - tab3
	;[ebp + 28] - n1
	;[ebp + 32] - n2
	
	mov dword PTR [ebp - 4], 0; i
	mov dword PTR [ebp - 8], 0; j
	
	mov ecx, 0
	mov edx, [ebp + 28]
	add ecx, edx
	mov edx, [ebp + 32]
	add ecx, edx

przetwarzaj:
	jmp pobierz

wczytano:
	mov dword PTR [eax], edx		
	add eax, 4

	loop przetwarzaj
	jmp koniec

pobierz:
	mov ebx, [ebp - 4]
	mov esi, [ebp + 28]
	cmp ebx, esi
	je druga
	mov ebx, [ebp - 8]
	mov esi, [ebp + 32]
	cmp ebx, esi
	jne obie

pierwsza:
	mov edx, [ebp + 16]
	mov edx, [edx]
	mov esi, [ebp + 16]
	add esi, 4
	mov dword PTR[ebp + 16], esi
	mov esi, [ebp - 4]
	inc esi 
	mov dword PTR[ebp - 4], esi
	jmp wczytano

druga:
	mov edx, [ebp + 20]
	mov edx, [edx]
	mov esi, [ebp + 20]
	add esi, 4
	mov dword PTR[ebp + 20], esi
	mov esi, [ebp - 8]
	inc esi 
	mov dword PTR[ebp - 8], esi
	jmp wczytano

obie:
	mov ebx, [ebp + 16]
	mov ebx, [ebx]
	mov esi, [esi]

	cmp ebx, esi
	jb pierwsza
	jmp druga

koniec:
	mov eax, 0
	mov edx, [ebp + 28]
	add eax, edx
	mov edx, [ebp + 32]
	add eax, edx

	pop esi
	pop edi
	pop ebp
	ret
_polacz ENDP

_NWW PROC
	push ebp
	mov ebp, esp
	
	mov eax, [ebp + 8];a
	mov ebx, [ebp + 12];b
	
	push eax
	push ebx

	mov edx, 0
	mul ebx
	mov ebx, eax
	
	call _NWD
	add esp, 8
	mov ecx, eax
	mov eax, ebx
	div ecx 

	pop ebp
	ret
_NWW ENDP

_NWD PROC
	push ebp
	push ebx
	mov ebp, esp
	
	mov eax, [ebp + 12];a
	mov ebx, [ebp + 16];b

przetwarzaj:
	cmp eax, ebx
	ja dalej
	;zamiana miejscami
	mov ecx, eax
	mov eax, ebx
	mov ebx, ecx
dalej:
	cmp ebx, 0
	je koniec
	mov edx, 0
	div ebx
	mov eax, edx
	jmp przetwarzaj

koniec:
	pop ebx
	pop ebp
	ret
_NWD ENDP

_odleglosc PROC
	push ebp
	mov ebp, esp
	
	finit
	lea eax, [ebp + 8]
	FLD dword PTR [eax]
	FLD dword PTR [eax]
	FMULP st(1), st(0)

	lea eax, [ebp + 12]
	FLD dword PTR [eax]
	FLD dword PTR [eax]
	FMULP st(1), st(0)
	FADDP st(1), st(0)

	lea eax, [ebp + 16]
	FLD dword PTR [eax]
	FLD dword PTR [eax]
	FMULP st(1), st(0)
	FADDP st(1), st(0)

	FSQRT
	mov eax, 8
	push eax
	call _malloc
	add esp, 4

	FST qword PTR [eax]

	pop ebp
	ret
_odleglosc ENDP

_zlicz_falszerstwa PROC
	push ebp
	mov ebp, esp

	mov edx, 0
	mov ebx, [ebp + 8] ;wejœcie
	mov ecx, [ebp + 12] ;klucz

przetwarzaj:
	mov CL, byte PTR[ebx]
	cmp CL, 0
	je koniec
	cmp CL, 44
	je obiekt
	inc ebx
	jmp przetwarzaj

obiekt:
	add ebx, 11
	mov eax, 0
	mov AL, byte PTR [ebx]
	inc ebx
	mov ecx, 0
	mov CL, byte PTR [ebx]
	sub eax, 48
	cmp eax, 10
	jb niezmieniaj1
	sub eax, 7

niezmieniaj1:
	sub ecx, 48
	cmp ecx, 10
	jb niezmieniaj2
	sub ecx, 7

niezmieniaj2:
	shl eax, 4
	add eax, ecx
	mov ecx, [ebp + 12] ;klucz
	
	cmp AL, CL
	je przetwarzaj
	inc edx
	jmp przetwarzaj

koniec:
	mov eax, edx

	pop ebp
	ret
_zlicz_falszerstwa ENDP

_hahaha PROC
	push ebp
	mov ebp, esp

	mov al, byte PTR [ebp + 8]
	mov al, byte PTR [ebp + 12]
	mov al, byte PTR [ebp + 16]
	mov al, byte PTR [ebp + 20]

	pop ebp
	ret	
_hahaha ENDP

_strcmp PROC
	push ebp
	mov ebp, esp
	
	mov eax, [ebp + 8] ;string1
	mov ebx, [ebp + 12] ;string2

przetwarzaj:
	mov DL, byte PTR [eax]
	mov DH, byte PTR [ebx]
	cmp DL, DH
	je kolejne

	cmp DL, DH
	ja hehe
	mov eax, 1
	neg eax
	jmp koniec
hehe:
	mov eax, 1
	jmp koniec

kolejne:
	inc eax
	inc ebx
	
	mov DL, byte PTR [eax]
	mov DH, byte PTR [ebx]
	add DL, DH
	cmp DL, 0
	je obie
	
	mov DL, byte PTR [eax]
	mov DH, byte PTR [ebx]
	cmp DL, 0
	jne druga
	mov eax, 1
	neg eax
	jmp koniec

druga:
	cmp DH, 0
	jne przetwarzaj
	mov eax, 1
	jmp koniec

obie:
	mov eax, 0
	jmp koniec

koniec:
	pop ebp
	ret
_strcmp ENDP

_zapal PROC
	push ebp
	mov ebp, esp

	FINIT
	lea ecx, [ebp - 4]
	mov dword PTR [ecx], 100
	lea ebx, [ebp + 8]

	FILD dword PTR [ecx]
	FLD dword PTR [ebx]
	FMUL st(0), st(1)

	FIST dword PTR [ecx]

	mov eax, dword PTR [ecx]

	pop ebp
	ret
_zapal ENDP

_silnia PROC
	push ebp
	mov ebp, esp

	jc koniec
	mov ebx, [ebp + 8]
	
	cmp ebx, 1
	je ostatni
	
	dec ebx
	push ebx
	call _silnia
	add esp, 4
	inc ebx
	mul ebx

	cmp edx, 0
	je koniec
	CLC

	jmp koniec

ostatni:
	mov eax, 1

koniec:
	pop ebp
	ret
_silnia ENDP

_czy_pierwsza PROC
	push ebp
	mov ebp, esp

	mov ecx, eax
	mov ebx, eax
	dec ecx

sprawdzaj:
	
	mov edx, 0
	div ecx
	mov eax, ebx

	cmp edx, 0
	je koniec
	cmp ecx, 2
	je koncz

	loop sprawdzaj

koncz:
	mov eax, 1
	jmp zakoncz

koniec:
	mov eax, 0

zakoncz:
	pop ebp
	ret
_czy_pierwsza ENDP

_wpisz_pierwsze PROC
	push ebp
	mov ebp, esp

	mov eax, [esp + 8] ; tablica
	mov ecx, [esp + 12] ; n (iloœæ liczb pierwszych do wpisania)
	mov edx, 2

powtarzaj:


	push eax
	push ebx
	push ecx
	push edx

	mov eax, 11
	call _czy_pierwsza

	pop edx
	pop ecx
	pop ebx
	pop eax

	loop powtarzaj

	pop ebp
	ret
_wpisz_pierwsze ENDP

_format_float PROC
	push ebp
	mov ebp, esp
	
	lea eax, [esp-4]

	;mov dword PTR [eax], 01111111111111111111111111111111b
	mov dword PTR [eax], 00000000000000000000000000011111b
	finit
	FLD dword PTR [eax]
	FLDPI
	FST dword PTR [eax]
	FLDZ
	FST dword PTR [eax]
	FLD1
	FST dword PTR [eax]

	pop ebp
	ret
_format_float ENDP

_nowy_exp PROC
	finit
	push ebp
	mov ebp, esp
	push ebx

	FLD1
	FLD1
	FLD1
	lea eax, [ebp+8]
	mov ecx, 20
	lea edx, [ebp-4]
	mov dword PTR [edx], 1
	;FLD dword PTR [eax]

przetwarzaj:
	FLD dword PTR [eax]
	FMUL st(1), st(0)
	FXCH
	FST st(1)
	FXCH st(2)
	FILD dword PTR [edx]
	FMULP st(1), st(0)
	inc dword PTR [edx]
	FDIV st(1), st(0)
	FXCH st(3)
	FXCH st(1)
	FADDP st(1), st(0)
	FXCH st(2)
	FXCH st(1)
	;FXCH st(2)
	loop przetwarzaj

	FXCH st(2)

	pop ebx
	pop ebp
	ret
_nowy_exp ENDP  

_srednia_potegowa_2 PROC
	finit
	push ebp
	mov ebp, esp
	push ebx

	lea eax, [ebp+8]
	mov eax, [eax]

	lea ecx, [ebp+12]
	FILD dword PTR [ecx]
	mov ecx, [ecx]

	FLDZ

przetwarzaj:
	FLD dword PTR [eax]
	FLD dword PTR [eax]

	FMULP
	FADDP

	add eax, 4
	loop przetwarzaj
	
	FXCH
	FDIVP
	FSQRT

	pop ebx
	pop ebp
	ret
_srednia_potegowa_2 ENDP

_srednia_arytmetyczna PROC
	finit
	push ebp ; zapisanie zawartoœci EBP na stosie
	mov ebp, esp ; kopiowanie zawartoœci ESP do EBP
	push ebx 

	lea eax, [ebp+8]
	mov eax, [eax]

	lea ecx, [ebp+12]
	FILD dword PTR [ecx]

	mov ecx, [ecx]
	
	FLDZ

przetwarzaj:	
	FLD dword PTR [eax]
	FADDP
	add eax, 4
	loop przetwarzaj

	lea ecx, [ebp+12]
	mov ecx, [ecx]

	FXCH
	FDIVP

	pop ebx
	pop ebp
	ret
_srednia_arytmetyczna ENDP

_srednia_harm PROC
	finit
	push ebp ; zapisanie zawartoœci EBP na stosie
	mov ebp, esp ; kopiowanie zawartoœci ESP do EBP
	push ebx 

	lea eax, [ebp+8]
	mov eax, [eax]

	lea ecx, [ebp+12]
	mov ecx, [ecx]

	FLDZ

przetwarzaj:
	;finit
	FLD dword PTR jeden
	FLD dword PTR [eax]
	FDIVP st(1), st(0)
	FADDP
	;FSTP dword PTR [eax]
	add eax, 4
	loop przetwarzaj

	lea eax, [ebp+12]
	;mov eax, [eax]
	FILD dword PTR [eax] 
	FXCH
	FDIVP st(1), st(0)

	pop ebx
	pop ebp
	ret
_srednia_harm ENDP

END