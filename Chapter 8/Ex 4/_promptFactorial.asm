TITLE Prompt for Factorial			(_promptFactorial.asm)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
WriteString		PROTO
ReadInt			PROTO
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.DATA
promptMsg		BYTE "Enter the value of n to ",
					 "calculate the factorial (-1 to quit): ",0
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.CODE
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
PromptFactorial	PROC USES edx
;
; Description:	Prompts the user for an integer to calculate its factorial.
; Receives:		N/A
; Returns:		EAX = the integer
; Calls:		WriteString, ReadDec							(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov edx,OFFSET promptMsg
				call WriteString
				call ReadInt
				ret
PromptFactorial	ENDP

				END