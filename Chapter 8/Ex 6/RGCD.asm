TITLE Recursive Euclid's Algorithm				(RGCD.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Recursive implementation of Euclid's algorithm.
; Author:		 Marrusian
; Creation Date: 12/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
WriteDec		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				; RGCD (5, 20)
				push 20
				push 5
				call RGCD
				call WriteDec
				call Crlf
				; RGCD (24, 18)
				push 18
				push 24
				call RGCD
				call WriteDec
				call Crlf
				; RGCD (11, 7)
				push 7
				push 11
				call RGCD
				call WriteDec
				call Crlf
				; RGCD (432, 226)
				push 226
				push 432
				call RGCD
				call WriteDec
				call Crlf
				; RGCD (26, 13)
				push 13
				push 26
				call RGCD
				call WriteDec
				call Crlf
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
RGCD			PROC
;	
; Description:	Recursively finds the GCD of two integers using Euclid's Algo.
; Receives:		x:DWORD = the first integer
;				y:DWORD = the second integer
; Format:		RGCD(x,y)
; Returns:		EAX = the GCD
; Calls:		N/A
; Symbols:	
				y EQU DWORD PTR [ebp + 12]
				x EQU DWORD PTR [ebp + 8]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push ebp
				mov ebp,esp
				push edx
				mov eax,x
if01:			test edx,edx
				jz endif01		
ReturnGCD:		xor edx,edx
				div y
				push edx
				push y
				call RGCD
endif01:		pop edx
				pop ebp
				ret 8
RGCD			ENDP

				END main