TITLE Factorial Overflow				(_factorialOverflow.asm)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
WriteString		PROTO
Crlf			PROTO
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.DATA
factErr			BYTE "Error: Calculated value cannot fit into 32 bits",0
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.CODE
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
FactorialOF		PROC USES edx
;
; Description:	Displays an error if the value calculated by _factorial.asm
;				can't fit in a 32-bit register.
; Receives:		N/A
; Returns:		N/A
; Calls:		WriteString, Crlf								(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov edx,OFFSET factErr
				call WriteString
				call Crlf
				call Crlf
				ret
FactorialOF		ENDP

				END