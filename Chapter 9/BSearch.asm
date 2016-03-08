TITLE Binary Search					(BSearch.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Implements and tests the Binary Search algorithm.
; Author:		 Marrusian
; Creation Date: 14/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
WriteDec		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
arr				DWORD -22, -4, -2, 0, 0, 1, 5, 59, 66, 392, 9294
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				push LENGTHOF arr
				push OFFSET arr
				push 1
				call BinarySearch
				call WriteDec
				call Crlf
				INVOKE ExitProcess,0
main			ENDP
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
BinarySearch	PROC
;
; 
;
;
; Symbols:
					sizeArray	EQU DWORD PTR [ebp + 16]
					pArray		EQU DWORD PTR [ebp + 12]
					searchVal	EQU DWORD PTR [ebp + 8]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				enter 0,0
; first = 0, mid = (last + first)/2, last = array+size-1
; if mid >= searchVal, last = mid-1
; else if (mid < searchVal), first = mid + 1
; else return searchVal index in array
				push esi
				push ebx
				push edx
				push ecx
				mov esi,pArray
				mov ebx,0				; first = ebx
				mov edx,sizeArray		; last = edx
				dec edx
				mov ecx,searchVal
while01:		cmp ebx,edx
				jnle endw01
				mov eax,ebx				; mid = eax
				add eax,edx
				sar eax,1
if01:			cmp [esi+eax*TYPE DWORD],ecx
				jge elseif02
				mov ebx,eax
				inc ebx
				jmp endif01
elseif02:		je else02			
				mov edx,eax
				dec edx
				jmp endif01
else02:			jmp endw01
endif01:		jmp while01
endw01:			pop ecx
				pop edx
				pop ebx
				pop esi
				leave
				ret
BinarySearch	ENDP

				END main