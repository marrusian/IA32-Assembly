TITLE Greatest Common Divisor				(GCD.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Finds the GCD of two integers by using Euclid's Algorithm.
; Author:		 Marrusian
; Creation Date: 09/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
WriteInt		PROTO
WriteDec		PROTO
WriteString		PROTO
Crlf			PROTO
Randomize		PROTO
RandomRange		PROTO
WriteChar		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
REPEAT_COUNT = 25
TAB = 9
UPPER_BOUND = 10000
sEBX			BYTE "EBX: ",0
sEAX			BYTE "EAX: ",0
sGCD			BYTE "GCD: ",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
abs				MACRO x:REQ
				mov edx,x			; eax = abs(eax)
				sar edx,31
				add x,edx
				xor x,edx
				ENDM
main			PROC	
				call Randomize
				mov cx,REPEAT_COUNT
L1:				mov eax,UPPER_BOUND
				call RandomRange
				mov edx,OFFSET sEBX
				call WriteString
				call WriteInt
				mov ebx,eax
				mov al,TAB
				call WriteChar
				mov eax,UPPER_BOUND
				call RandomRange
				mov edx,OFFSET sEAX
				call WriteString
				call WriteInt
				push eax
				mov al,TAB
				call WriteChar
				pop eax
				call GCD
				mov edx,OFFSET sGCD
				call WriteString
				call WriteDec
				call Crlf
				loopw L1			
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
GCD				PROC USES edx ebx
;
; Description:	Finds the GCD of two 32-bit integers using Euclid's Algorithm.
; Receives:		EAX = the first integer
;				EBX = the second integer
; Returns:		EAX = the greatest common divisor
; Calls:		N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				abs eax
				abs ebx
while01:		test ebx,ebx
				jz endw01
				xor edx,edx
				div ebx
				mov eax,ebx
				mov ebx,edx
				jmp while01
endw01:			ret
GCD				ENDP

				END main 