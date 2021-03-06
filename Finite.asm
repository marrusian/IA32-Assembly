TITLE Finite State Machine				(Finite.asm)

includelib	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Clrscr			PROTO
Crlf			PROTO
IsDigit			PROTO
ReadChar		PROTO
WriteChar		PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.DATA
ENTER_KEY = 13

InvalidInputMsg	BYTE "Invalid input",0
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.CODE
main			PROC
; Calls: Clrscr, Getnext, IsDigit, DisplayErrorMsg
				call Clrscr
StateA:			call Getnext
				cmp al,'+'
				je StateB
				cmp al,'-'
				je StateB
				call IsDigit
				jz StateC
				call DisplayErrorMsg
				jmp Quit
StateB:			call Getnext
				call IsDigit
				jz StateC
				call DisplayErrorMsg
				jmp Quit
StateC:			call Getnext
				call IsDigit
				jz StateC
				cmp al,ENTER_KEY
				je Quit
				call DisplayErrorMsg
				jmp Quit
Quit:			call Crlf
				INVOKE ExitProcess,0
main			ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
Getnext			PROC
;
; Description:	Reads a character from standard input.
; Receives:		N/A
; Returns:		AL = the character's ASCII code
; Calls:		ReadChar, WriteChar								(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				call ReadChar
				call WriteChar
				ret
Getnext			ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
DisplayErrorMsg	PROC USES edx
;
; Description:	Displays an error message indicating that the input stream
;				contains illegal input.
; Receives:		N/A
; Returns:		N/A
; Calls:		WriteString, Crlf								(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov edx,OFFSET InvalidInputMsg
				call WriteString
				call Crlf
				ret
DisplayErrorMsg	ENDP

				END main