TITLE Library Test #1		(IOLoop.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Tests the Clrscr, Crlf, DumpMem, ReadInt, SetTextColor,
;				 WaitMsg, WriteBin, WriteHex and WriteString procedures.
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
Clrscr			PROTO		
Crlf			PROTO
DumpMem			PROTO	
ExitProcess		PROTO dwExitCode:DWORD
ReadInt			PROTO	
SetTextColor	PROTO
WriteBin		PROTO
WriteHex		PROTO
WriteInt		PROTO
WaitMsg			PROTO
WriteString		PROTO	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
black			= 0
blue			= 1
lightgray		= 7
				
COUNT			= 4
BlueTextOnGray	= blue + (lightgray SHL 4)
DefaultColor	= lightgray + (black SHL 4)
				
arrayD			SDWORD 12345678h,1A4B2000h,3434h,7AB9h
prompt			BYTE "Enter a 32-bit signed integer: ",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
				
main			PROC
				mov eax,BlueTextOnGray
				call SetTextColor
				call Clrscr
				mov esi,OFFSET arrayD
				mov ebx,TYPE arrayD
				mov ecx,LENGTHOF arrayD
				call DumpMem
				call Crlf
				mov ecx,COUNT
for01:			mov edx,OFFSET prompt
				call WriteString
				call ReadInt
				call Crlf
				call WriteInt
				call Crlf
				call WriteHex
				call Crlf
				call WriteBin
				call Crlf
				call Crlf	
				loop for01	
endfor01:		nop			
				call WaitMsg
				mov eax,DefaultColor
				call SetTextColor
				call Clrscr	
				INVOKE ExitProcess,0	
main			ENDP

				END MAIN				
												