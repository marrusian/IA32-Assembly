TITLE Overflow Flag		(OFFlag.asm)	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Various arithmetic operations to set/clear the Overflow Flag.	
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
				; In signed integer arithmetic, the OF is the result of 6-bit's carry XORed with 7-bit's carry.
				mov al,127
				add al,1			; The result exceeds SBYTE upper range, OF set.
				call DumpRegs
				mov al,-128
				sub al,1			; The result exceeds SBYTE lower range, OF set.
				call DumpRegs
				mov al,128
				neg al				; Sets both CF and OF.
				call DumpRegs
				mov al,0FFh
				add al,80h			; Adding two negatives results a positive value and exceeds unsigned
				call DumpRegs		; integer range, CF set, OF set.				
				
				ret
main			ENDP

				END MAIN				