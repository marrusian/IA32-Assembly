TITLE Color Matrix					(CMatrix.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Displays a single character in all possible combinations
;				 of foreground and background colors (16x16=256).
; Author:		 Marrusian
; Creation Date: 04/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
SetTextColor	PROTO
WriteChar		PROTO	
Crlf			PROTO			
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
BLANK = 20h
BG_COLORS = 15
FG_COLORS = 15
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
; Calls: ColorMatrix
				mov bl,'X'
				mov dh,BG_COLORS
				mov dl,FG_COLORS
				call ColorMatrix
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
ColorMatrix		PROC USES eax ecx edx ebx
;
; Description:	Displays a single character in a combination of N background
;				colors and M foreground colors, where N & M <= 15.
; Receives:		BL = the character's ASCII code
;				DL = number of foreground colors
;				DH = number of background colors
; Returns:		N/A
; Calls:		SetTextColor, WriteChar, Crlf					(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov eax,0
				movzx ecx,dh
for01:			push ecx
				mov al,cl
				shl al,4
				movzx ecx,dl
 for02:			push eax
 				or al,cl
				call SetTextColor
				mov al,bl
				call WriteChar
				mov al,BLANK
				call WriteChar
				pop eax
				loop for02
 endfor02:		call Crlf
				pop ecx		
				loop for01
endfor01:		nop				
				ret
ColorMatrix		ENDP
				END main