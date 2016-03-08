TITLE Letter Matrix						(LMatrix_Main.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Generates a NxM matrix of randomly chosen capital letters
;				 with a 50% probability that the chosen letter is a vowel.
;				 and stores it in a two-dimensional array.
; Author:		 Marrusian
; Creation Date: 15/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
; --- E X T E R N A L S ---
EXTERN			GenMatrix@0:PROC
; --- R E D E F I N I T I O N S ---
GenMatrix		EQU GenMatrix@0
; --- L I B - P R O C E D U R E S ---
Crlf			PROTO
Randomize		PROTO
WriteChar		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; --- S Y M B O L S ---
 M = 4				; Number of columns
 N = 4				; Number of rows
 SPACE = 20h		; ASCII hex code for the SPACE character
 REPEAT_COUNT = 5	; Number of MAIN loops
				.DATA?
matrix			BYTE N*M DUP(?)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				call Randomize
				mov ecx,REPEAT_COUNT
for_main:		push ecx
				; GenMatrix(N, M, ADDR pArray)	
				push OFFSET matrix
				push M
				push N
				call GenMatrix

				; Display Matrix
				xor ebx,ebx			; Row-index
				xor esi,esi			; Col-index
				mov ecx,M			; Col-Loops
for01:			push ecx
				mov ecx,N			; Row-Loops
for02:			mov al,matrix[ebx+edi*TYPE BYTE]
				call WriteChar
				mov al,SPACE
				call WriteChar
				inc edi
				loop for02
				pop ecx
				add ebx,M*TYPE BYTE  ; Go to next row
				xor edi,edi			 ; Reset col-index
				call Crlf
				loop for01

				call Crlf
				pop ecx
				loop for_main
				INVOKE ExitProcess,0
main			ENDP
	
				END main