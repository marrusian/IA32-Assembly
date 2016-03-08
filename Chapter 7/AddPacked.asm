TITLE Add Packed Integers					(AddPacked.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Adds two packed decimal integers of arbitrary size(both
;				 must be the same).
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
WriteHexB		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA			
vDword1			DWORD 35167432h
vDword2			DWORD 93113453h
vQword1			DWORD 45812735h, 75812838h
vQword2			DWORD 95811345h, 57172893h
vDQword1		DWORD 18283846h, 29818239h, 38189122h, 38592215h
VDQword2		DWORD 19193935h, 38384922h, 39591813h, 58528114h
 
				.DATA?
sum1			BYTE (SIZEOF vDword1)+1 DUP(?)
sum2			BYTE (SIZEOF vQword1)+1 DUP(?)
sum3			BYTE (SIZEOF vDQword1)+1 DUP(?)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC	
				mov esi,OFFSET vDword1
				mov edi,OFFSET vDword2
				mov edx,OFFSET sum1
				mov ecx,SIZEOF vDword1
				call AddPacked
				mov esi,OFFSET sum1
				mov ecx,SIZEOF sum1
				mov ebx,TYPE sum1
				call Display_Sum
				; 8-Bytes
				mov esi,OFFSET vQword1
				mov edi,OFFSET vQword2
				mov edx,OFFSET sum2
				mov ecx,SIZEOF vQword1
				call AddPacked
				mov esi,OFFSET sum2
				mov ecx,SIZEOF sum2
				mov ebx,TYPE sum2
				call Display_Sum
				; 16-Bytes
				mov esi,OFFSET vDQword1
				mov edi,OFFSET vDQword2
				mov edx,OFFSET sum3
				mov ecx,SIZEOF vDQword1
				call AddPacked
				mov esi,OFFSET sum3
				mov ecx,SIZEOF sum3
				mov ebx,TYPE sum3
				call Display_Sum
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
AddPacked		PROC USES esi edi edx ecx ax
;
; Description:	See program description.
; Receives:		ESI = the offset of the first integer
;				EDI = the offset of the second integer
;				EDX = the offset of the variable to hold the sum
;				ECX = the number of bytes to add
; Returns:		N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
for01:			mov al,[esi]
				adc al,[edi]
				DAA
				mov [edx],al
				inc esi
				inc edi
				inc edx
				loop for01		
				mov BYTE PTR [edx],0
				adc BYTE PTR [edx],0		
				ret
AddPacked		ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Display_Sum		PROC USES eax esi ecx ebx
;
; Description:	Displays the sum produced by the AddPacked procedure.
; Receives:		ESI = the offset of the sum
;				EBX = the size attribute of the sum
;				ECX = the length of the sum
; Returns:		N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				xor eax,eax
				add esi,ecx
				dec esi
for01:			mov al,[esi]
				call WriteHexB
				dec esi
				loop for01
				call Crlf
				call Crlf
				ret
Display_Sum		ENDP
				END main 