TITLE Extended Substraction			(ESProc.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Substracts two binary integers of arbitrary size.
;				 The storage size of the two integers must be the same,
;				 and their size must be a multiple of 32 bits.
; Author:		 Marrusian
; Creation Date: 09/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
WriteHexB		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
op1				DWORD 04DC05DCh
op2				DWORD 05DC04DCh
result			BYTE (SIZEOF op1) DUP(?)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				mov esi,OFFSET op1
				mov edi,OFFSET op2
				mov ebx,OFFSET result
				mov ecx,SIZEOF op1
				call Extended_Sub
				mov esi,OFFSET result
				mov ecx,SIZEOF result
				call Display_Sub
				call Crlf
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Extended_Sub	PROC USES esi edi ebx ecx
;
; Description:	Substracts two extended integers stored as arrays of dwords.
; Receives:		ESI = the offset of the first integer
;				EDI = the offset of the second integer
;				EBX = the offset of the variable to hold the result
;				ECX = the number of bytes of the input operands
; Returns:		N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				clc
L1:				mov al,[esi]
				sbb al,[edi]
				mov [ebx],al
				inc esi
				inc edi
				inc ebx
				loop L1
				ret
Extended_Sub	ENDP

Display_Sub		PROC USES esi ebx ecx
				add esi,ecx
				sub esi,TYPE BYTE
				mov ebx,TYPE BYTE	
L1:				mov al,[esi]
				call WriteHexB
				dec esi
				loop L1
				ret
Display_Sub		ENDP
				END main