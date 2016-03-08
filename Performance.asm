TITLE Library Test #3		(Performance.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Tests the Crlf, GetMSeconds, WriteDec and WriteString procedures.
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
GetMseconds		PROTO
WriteDec		PROTO
WriteString		PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
OUTER_LOOP_COUNT = 3
SDWORD_MAX		 = 7FFFFFFFh
DWORD_MAX		 = 0FFFFFFFFh

startTime		DWORD ?

msg1			BYTE "Please wait...",0Dh,0Ah,0
msg2			BYTE "Elapsed milliseconds: ",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
				
main			PROC
				mov edx,OFFSET msg1
				call WriteString
				; Save starting time
				call GetMseconds
				mov startTime,eax
				; Start outer loop
				mov ecx,OUTER_LOOP_COUNT
for01:			call innerLoop
				loop for01
endfor01:		nop
				; Calculate elapsed time
				call GetMseconds
				sub eax,startTime
				; Display elapsed time
				mov edx,OFFSET msg2
				call WriteString
				call WriteDec
				call Crlf				
				INVOKE ExitProcess,0	
main			ENDP
					
innerLoop		PROC
				push ecx
				mov ecx,DWORD_MAX
for02:			mul eax
				mul eax
				mul eax
				loop for02
endfor02:		pop ecx			
				ret
innerLoop		ENDP										

				END MAIN				
												