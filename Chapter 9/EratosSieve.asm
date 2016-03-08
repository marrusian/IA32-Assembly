TITLE Sieve of Eratosthenes				(EratosSieve.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Implements and tests the Sieve of Eratosthenes.
; Author:		 Marrusian
; Creation Date: 14/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
GetMseconds		PROTO
Crlf			PROTO
WriteDec		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
SIEVE_SIZE = 100
				.DATA?
sieve			BYTE SIEVE_SIZE DUP(?)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				push LENGTHOF sieve
				push OFFSET sieve
				call Sieve_Eratos
				mov ecx,SIEVE_SIZE
				mov edi,OFFSET sieve
				xor ecx,ecx
				add ecx,3
				add edi,3
while01:		cmp ecx,SIEVE_SIZE
				jnle endw01
				test BYTE PTR [edi],1
				jnz skip
				mov eax,ecx
				call WriteDec
				call Crlf
skip:			add ecx,2
				add edi,2					
				jmp while01
endw01:			INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Sieve_Eratos	PROC
;
; Description:	Marks all multiples of primes in a bit vector/map.
; Receives:		pArray:PTR BYTE		=	pointer to bit map
;				sizeArray:DWORD		=	array's length
; Returns:		N/A
; Format:		Sieve_Eratos(ADDR pArray, sizeArray)
; Calls:		N/A
; Symbols:
				sizeArray	EQU DWORD PTR [ebp+12]
				   pArray	EQU	DWORD PTR [ebp+8]
; Locals:
				   square	EQU DWORD PTR [ebp-4]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				enter 4,0
				push edi
				push ecx
				push eax
				push ebx
				push edx
				mov edi,pArray			; Initialize sieve to 0
				push edi
				mov ecx,sizeArray
				push ecx
				xor eax,eax
				rep stosb
				pop ecx
				pop edi			
				mov square,ecx	
				fild square
				fsqrt			
				fisttp square	
				mov ecx,square
				mov ebx,3
				xor edx,edx
while01:		cmp ebx,ecx
				jnle endw01
				push ecx
				mov eax,sizeArray
				div ebx
				xor edx,edx
				mov ecx,eax
				sub ecx,ebx
				inc ecx
				push edi
				mov eax,ebx
				mul ebx	
				add edi,eax
for02:			or BYTE PTR [edi],1
				add edi,ebx
				loop for02
				pop edi
do:				add ebx,2
				test BYTE PTR [edi+ebx],1
				jz enddo
				jmp do
enddo:			pop ecx
				jmp while01
endw01:			pop edx
				pop ebx
				pop eax
				pop ecx
				pop edi
				leave
				ret 8
Sieve_Eratos	ENDP

				END main