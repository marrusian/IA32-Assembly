TITLE Generate Vowel Set Procedure					(_genVowelSet.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
; --- E X T E R N A L S ---
EXTERN			IsVowel@0:PROC
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
GenVowelSet		PROC
;
; Receives:		pSet:PTR BYTE	=	pointer to the array that will hold the set
;				pRow:PTR BYTE	=	points to a matrix row
;				pCol:PTR BYTE	=	points to a matrix column
;				setSize:DWORD  =	the size of the set to be generated
; Returns:		If number of vowels matches, returns the row/col/diagonal
;				Otherwise generates a NULL-set
; Format:		GenVowelSet(ADDR pSet, ADDR pRow, ADDR pCol, setSize)
; Calls:		IsVowel()										(_isVowel.asm)
; Symbols:
				setSize EQU DWORD PTR [ebp + 20]
				pCol	EQU DWORD PTR [ebp + 16]
				pRow	EQU DWORD PTR [ebp + 12]
				pSet	EQU DWORD PTR [ebp + 8]
; Locals:
				flag EQU BYTE PTR [ebp-1]
; Constants:
				NUMBER_OF_VOWELS = 2
				NULL = 0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				enter 4,0
				pushad
				mov edi,pSet
				mov ebx,pRow
				mov esi,pCol
				mov ecx,setSize
				xor edx,edx									; vowel counter
if01:			test esi,esi								; If pCol = 0, traverse by column
				jnz elseif02
				xor esi,esi								; (initialize esi with col-index)
				push ecx								
 for11:			movzx eax,BYTE PTR [ebx+esi*TYPE BYTE]	; While the number of vowels is <= 2
				push eax
				call IsVowel@0
				jnz notVowel1
				inc edx
				cmp edx,NUMBER_OF_VOWELS
				jnle endfor11
  notVowel1:	mov [edi],al							; Generate the set
				inc esi									; (go to next col)
				inc edi								
				loop for11
 endfor11:		mov eax,ecx								; (find how many elements to (eventually) nullify)
				pop ecx
				sub ecx,eax
 if11:			cmp edx,NUMBER_OF_VOWELS				; Otherwise reverse the process and generate a NULL-set
				je endif11
				dec edi
  for21:		mov BYTE PTR [edi],NULL
				dec edi
				loop for21
 endif11:		jmp endif01
elseif02:		test ebx,ebx								; Elseif pRow = 0, traverse by row
				jnz else02
				xor ebx,ebx								; (initialize ebx with row-index)
				push ecx
 for12:			movzx eax,BYTE PTR [esi+ebx]
				push eax
				call IsVowel@0
				jnz notVowel2
				inc edx
				cmp edx,NUMBER_OF_VOWELS
				jnle endfor12
 notVowel2:		mov [edi],al
				inc edi
				add ebx,setSize							; (go to next row)
				loop for12
 endfor12:		mov eax,ecx
				pop ecx
				sub ecx,eax
 if12:			cmp edx,NUMBER_OF_VOWELS
				je endif12
				dec edi
 for22:			mov BYTE PTR [edi],NULL
				dec edi
				loop for22
 endif12:		jmp endif01
else02:			cmp ebx,esi
				je skip
				or flag,1
skip:			xor esi,esi								; Else traverse diagonals
				push ecx
 for13:			movzx eax,BYTE PTR [ebx+esi*TYPE BYTE]
				push eax
				call IsVowel@0
				jnz notVowel3
				inc edx
				cmp edx,NUMBER_OF_VOWELS
				jnle endfor13
 notVowel3:		mov [edi],al
				inc edi
	if111:		test flag,1
				jnz else111
				add ebx,setSize							; (go to next diagonal element)
				inc esi
				jmp endif111
	else111:	add ebx,setSize
				dec esi
	endif111:	loop for13
 endfor13:		mov eax,ecx
				pop ecx
				sub ecx,eax
 if13:			cmp edx, NUMBER_OF_VOWELS
				je endif13
				dec edi
 for23:			mov BYTE PTR [edi],NULL
				dec edi
				loop for23
 endif13:
endif01:		popad
				leave
				ret 16
GenVowelSet		ENDP

				END 																