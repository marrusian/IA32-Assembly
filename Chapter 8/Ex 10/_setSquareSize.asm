TITLE SetSquareSize	Procedure				(_setSquareSize.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
GetMaxXY		PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
boardErr		BYTE "Error: The board won't fit in the current Console Window's buffer size",0Dh,0Ah,0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
SetSquareSize	PROC
;
; Description:	Gets the size of the console window's buffer and sets the
;				dimensions of a square (number of rows and columns)
;				according to the number of squares on a side.
; Receives:		squares:DWORD	=	the number of squares on a side
; Format:		SetSquareSize(squares, ADDR sideLength)
; Returns:		sideLength:PTR DWORD	=	the side length of a square
; Calls:		GetMaxXY, WriteString							(Irvine32.lib)
; Symbols:
				sideLength EQU DWORD PTR [ebp + 12]	
				 squares   EQU DWORD PTR [ebp + 8]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push ebp
				mov ebp,esp
				push edi
				push eax
				push edx
				push ebx
				mov edi,sideLength
				mov ebx,squares
				call GetMaxXY		; DX = buffer columns, AX = buffer rows
if01:			cmp bx,dx			; Check if the number of squares isn't bigger than CW's buffer size.
				jge then01
				cmp bx,ax		
				jnge endif01
then01:			mov edx,OFFSET boardErr
				call WriteString
				INVOKE ExitProcess,0
endif01:		
if02:			cmp ax,dx			; Set the sideLength according to the smallest parameter 
				jg else02			; of the CW's buffer
				xor edx,edx
				movzx eax,ax
				div ebx
				jmp endif02
else02:			movzx eax,dx
				xor edx,edx
				div ebx
endif02:		mov [edi],eax
				pop ebx
				pop edx
				pop eax
				pop edi
				pop ebp
				ret 8
SetSquareSize	ENDP

				END