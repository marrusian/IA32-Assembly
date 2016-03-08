TITLE Prime Number						(Prime.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Prompts the user for an integer and checks if it is prime
;				 or not.
; Author:		 Marrusian
; Creation Date: 10/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
ReadInt			PROTO
WriteDec		PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA			
; ------ S T R I N G S ------
promptMsg		BYTE "Enter an integer: ",0
sPrime			BYTE " is prime.",0
sNotPrime		BYTE " is NOT prime.",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
abs				MACRO x:REQ
				mov edx,x
				sar edx,31
				add x,edx
				xor x,edx
				ENDM

main			PROC	
L1:				call PromptInt
				call IsPrime
				jmp L1
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
PromptInt		PROC USES edx
;
; Description:	Prompts the user for an integer.
; Receives:		N/A
; Returns:		EAX = the integer
; Calls:		WriteString, ReadInt							(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET promptMsg
				call WriteString
				call ReadInt
if01:			cmp eax,-1
				jne endif01
				INVOKE ExitProcess,0
endif01:		ret
PromptInt		ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
IsPrime			PROC USES eax edx ebx ecx
				local square:DWORD
;
; Description:	Sets the zero flag if the number in EAX is prime.
; Receives:		EAX = the integer to be tested
; Returns:		N/A
; Calls:		WriteString, WriteDec, Crlf						(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				abs eax
				mov square,eax
				fild square
				fsqrt
				fisttp square
				mov ecx,square
; Check if EAX equals 2 or 3
				cmp eax,2
				jz Prime
				cmp eax,3
				jz Prime
; Check if EAX divides by 2 or 3
if01:			test eax,1
				jnz endif01
				jmp notPrime
endif01:		push eax
				xor edx,edx
				mov ebx,3
				div ebx
				pop eax
if02:			test edx,edx
				jnz endif02
				jmp notPrime
endif02:		mov ebx,5
; Start naive test 
				clc
while01:		pushfd
				cmp ebx,ecx
				jg endw01
				push eax	
				xor edx,edx
				div ebx
				pop eax
if03:			test edx,edx
				jnz endif03
				mov edx,OFFSET sNotPrime
				jmp notPrime
endif03:		popfd
if04:			jnc else04
				add ebx,4
				clc
				jmp endif04
else04:			add ebx,2
				stc
endif04:		jmp while01
endw01:
Prime:			mov edx,OFFSET sPrime
				jmp notPrimeEnd
notPrime:		mov edx,OFFSET sNotPrime			
notPrimeEnd:	call WriteDec
				call WriteString
				call Crlf
				call Crlf
				ret
IsPrime			ENDP
				END main 