TITLE Generate Random Vowel					(_genRandVowel.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
RandomRange		PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
GenRandVowel	PROC
;
; Description:	Generates a random capital letter vowel.
; Receives:		N/A
; Returns:		EAX = the ASCII hex code value of the character
; Format:		GenRandVowel()
; Calls:		RandomRange										(Irvine32.lib)
; Symbols:
				END_CASE = 5
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov eax,END_CASE		; Range (0-4)
				call RandomRange
switch01:		test eax,eax
				je case_A
				cmp eax,1
				je case_E
				cmp eax,2
				jz case_I
				cmp eax,3
				jz case_O
				jmp case_U	
case_A:			mov eax,'A'
				jmp endswitch01
case_E:			mov eax,'E'
				jmp endswitch01
case_I:			mov eax,'I'
				jmp endswitch01
case_O:			mov eax,'O'
				jmp endswitch01
case_U:			mov eax,'U'
endswitch01:	ret
GenRandVowel	ENDP

				END