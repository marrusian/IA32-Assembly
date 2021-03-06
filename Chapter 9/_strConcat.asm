TITLE Str_concat Procedure				(_strConcat.asm)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
; Description:	 Implements and tests a procedure which concatenates
;				 two strings.
; Author:		 Marrusian
; Creation Date: 14/08/2014
; Revisions:	 N/A
; Date:			 N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO				
WriteString		PROTO
Str_concat		PROTO str1:PTR BYTE, str2:PTR BYTE
ExitProcess		PROTO dwExitCode:DWORD
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.DATA
targetStr		BYTE "ABCDE",10 DUP(0)
sourceStr		BYTE "FGH",0
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.CODE
main			PROC
				INVOKE Str_concat, ADDR sourceStr, ADDR targetStr
				mov edx,OFFSET targetStr
				call WriteString
				call Crlf
				INVOKE ExitProcess,0
main			ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
Str_concat		PROC USES esi edi eax ecx,
				str1:PTR BYTE, str2:PTR BYTE
;
; Description:	Concatenates a source(input) string to the end of a
;			    target(output) string.
; Receives:		str1:PTR BYTE	=	pointer to the input string
;				str2:PTR BYTE	=	pointer to the output string
; Returns:		N/A
; Format:		Str_concat(ADDR str1, ADDR str2)
; Preconds:		The output string should be large enough to hold
;				the concatenated string.
; Calls:		N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov esi,str1
				mov edi,str2
				mov al,0
				mov ecx,0FFFFFFFFh
				cld
				repne scasb	
				dec edi
while01:		cmp BYTE PTR [esi],0
				lodsb
				stosb		
				je endw01
				jmp while01				
endw01:			ret
Str_concat		ENDP
	
				END main

