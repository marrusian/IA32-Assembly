TITLE Copy a String Backwards	(CSB.asm)	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Reverse-copy a string using LOOP and indirect addressing.
; Author:		 Marrusian
; Creation Date: 01/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib E:\masm32\lib\Irvine32.lib
				.listall 
				.386
				.MODEL flat,stdcall
				.STACK 100h		
DumpMem			PROTO				
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤	
				.DATA
source			BYTE "This is the source string",0
target			BYTE SIZEOF source-1 DUP(?),0
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
				mov cl,SIZEOF source-1
				mov esi,OFFSET source+SIZEOF source-2
				mov edi,OFFSET target
for01:			mov al,[esi]
				mov [edi],al
				sub esi,TYPE source
				add edi,TYPE target
				loopw for01
endfor01:		nop
				mov esi,OFFSET target
				mov ebx,TYPE target
				mov ecx,SIZEOF target
				call DumpMem
				ret
main			ENDP
	
				END MAIN				