TITLE Traverse Matrix Procedure						(_traverseMatrix.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
; --- E X T E R N A L S ---
EXTERN			GenVowelSet@0:PROC
EXTERN			set:BYTE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
TraverseMatrix	PROC
;
; Description:	Traverses a matrix by row, column and diagonal.
; Receives:		pMatrix:PTR BYTE = pointer to matrix (two-dimensional array)
;						 N:DWORD = the number of rows
;						 M:DWORD = the number of columns
; Returns:		N/A
; Format:		TraverseMatrix(ADDR pMatrix, N, M)
; Calls:		GenVowelSet									(_genVowelSet.asm)
; Symbols:
				M EQU DWORD PTR [ebp + 16]
				N EQU DWORD PTR [ebp + 12]
		  pMatrix EQU DWORD PTR [ebp + 8]
; Constants:
				NUMBER_OF_DIAGONALS = 2
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				enter 0,0
				pushad
				mov ebx,pMatrix
				mov edi,ebx
				mov esi,N
				mov edx,M
				mov eax,OFFSET set

				; Traverse columns
				mov ecx,edx
				push ebx
				; GenVowelSet(ADDR pSet, ADDR pRow, ADDR pCol, setSize)
for01:			push edx
				push 0
				push ebx
				push eax
				call GenVowelSet@0
				add ebx,edx
				test BYTE PTR [eax],0FFh
				jz endif01
				add eax,edx
endif01:		loop for01
				pop ebx

				; Traverse rows
				mov ecx,esi
				push edi
				; GenVowelSet(ADDR pSet, ADDR pRow, ADDR pCol, setSize)
for02:			push esi
				push edi
				push 0
				push eax
				call GenVowelSet@0
				inc edi
				test BYTE PTR [eax],0FFh
				jz endif02
				add eax,esi
endif02:		loop for02
				pop edi

if04:			cmp esi,edx
				jne endif04
				; Traverse diagonals (because N=M, ESI can be interchanged with EDX)
				mov ecx,NUMBER_OF_DIAGONALS
				; GenVowelSet(ADDR pSet, ADDR pRow, ADDR pCol, setSize)
 for03:			push esi		
				push edi
				push ebx
				push eax
				call GenVowelSet@0
				add ebx,edx
				dec ebx
				test BYTE PTR [eax],0FFh
				jz endif03
				add eax,esi
endif03:		loop for03
endif04:		popad
				leave
				ret 12
TraverseMatrix	ENDP
	
				END