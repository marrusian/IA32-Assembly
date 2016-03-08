TITLE Probabilities and Colors			(ProbCols.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:   Randomly chooses among three different predefined colors 
;                for displaying text on the screen.
; Author:		 Marrusian
; Creation Date: 06/04/2018
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
Randomize		PROTO
RandomRange		PROTO
SetTextColor	PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
; -------- C O N S T A N T S --------
REPEAT_COUNT = 20
MAX_PROBABILITY = 10
WHITE = 15
BLUE = 1
GREEN = 2

; -------- S T R I N G S --------
string			BYTE "This is a string for testing purposes.",0Dh,0Ah,0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC	
; Calls: Randomize, SetRandomColor, WriteString
				mov ecx,REPEAT_COUNT
				mov edx,OFFSET string
				call Randomize
L1:				call SetRandomColor
				call WriteString
				loop L1
				INVOKE ExitProcess,0			
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
SetRandomColor	PROC USES eax
;
; Description:	Randomly chooses among three different predefined colors.
; Receives:		N/A
; Returns:		N/A
; Calls:		RandomRange, SetTextColor
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov eax,MAX_PROBABILITY
				call RandomRange
if01:			cmp al,BYTE PTR 2
				jnle elseif02
				mov al,WHITE
				jmp endif01
elseif02:		cmp al,BYTE PTR 3
				jne else02
				mov al,BLUE
				jmp endif01
else02:			mov al,GREEN
endif01:		call SetTextColor
				ret
SetRandomColor	ENDP

				END main	