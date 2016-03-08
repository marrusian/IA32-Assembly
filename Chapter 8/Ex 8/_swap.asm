TITLE Swap Procedure				(_swap.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.386
				.MODEL flat,stdcall
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Swap			PROC
;
; Description:  Exchanges the values of two integers.
; Receives:		pValX:PTR DWORD		=	 pointer to first integer
;				pValY:PTR DWORD		=	 pointer to second integer
;				opSize:DWORD		=	 the size of the integers
; Format:		Swap(ADDR x, ADDR y, TYPE x/y)
; Returns:		N/A
; Calls:		N/A
; Symbols:
				opSize EQU DWORD PTR [ebp + 16]
				pValY EQU DWORD PTR [ebp + 12]
				pValX EQU DWORD PTR [ebp + 8]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push ebp
				mov ebp,esp
				push esi
				push edi
				push eax
				mov esi,pValX
				mov edi,pValY
switch01:		cmp opSize,TYPE BYTE
				je case01
				cmp opSize,TYPE WORD
				je case02
				cmp opSize,TYPE DWORD
				jge case03
case01:			mov al,[esi]
				xchg al,[edi]
				mov [esi],al
				jmp endswitch01
case02:			mov ax,[esi]
				xchg ax,[edi]
				mov [esi],ax
				jmp endswitch01
case03:			mov eax,[esi]
				xchg eax,[edi]
				mov [esi],eax
endswitch01:	pop eax
				pop edi
				pop esi
				pop ebp
				ret 12
Swap			ENDP

				END