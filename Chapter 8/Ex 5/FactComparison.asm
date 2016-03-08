TITLE Factorial Comparison				(FactComparison.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Compares the runtime speeds of both the recursive Factorial
;				 procedure and the nonrecursive Factorial procedure.
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
GetMseconds		PROTO
WriteDec		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
FACTORIAL_NUMBER = 12
REPEAT_COUNT = 0FFFFFFFFh
				.DATA?
factItTime		DWORD ?	
factRecTime		DWORD ?
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				call GetMseconds
				mov factItTime,eax
				mov ecx,REPEAT_COUNT
L1:				push FACTORIAL_NUMBER
				call Factorial
				loop L1
				call GetMseconds
				sub eax, factItTime
				call WriteDec
				call Crlf

				call GetMSeconds
				mov factRecTime,eax
				mov ecx,REPEAT_COUNT
L2:				push FACTORIAL_NUMBER
				call FactorialR
				loop L2
				call GetMseconds
				sub eax,factRecTime
				call WriteDec
				call Crlf

				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Factorial		PROC
;
; Description:	Calculates the factorial of a number.
; Receives:		n:DWORD			(Specifies n!)
; Returns:		EAX = the factorial
; Calls:		N/A
; Symbols:
				n EQU [ebp + 8]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push ebp
				mov ebp,esp
				mov ebx,n
				mov eax,1
while01:		test ebx,ebx
				jz endw01
				mul ebx
				dec ebx
				jmp while01
endw01:	
				pop ebp
				ret 4
Factorial		ENDP

FactorialR		PROC
				push ebp
				mov  ebp,esp
				mov  eax,[ebp+8]	; get n
				cmp  eax,0			; n < 0?
				ja   L1				; yes: continue
				mov  eax,1			; no: return 1
				jmp  L2
L1:				dec  eax
				push eax			; Factorial(n-1)
				call Factorial
			; Instructions from this point on execute when each
			; recursive call returns.
ReturnFact:		mov  ebx,[ebp+8]   	; get n
				mul  ebx          	; ax = ax * bx
L2:				pop  ebp			; return EAX
				ret  4				; clean up stack
FactorialR		ENDP

				END main