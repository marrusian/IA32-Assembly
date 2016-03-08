TITLE Reverse String		(RString.asm)	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Reverse a string using the runtime stack.
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
Crlf			PROTO				
ExitProcess		PROTO dwExitCode:DWORD
WriteString		PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤	
				.DATA			
aName			BYTE "Abraham Lincoln",0	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤		
				.CODE

main			PROC
				mov ecx,LENGTHOF aName-1
				mov esi,OFFSET aName
for01:			movzx eax,BYTE PTR [esi]			; push WORD PTR [esi]
				push eax							; BLANK
				inc esi		
				loop for01
endfor01:		nop
				mov ecx,LENGTHOF aName-1
				mov esi,OFFSET aName		
for02:			pop eax								; pop WORD PTR [esi]
				mov [esi],al						; and WORD PTR [esi],00FFh
				inc esi
				loop for02
endfor02:		nop	
				mov edx,OFFSET aName
				call WriteString	
				call Crlf
				INVOKE ExitProcess,0
main			ENDP

				END MAIN				