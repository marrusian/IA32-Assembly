TITLE Simple Addition (2)					(SA2.asm)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
; Description:	 Locates the cursor near the middle of the screen,
;				 prompts the user for two integers, adds the integers,
;				 and displays their sum.
; Author:		 Marrusian
; Creation Date: 04/08/2014
; Revisions:	 N/A
; Date:			 N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
includelib	D:\masm32\lib\Irvine32.lib		
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
Gotoxy			PROTO
GetMaxXY		PROTO
WriteString		PROTO
ReadInt			PROTO
WriteInt		PROTO
Delay			PROTO
Clrscr			PROTO
ExitProcess		PROTO dwExitCode:DWORD
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.DATA
ARRAY_SIZE = 2
COUNTER_MAIN = 3

promptMsg		BYTE "Enter an integer: ",0
sumMsg			BYTE "The sum of the elements is: ",0

				.DATA?
arrayInt		SDWORD ARRAY_SIZE DUP(?)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.CODE
main			PROC
; Calls: PromptForInts, ArraySum, DisplaySum, Clrscr, CentrateCursor
				mov ecx,COUNTER_MAIN
for01:			push ecx
				call Clrscr
				call CentrateCursor
				mov edi,OFFSET arrayInt
				mov ecx,LENGTHOF arrayInt
				call PromptForInts
				mov esi,OFFSET arrayInt
				mov ecx,LENGTHOF arrayInt
				call ArraySum
				call DisplaySum
				mov eax,1000
				call Delay
				pop ecx
				loop for01
endfor01:		nop
				INVOKE ExitProcess,0
main			ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
CentrateCursor	PROC USES dx ax
;
; Description:	Gets the size of the console window's buffer and then
;				centrates the cursor near the middle of the console.
; Receives:		N/A
; Returns:		N/A
; Calls:		GetMaxXY, Gotoxy								(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				call GetMaxXY
				sar dl,2			; DX = number of buffer columns
				sar al,1			; AX = number of buffer rows			
				or dh,al			; set DH to AL, DH = Y-coordinate(row)	
				call Gotoxy
				ret
CentrateCursor	ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
PromptForInts	PROC USES edx ecx edi
;
; Description:	Prompts the user for a specified number of 32-bit integers
;				and inserts them in an array.
; Receives:		ECX = number of integers to be entered
;				EDI = the offset of the array
; Returns:		N/A
; Calls:		WriteString, ReadInt							(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov edx,OFFSET promptMsg
for01:			call WriteString
				call ReadInt
				mov [edi],eax
				add edi,TYPE DWORD
				loop for01
endfor01:		nop
				ret
PromptForInts	ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
ArraySum		PROC USES esi ecx
;
; Description: Adds the elements of an array of 32-bit integers.
; Receives:	   ESI = the offset of the array
;			   ECX = number of integers to be added
; Returns:	   EAX = the sum
; Calls:	   N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov eax,0
for01:			add eax,[esi]
				add esi,TYPE DWORD
				loop for01
endfor01:		nop
				ret
ArraySum		ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
DisplaySum		PROC USES edx
;
; Description:	Displays the sum calculated by ArraySum.
; Receives:		EAX = the sum
; Returns:		N/A
; Calls:		WriteString, WriteInt, Crlf						(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov edx,OFFSET sumMsg
				call WriteString
				call WriteInt
				call Crlf
				ret
DisplaySum		ENDP
				END main