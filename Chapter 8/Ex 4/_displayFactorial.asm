TITLE Display Factorial					(_displayFactorial.asm)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
Crlf			PROTO
WriteString		PROTO
WriteDec		PROTO
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.DATA
displayMsg		BYTE "The factorial is: ",0
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.CODE
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
DisplayFacto	PROC USES edx
;
; Description:	Displays the factorial value calculated by _factorial.asm
; Receives:		EAX = the factorial
; Returns:		N/A
; Calls:		WriteString, Crlf								(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�				
				mov edx,OFFSET displayMsg
				call WriteString
				call WriteDec
				call Crlf
				call Crlf
				ret
DisplayFacto	ENDP

				END