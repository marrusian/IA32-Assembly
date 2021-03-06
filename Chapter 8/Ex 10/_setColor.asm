TITLE SetColor Procedure			(_setColor.asm)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
SetTextColor	PROTO
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.CODE
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
SetColor		PROC
;
; Description:	Sets text and background color by calling the SetTextColor
;				from the Irvine32 link library.
; Receives:		forecolor:BYTE
;				backcolor:BYTE
; Returns:		N/A
; Calls:		SetTextColor									(Irvine32.lib)
; Symbols:	
				backcolor	EQU	 [ebp + 12]
				forecolor	EQU  [ebp + 8] 							
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				push ebp
				mov ebp,esp
				push eax
				mov eax,backcolor
				shl eax,4
				add eax,forecolor
				call SetTextColor
				pop eax
				pop ebp
				ret 8
SetColor		ENDP

				END