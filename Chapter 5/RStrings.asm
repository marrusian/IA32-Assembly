TITLE Random Strings				(RStrings.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Generates and displays 20 random strings, each consisting
;				 of 10 capital letters (A to Z).
; Author:		 Marrusian
; Creation Date: 04/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Randomize		PROTO
RandomRange		PROTO
WriteString		PROTO
Crlf			PROTO				
ExitProcess		PROTO dwExitCode:DWORD	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
STRING_SIZE	 = 20
N			 = 10
RANDOM_COUNT = 20

				.DATA?
rdmstr			BYTE STRING_SIZE DUP(?) 
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
; Calls: Randomize, GenerateString, DisplayString
				mov ecx,RANDOM_COUNT
				call Randomize
				mov edi,OFFSET rdmstr
for01:			push ecx
				mov ecx,N
				call GenerateString
				mov edx,OFFSET rdmstr
				call DisplayString
				pop ecx
				loop for01
endfor01:		nop

				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
GenerateString	PROC USES edi ecx eax ebx
;
; Description:	Generates a random null-terminated string consisting of
;				N capital letters(A to Z).
; Receives:		EDI = the offset of the destination string	
;				ECX = the number of capital letters to be generated
; Returns:		N/A
; Calls:		RandomRange										(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov eax,'Z'
				inc eax
				mov ebx,'A'
for01:			push eax
				sub eax,ebx
				call RandomRange
				add eax,ebx
				mov [edi],al
				inc edi
				pop eax
				loop for01
endfor01:		mov [edi],BYTE PTR 0			
				ret
GenerateString	ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
DisplayString	PROC
;
; Description:	Displays a null-terminated string followed by a Crlf.
; Receives:		EDX = the offset of the string
; Returns:		N/A
; Calls:		WriteString, Crlf								(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				call WriteString
				call Crlf
				ret
DisplayString	ENDP
				END main				