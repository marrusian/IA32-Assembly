TITLE Direct-Offset Addressing		(DOAddress.asm)	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Data transfer instructions using direct-offset operands.	
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
Uarray			WORD 1000h,2000h,3000h,4000h
Sarray			SWORD -1,-2,-3,-4				
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
				movzx eax,Uarray
				movzx ebx,[Uarray+2]
				movzx ecx,[Uarray+4]
				movzx edx,[Uarray+6]
				call DumpRegs
				movsx eax,Sarray
				movsx ebx,[Sarray+2]
				movsx ecx,[Sarray+4]
				movsx edx,[Sarray+6]
				call DumpRegs
				ret
main			ENDP

				END MAIN				