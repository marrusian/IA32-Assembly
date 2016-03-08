TITLE Square with Stripes	(SquareStripes_MAIN.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Displays a color square (10 rows by 20 columns) with
;				 alternating pairs of blue and white vertical bars.
; Author:		 Marrusian
; Creation Date: 12/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.386
				.MODEL flat,stdcall
				.STACK 100h
; --- E X T E R N A L S ---
EXTERN			WriteColorChar@0:PROC

; --- R E D E F I N I T I O N S ---
WriteColorChar	EQU		WriteColorChar@0

; --- L I B - P R O C E D U R E S ---
Crlf			PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
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
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				; WriteColorChar(char, forecolor, backcolor)
				mov ecx,10
L2:				push ecx
				mov ecx,10		
L1:				push blue
				push black
				push ' '
				call WriteColorChar
				push white
				push black
				push ' '
				call WriteColorChar
				loop L1
				pop ecx
				call Crlf
				loop L2
				INVOKE ExitProcess,0
main			ENDP

				END main