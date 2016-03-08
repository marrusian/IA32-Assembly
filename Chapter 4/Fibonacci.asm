TITLE Fibonacci Numbers		(Fibonacci.asm)	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Iterating algorithm for calculating the n-th Fibonacci number.
; Author:		 Marrusian
; Creation Date: 01/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib E:\masm32\lib\msvcrt.lib
				.listall 
				.386
				.MODEL flat,c
				.STACK 100h		
printf			PROTO arg1:Ptr Byte, printlist:VARARG
scanf			PROTO arg1:Ptr Byte, inputlist:VARARG
Fibonacci		PROTO x:NEAR PTR
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤	
				.DATA
n				BYTE ?		

msg0fmt			BYTE "%s",0
msg1fmt			BYTE "%d",0Ah,0
in0fmt			BYTE "%d",0				

msg0			BYTE "Enter the n-th number in the fibonacci sequence: ",0		
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤		
				.CODE
ClearRegs		MACRO
				xor eax,eax
				sub ebx,ebx
				sub ecx,ecx
				sub edx,edx
				sahf
				ENDM

main			PROC
				ClearRegs
				INVOKE printf, ADDR msg0fmt, ADDR msg0
				INVOKE scanf, ADDR in0fmt, ADDR n
				INVOKE Fibonacci, ADDR n

				ret
main			ENDP
	
Fibonacci		PROC x:NEAR PTR
				push eax
				push ecx
				push esi
				
				mov eax,1
				mov ebx,1
				mov esi,x
				mov ecx,[esi]
				
if01:			cmp ecx,2
				jle endif01		
then01:			sub ecx,2
 for01:			add eax,ebx
				sub ebx,eax
				neg ebx
				loop for01
 endfor01:		nop		
endif01:		nop		
				
				INVOKE printf, ADDR msg1fmt, eax
				
				pop esi
				pop ecx
				pop eax			
				ret
Fibonacci		ENDP
				END MAIN				