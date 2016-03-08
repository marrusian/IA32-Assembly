TITLE Generate Matrix						(_genMatrix.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
; --- E X T E R N A L S ---
EXTERN			GenRandLetter@0:PROC
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
GenMatrix		PROC
;
; Description:	Generates a NxM matrix of randomly chosen capital letters
;				with a 50% probability that the chosen letter is a vowel
;				and stores it in a two-dimensional array.
; Receives:		N:DWORD			 = number of rows
;				M:DWORD			 = number of columns
;				pArray:PTR DWORD = pointer to two-dimensional row-major order BYTE array
; Returns:		N/A
; Format:		GenMatrix(N, M, ADDR pArray)	
; Calls:		GenRandLetter()								(_genRandLetter.asm)
; Symbols:
				pArray EQU DWORD PTR [ebp + 16]
					M  EQU DWORD PTR [ebp + 12]
					N  EQU DWORD PTR [ebp + 8]
; Constants:
				row_index = 0
				col_index = 0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				enter 0,0
				pushad					
				mov edx,M			
				mov esi,N
				mov ebx,pArray
				mov edi,col_index
				mov ecx,edx					; Column Loops (Outside-Loops)
for01:			push ecx
				mov ecx,esi					; Row Loops (Index-Loops)
 for02:			call GenRandLetter@0
				mov [ebx+edi*TYPE BYTE],al	; BASE-INDEX operand
				inc edi
				loop for02
				pop ecx
				add ebx,edx					; Go to next row
				xor edi,edi					; Reset col_index
				loop for01
				popad
				leave
				ret 12
GenMatrix		ENDP

				END												