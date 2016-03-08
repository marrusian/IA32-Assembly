TITLE Improved Str_copy				(istr_copy.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Improves the 'Str_copy' procedure from the Irvine32/16
;				 library by adding an additional input parameter indicating
;				 the maximum number of characters to be copied.
; Author:		 Marrusian
; Creation Date: 14/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
WriteString		PROTO
IStr_copy		PROTO str1:PTR BYTE, str2:PTR BYTE, nchars:DWORD
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
string1			BYTE "This will be copied.",0
string2			BYTE (LENGTHOF string1) DUP(?)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				INVOKE IStr_copy, ADDR string1, ADDR string2, LENGTHOF string1
				mov edx,OFFSET string2
				call WriteString
				call Crlf
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
IStr_copy		PROC USES esi edi,
				str1:PTR BYTE, str2:PTR BYTE, nchars:DWORD
;
; Description:	Copies a specified number of characters from a string to
;				another.
; Receives:		str1:PTR BYTE	=	pointer to first string
;				str2:PTR BYTE	=	pointer to second string
;				nchars:DWORD	=	number of characters to copy
; Returns:		N/A
; Format:		IStr_copy(ADDR str1, ADDR str2, nchars)
; Preconds:		The output string should be large enough to hold the 
;				specified amount of characters from the input string
;				(including the null-terminating byte).		
; Calls:		N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov esi,str1
				mov edi,str2
				mov ecx,nchars
				cld						; Copy str1 to str2
				rep movsb
				dec edi					
if01:			cmp BYTE PTR [edi],0	; Check the null-byte
				je endif01
				inc edi
				mov BYTE PTR [edi],0
endif01:		ret
IStr_copy		ENDP

				END main