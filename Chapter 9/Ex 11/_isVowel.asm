TITLE IsVowel Procedure							(_isVowel.asm)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
INCLUDELIB E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.DATA
vowelMap		BYTE 0,1,1,1,0,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1
				.CODE
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
IsVowel			PROC
;
; Description:	Determines whether an ASCII character code is a value or not.
; Receives:		char:BYTE	=	the character to be verified
; Returns:		ZF = 1 if char is VOWEL
;				ZF = 0 otherwise
; Format:		IsVowel(char)
; Calls:		N/A
; Symbols:
				char EQU DWORD PTR [ebp + 8]
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				enter 0,0
				push eax
				push esi
				mov eax,char
				sub eax,65
				mov esi,OFFSET vowelMap
				add esi,eax
				test BYTE PTR [esi],1
				pop esi
				pop eax
				leave
				ret 4
IsVowel			ENDP

				END