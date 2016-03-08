TITLE Sieve of Eratosthenes				(EratosSieve.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Implements and tests the Sieve of Eratosthenes.
; Author:		 Marrusian
; Creation Date: 14/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
GetMseconds		PROTO
Crlf			PROTO
WriteDec		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
							; All primes are odd, therefore
SIEVE_SIZE =	650000		; Convert Set {1,2,...,N} to {1,3,...,2*p+1}
				.DATA
sieve			BYTE SIEVE_SIZE/2 DUP(0)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				push LENGTHOF sieve
				push OFFSET sieve
				call Sieve_Eratos
				mov ecx,SIEVE_SIZE
				mov esi,OFFSET sieve
				mov ecx,1
while01:		sal ecx,1
				inc ecx
				cmp ecx,SIEVE_SIZE
				jnle endw01
				mov al,[esi]
				inc esi
				test al,al
				jnz nP
				mov eax,ecx
				call WriteDec
				call Crlf	
nP:				sar ecx,1
				inc ecx		
				jmp while01
endw01:			
				call WriteDec		
				INVOKE ExitProcess,0
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
				mov edi,pArray			
				mov ecx,sizeArray	
				mov square,ecx	
				fild square
				fsqrt			
				fisttp square	
				mov ecx,square
				inc ecx
				mov ebx,1
while01:		shl ebx,1				; Convert EBX-INDEX 
				inc ebx					; to EBX-PRIME
				cmp ebx,ecx
				jnle endw01
				push ecx
				push edi
				mov eax,ebx
				mul ebx
				shr eax,1
				dec eax
				add edi,eax				; Set EDI to start at the square of the prime number
				mov eax,sizeArray
				div ebx		
				mov edx,ebx
				shr ebx,1
				dec ebx
				sub eax,ebx
				mov ecx,eax				; Set the Internal Loop Counter (number of odd multiples)
MarkCompounds:	or BYTE PTR [edi],1
				add edi,edx
				loop MarkCompounds
				pop edi
				inc ebx
SearchPrime:	test BYTE PTR [edi+ebx],1
				jz EndSearch
				inc ebx
				jmp SearchPrime
EndSearch:		inc ebx
				pop ecx		
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