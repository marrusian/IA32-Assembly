TITLE Library Test #2		(RNG.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Tests the Crlf, Random32, Randomize, RandomRange, 
;				 WriteChar, WriteDec and WriteInt procedures.
; Author:		 Marrusian
; Creation Date: 01/08/2014 
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤	
Crlf			PROTO		
ExitProcess		PROTO dwExitCode:DWORD
Random32		PROTO
Randomize		PROTO
RandomRange		PROTO
WriteChar		PROTO
WriteDec		PROTO
WriteInt		PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
TAB				= 9h
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
				
main			PROC
				call Randomize
				call Rand1
				call Rand2
				INVOKE ExitProcess,0	
main			ENDP

Rand1			PROC
				mov ecx,10
for01:			call Random32
				call WriteDec
				mov al,TAB
				call WriteChar
				loop for01
endfor01:		call Crlf				
				ret
Rand1			ENDP

Rand2			PROC
				mov ecx,10
for01:			mov eax,100
				call RandomRange
				sub eax,50
				call WriteInt
				mov al,TAB
				call WriteChar	
				loop for01
endfor01:		call Crlf
				ret
Rand2			ENDP							

				END MAIN				
												