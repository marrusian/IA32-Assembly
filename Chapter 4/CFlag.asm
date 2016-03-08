TITLE Carry Flag		(CFlag.asm)	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Various arithmetic operations to set/clear the CF.	
; Author:		 Marrusian
; Creation Date: 01/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib E:\masm32\lib\Irvine32.lib			 
				.386
				.MODEL flat,stdcall
				.STACK 100h		
DumpRegs		PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤					
				.DATA				
				
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
				; Adding unsigned integers
				mov al,0FFh
				add al,1			; The result exceeds 2^8-1, CF set
				call DumpRegs
				; Adding signed integers
				mov al,16
				add al,-16			; Adding a negative value LE source value, CF set
				call DumpRegs
				; Substracting unsigned integers
				mov al,01h
				sub al,2			; Substracting a bigger value, CF set
				call DumpRegs
				; Substracting signed integers
				mov al,16
				sub al,-239			; Substracting a negative value LE (2^TYPE-source value), CF set
				call DumpRegs
				; NEG Instruction
				mov al,5
				neg al				; Negating a non-zero value, CF set
				call Dumpregs
						
				ret
main			ENDP

				END MAIN				