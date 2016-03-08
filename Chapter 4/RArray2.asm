TITLE Reverse an Array2		(RArray2.asm)	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Flexible algorithm for reversing an array.
; Author:		 Marrusian
; Creation Date: 01/08/2014
; Revisions:	 1.0
; Date:			 02/08/2014
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib E:\masm32\lib\Irvine32.lib
				.listall 
				.386
				.MODEL flat,stdcall
				.STACK 100h		
Reverse			PROTO
WriteString		PROTO
Crlf			PROTO
DumpMem			PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤	
                ; Symbolic Constants:
                ByteSize = 1
                WordSize = 2
                DwordSize = 4
				
				.DATA				
myBytes			SBYTE 10h,20h,30h,40h,50h
myWords			SWORD 1000h,2000h,3000h,4000h,5000h
myDoubles       SDWORD 10000000h,20000000h,30000000h,40000000h,50000000h	

err0msg			BYTE "Invalid Size Attribute",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤		
				.CODE			
main			PROC
				
				mov esi,OFFSET myBytes
				mov ecx,LENGTHOF myBytes
				mov ebx,TYPE myBytes
				call Reverse
				call DumpMem
				mov esi,OFFSET myWords
				mov ecx,LENGTHOF myWords
				mov ebx,TYPE myWords
				call Reverse
				call DumpMem
				mov esi,OFFSET myDoubles
				mov ecx,LENGTHOF myDoubles
				mov ebx,TYPE myDoubles
				call Reverse
				call DumpMem
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤	
Reverse			PROC USES esi edi eax ebx ecx
;
;	Description: Reverse an array of 8-bit, 16-bit or 32-bit elements.
;	Receives:	 ESI = the array offset
;				 ECX = number of elements in the array
;				 EBX = the size attribute
;	Returns:	 The original array in reversed order.
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤	
if01:			cmp ecx,1
				jle	endif01	
				; Save Registers
				push esi
				push edi
				push eax
				push ecx
				push ebx
				; Initialize EDI and LCV
				mov edi,esi
				mov eax,ecx
				push ecx
				mov cl,bl			; edx = TYPE * LENGTHOF - TYPE = ebx*ecx - ebx = eax - ebx = last array element	
				sar cl,1
				sal eax,cl
				pop ecx
				sub eax,ebx
				add edi,eax
				sar ecx,1			
				; Reverse Array Cases
switch01:		cmp ebx,ByteSize
				je caseB
				cmp ebx,WordSize
				je caseW
				cmp ebx,DwordSize
				je caseD
				jmp default
caseB:			mov al,[esi]
				xchg al,[edi]
				mov [esi],al
				add esi,ebx
				sub edi,ebx
				loop caseB
				jmp endswitch01
caseW:			mov ax,[esi]
				xchg ax,[edi]
				mov [esi],ax
				add esi,ebx 
				sub edi,ebx
				loop caseW
				jmp endswitch01
caseD:			mov eax,[esi]
				xchg eax,[edi]
				mov [esi],eax
				add esi,ebx
				sub edi,ebx
				loop caseD
				jmp endswitch01
default:		mov edx,OFFSET err0msg
				call WriteString				
endswitch01:	nop
				; Restore Registers
				pop ebx
				pop ecx
				pop eax
				pop edi
				pop esi											
endif01:		nop				
				ret
Reverse			ENDP
							
				END MAIN
		