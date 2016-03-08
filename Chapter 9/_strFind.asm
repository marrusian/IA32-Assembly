TITLE Str_find Procedure				(_strFind.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Implements and tests a string-handling procedure that
;				 searches for the first matching occurrence of a source
;				 string inside a target string.
; Author:		 Marrusian
; Creation Date: 14/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Str_find		PROTO str1:PTR BYTE, str2:PTR BYTE
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
target			BYTE "123ABC342432",0
source			BYTE "ABC",0
pos				DWORD ?
Err				BYTE "NOT FOUND",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				INVOKE Str_find,ADDR source,ADDR target

				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Str_find		PROC USES esi edi,
					 str1:PTR BYTE, str2:PTR BYTE
;
; Description:	Searches for the first matching occurrence of a source string
;				inside a target string and returns the matching	position.
; Receives:		str1:PTR BYTE	=	pointer to the source string
;				str2:PTR BYTE	=	pointer to the target string
; Returns:		Case I - String found:	
;				EAX	= points to the matching position in the target string
;				ZF = 1
;				Case II - String NOT found:
;				EAX = undefined, ZF = 0
; Format:		Str_find(ADDR str1, ADDR str2)
; Calls:		N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov esi,str1
				mov edi,str2
				cmp BYTE PTR [esi],0
				je notFound
				cld
while01:		cmp BYTE PTR [esi],0
				je Found
				cmp BYTE PTR [edi],0
				je notFound
				cmpsb	
				jz endcmp
				mov esi,str1
				mov eax,edi
endcmp:			jmp while01
notFound:		or edi,1
Found:			ret
Str_find		ENDP

				END main