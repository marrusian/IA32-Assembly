TITLE DrawLine Procedure				(_drawLine.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
; --- E X T E R N A L S ---
EXTERN			WriteColorChar@0:PROC

GetTextColor	PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
DrawLine		PROC
;
; Description:	Draws a colored line of variable length.
; Receives:		cols:DWORD		=	the number of columns
;				color:DWORD		=	the backcolor
; Format:		DrawLine(cols, color)
; Returns:		N/A
; Calls			WriteColorChar								(_writeColorChar.asm)
;				GetTextColor								(Irvine32.lib)
; Symbols:
				color EQU [ebp + 12]
				cols  EQU [ebp + 8]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push ebp
				mov ebp,esp
				push ecx
				push eax
				xor eax,eax
				call GetTextColor	
				and al,00Fh				; Leave the default forecolor	
				mov ecx,cols
				; WriteColorChar(char, forecolor, backcolor)
for01:			push color
				push eax
				push ' '
				call WriteColorChar@0
				loop for01
				pop eax
				pop ecx
				pop ebp
				ret 8
DrawLine		ENDP

				END