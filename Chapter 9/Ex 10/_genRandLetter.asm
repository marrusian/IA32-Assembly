TITLE Generate Random Letter Procedure			(_genRandLetter.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
; --- E X T E R N A L S ---
EXTERN			GenRandVowel@0:PROC
; --- L I B - P R O C E D U R E S ---
RandomRange		PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
GenRandLetter	PROC
;
; Description:	Generates a random capital letter.
;				Has 50% to trigger GenRandVowel.
; Receives:		N/A
; Returns:		EAX = the ASCII hex code value of the character
; Format:		GenRandLetter()
; Calls:		RandomRange										(Irvine32.lib)
; Symbols:
				HUNDRED_PERCENT	= 2
				A_ASCII			= 41h
				Z_ASCII			= 5Ah
				INIT_RAND		= Z_ASCII - A_ASCII + 1
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov eax,HUNDRED_PERCENT		; Range (0-1)
				call RandomRange
if01:			test eax,eax
				jnz else01
				mov eax,INIT_RAND			; Range (0-19)
				call RandomRange
				add eax,A_ASCII				; Add the lowest bound, 'A' character, in hex format
				jmp endif01					; Range is now (65-90) hex.
else01:			call GenRandVowel@0
endif01:		ret							
GenRandLetter	ENDP

				END