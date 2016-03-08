TITLE DrawSquare Procedure						(_drawSquare.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
; ------ E X T E R N A L S ------
EXTERN			SetSquareSize@0:PROC
EXTERN			DrawLine@0:PROC

; ------ L I B - P R O C E D U R E S ------
Gotoxy			PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
DrawSquare		PROC
;
; Description:	Draws a square within the console window's buffer and
;				adjusts the console cursor.
; Receives:		color:DWORD		 =	the color of the square
;				squares:DWORD	 =	the number of squares on rows (i.e squares on a single column)
;									(sideLength will depend on this number, adjusting the size accordingly)
; Format:		DrawSquare(<color>,<number of squares>)
; Returns:		N/A
; Calls:		Gotoxy											(Irvine32.lib)
; Symbols:
				squares	   EQU DWORD PTR [ebp + 12]
				color	   EQU DWORD PTR [ebp + 8]
; Locals:
				sideLength EQU DWORD PTR [ebp - 4]		
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push ebp								
				mov ebp,esp																													
				sub esp,4																				
				push ecx									
				push edi		
				push eax	
				call Gotoxy						; Set console buffer position at (0,0)
				; SetSquareSize(squares, ADDR sideLength)
				lea edi,sideLength
				push edi
				push squares
				call SetSquareSize@0
				mov ecx,sideLength				; Square size is ((sideLength/2 + 1) X sideLength)
				sar ecx,1
				inc ecx
				; DrawLine(cols, color)
for01:			push color
				push sideLength
				call DrawLine@0
				inc dh							; Go to next line/row
				call Gotoxy
				loop for01
				push edx
				mov eax,sideLength				; Check if all squares have been drawn on the current column
				sar eax,1
				inc eax
				mul squares
				pop edx
if01:			cmp dh,al						
				jne endif01
				xor dh,dh						; Reset Y-coordinate (i.e go to the top of the CW buffer)
				add dl,BYTE PTR sideLength		; Displace the X-coordinate past the first columns of squares
endif01:		call Gotoxy
				pop eax
				pop edi
				pop ecx
				mov esp,ebp
				pop ebp
				ret 8
DrawSquare		ENDP

				END