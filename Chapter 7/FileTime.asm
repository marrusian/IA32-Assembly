TITLE ShowFileTime					(FileTime.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Receives a binary file time value in the AX register
;				 and displays the time in hh:mm:ss format.
; Author:		 Marrusian
; Creation Date: 09/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h

WriteChar		PROTO
WriteDec		PROTO
Crlf			PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
TimeStamp		BYTE "0001001000000111"
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
WriteColon		MACRO
				mov al,3Ah
				call WriteChar
				ENDM
main			PROC
				mov esi,OFFSET TimeStamp
				mov ecx,LENGTHOF TimeStamp
				call StoreTimeStamp
				call ShowFileTime
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
StoreTimeStamp	PROC USES esi ecx edx
;
; Description:	Takes a time stamp in bit string format and converts it
;				to a binary integer in AX.
; Receives:		ESI = the offset of the time stamp
;				ECX = the length of the time stamp
; Returns:		AX = the binary value of the time stamp
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				clc
L1:				mov dl,[esi]
if01:			test dl,00Fh
				jz else01
				stc
				jmp endif01
else01:			clc
endif01:		rcl ax,1
				inc esi
				loop L1
				ret
StoreTimeStamp	ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
ShowFileTime	PROC USES eax edx
;
; Description:	Receives a bit string in the AX registers where bits
;				0 to 4 represent 2-second increments, 5 to 10 are
;				for the minutes and 11 to 15 indicate the hours.
;				Takes the bit string and displays it in hh:mm:ss format.
; Receives:		AX = the file time value (bit string)
; Returns:		N/A
; Calls:		WriteDec, WriteChar, Crlf						(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov dx,ax
				xor eax,eax
				mov al,dh			; Show hours
				and al,11111000b
				shr al,3
				call WriteDec
				WriteColon
				mov ax,dx
				shr ax,5
				and ax,003Fh
				call WriteDec
				WriteColon
				mov al,dl
				and al,1Fh
				sal al,1
				call WriteDec
				call Crlf
				ret
ShowFileTime	ENDP

				END main