TITLE BubbleSort						(bSort.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Implements and tests the BubbleSort algorithm.
; Author:		 Marrusian
; Creation Date: 14/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
BubbleSort		PROTO pArray:PTR DWORD, sizeArray:DWORD	
DumpMem			PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
arr				DWORD	5, 19, -2, -44, 39, 22, -56, 2
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				mov ecx,LENGTHOF arr
				mov ebx,TYPE arr
				mov esi,OFFSET arr
				call DumpMem
				INVOKE BubbleSort, ADDR arr, LENGTHOF arr
				call DumpMem
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
BubbleSort		PROC USES esi ecx eax ebx,
					 pArray:PTR DWORD, sizeArray:DWORD
;
; Description:	Sorting algorithm.
; Receives:		pArray:PTR DWORD	=	pointer to an array of DWORDs
;				sizeArray:DWORD		=	the array's length
; Returns:		N/A
; Calls:		N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov ecx,sizeArray
				dec ecx
				mov esi,pArray
for01:			test bl,bl
				jz endfor01
				xor bl,bl
				push esi
				push ecx
 for02:			mov eax,[esi]
  if01:			cmp eax,[esi+TYPE DWORD]
				jle endif01
				xchg eax,[esi+TYPE DWORD]
				mov [esi],eax
				or bl,1
  endif01:		add esi,TYPE DWORD		
				loop for02
				pop ecx
				pop esi
				loop for01
endfor01:		
				ret
BubbleSort		ENDP

				END main