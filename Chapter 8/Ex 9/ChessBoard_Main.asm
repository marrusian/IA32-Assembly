TITLE Chess Board						(ChessBoard_Main.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Draws an NxM chess board, with alternating gray and white
;				 squares.
; Author:		 Marrusian
; Creation Date: 12/08/2014
; Revisions:	 N/A
; Date			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.386
				.MODEL flat,stdcall
				.STACK 100h
; ------ E X T E R N A L S ------
EXTERN			DrawSquare@0:PROC

; ------ R E D E F I N I T I O N S ------
DrawSquare		EQU	DrawSquare@0

; ------ L I B - P R O C E D U R E S ------
Crlf			PROTO
Gotoxy			PROTO			; Y-coordinate = DH, X-coordinate = DL
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; ------ S Y M B O L S ------
black		=	0
blue		=	1
green		=	2
cyan		=	3
red			=	4
magenta		=	5
brown		=	6
lightGray	=	7
gray		=	8
lightBlue	=	9
lightGreen	=   10
lightCyan	=	11
lightRed	=	12
lightMagenta =  13
yellow		=	14
white		=	15
SQUARES_ON_COLUMN = 8
SQUARES_ON_ROW	  = 8
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				mov ecx,SQUARES_ON_COLUMN
				xor dx,dx
for01:			push ecx
				mov ecx,SQUARES_ON_ROW
				mov esi,esp
				test DWORD PTR [esi],1				; ecx%2
				jnz for03
				; DrawSquare(<color>,<number of squares>)
for02:			push SQUARES_ON_ROW
if01:			test ecx,1
				jnz else01
				push grey
				jmp endif01
else01:			push white
endif01:		call DrawSquare
				loop for02
				jmp endfor03
for03:			push SQUARES_ON_ROW
if02:			test ecx,1
				jnz else02
				push white
				jmp endif02
else02:			push grey
endif02:		call DrawSquare
				loop for03
endfor03:
				pop ecx
				loop for01
				INVOKE ExitProcess,0
main			ENDP

				END main