TITLE Reverse an Array		(RArray.asm)	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Flexible algorithm for reversing an array.
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
Reverse			PROTO x:NEAR PTR, y:DWORD, z:DWORD			; x = Array Offset, y = Size Attribute, z = Array Length
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤	
                ; Symbolic Constants:
                ByteSize = 1
                WordSize = 2
                DwordSize = 4
				
				.DATA				
myBytes			SBYTE 10h,20h,30h,40h,50h
myWords			SWORD 1000h,2000h,3000h,4000h,5000h
myDoubles       SDWORD 10000000h,20000000h,30000000h,40000000h,50000000h	

msg0fmt			BYTE "%#x",20h,0
err0fmt			BYTE "%s",0Ah,0

err0msg			BYTE "Invalid Size Attribute",0
linefeed		BYTE 0Ah,0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤		
				.CODE			
main			PROC
				
				INVOKE Reverse, ADDR myBytes, TYPE myBytes, LENGTHOF myBytes
				INVOKE Reverse, ADDR myWords, TYPE myWords, LENGTHOF myWords
				INVOKE Reverse, ADDR myDoubles, TYPE myDoubles, LENGTHOF myDoubles

				ret
main			ENDP

Reverse			PROC x:NEAR PTR, y:DWORD, z:DWORD
if01:			cmp z,1
				jle	endif01	
				; Save Registers
				push esi
				push edi
				push eax
				push ecx
				push ebx
				; Initialize Source PTR, Destination PTR and LCV
				mov esi,x
				mov edi,x
				mov eax,z
				mov cl,BYTE PTR y			; edx = TYPE x * LENGTHOF x - TYPE x = y*z - y = eax - y = last array element	
				sar cl,1
				sal eax,cl
				sub eax,y
				add edi,eax
				mov ecx,z
				sar ecx,1
				; Reverse Array Cases
switch01:		cmp y,ByteSize
				je caseB
				cmp y,WordSize
				je caseW
				cmp y,DwordSize
				je caseD
				jmp default
caseB:			mov al,[esi]
				xchg al,[edi]
				mov [esi],al
				add esi,y 
				sub edi,y
				loop caseB
				jmp endswitch01
caseW:			mov ax,[esi]
				xchg ax,[edi]
				mov [esi],ax
				add esi,y 
				sub edi,y
				loop caseW
				jmp endswitch01
caseD:			mov eax,[esi]
				xchg eax,[edi]
				mov [esi],eax
				add esi,y 
				sub edi,y
				loop caseD
				jmp endswitch01
default:		INVOKE printf, ADDR err0fmt, ADDR err0msg 				
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