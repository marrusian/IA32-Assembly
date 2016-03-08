TITLE Counting Array Values		(CAV.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Fills an array with 50 rand. integers, displays each
;				 value, counts the number of negative values and displays
;				 the count.
; Author:		 Marrusian
; Creation Date: 06/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
Randomize		PROTO
Random32		PROTO
WriteChar		PROTO
WriteInt		PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
ARRAY_SIZE = 50
TAB = 9
				.DATA
negvalMsg		BYTE "Total negative values in the array: ",0
				.DATA?
rArray			SDWORD ARRAY_SIZE DUP (?) 
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
; Calls: Randomize, FillArray, ScanArray
				call Randomize
				mov edi,OFFSET rArray
				mov ecx,LENGTHOF rArray
				call FillArray
				mov esi,OFFSET rArray
				mov ecx,LENGTHOF rArray
				call ScanArray
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
FillArray		PROC USES edi ecx eax
;
; Description:	Fills an array with random 32-bit integers.
; Receives:		EDI = the offset of the array
;				ECX = the array's length
; Returns:		N/A
; Calls:		Random32										(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
L1:				call Random32
				mov [edi],eax
				add edi,TYPE DWORD
				loop L1				
				ret
FillArray		ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
ScanArray		PROC USES esi ecx edx ebx eax
;
; Description:	Displays each value in a signed array, counts the negative
;				values and displays the count at the end.
; Receives:		ESI = the offset of the array
;				ECX = the array's length
; Returns:		N/A
; Calls:		WriteInt, WriteChar, WriteString, Crlf			(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				xor ebx,ebx
L1:				mov eax,[esi]
				call WriteInt
 if01:			test eax,80000000h
				jz endif01
				inc ebx
 endif01:		mov al,TAB
				call WriteChar
				add esi,TYPE DWORD
				loop L1
				call Crlf
				mov edx,OFFSET negvalMsg
				call WriteString
				mov eax,ebx
				call WriteInt
				call Crlf
				ret
ScanArray		ENDP

				END main