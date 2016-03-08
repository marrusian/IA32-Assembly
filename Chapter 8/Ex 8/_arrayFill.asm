TITLE Fill Array Procedure			(_arrayFill.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
RandomRange		PROTO
WriteString		PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; --- S Y M B O L S ---
; RandomRange generates numbers in the 0 to n-1 range.
BYTE_MAX = 128				; 2^7
WORD_MAX = 32768			; 2^15
DWORD_MAX = 2147483648		; 2^31

				.DATA
sizeArrayErr	BYTE "The size of the array can't be less or equal to 0",0Dh,0Ah,0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
FillArray		PROC
;
; Description:	Fills an array with random integers based on the array's
;				size attribute.
; Receives:		pArray:PTR DWORD	=	points to the array
;				lengthArray:DWORD	=	the length of the array
;				sizeArray:DWORD		=	the size of the array
; Format:		FillArray(<array>, LENGTHOF <array>, TYPE <array>)
; Returns:		N/A
; Calls:		RandomRange
; Symbols:
				  sizeArray	EQU DWORD PTR [ebp + 16]
				lengthArray	EQU DWORD PTR [ebp + 12]
					 pArray	EQU	DWORD PTR [ebp + 8]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push ebp
				mov ebp,esp
				push ebx
				push edx
switch01:		cmp sizeArray,TYPE BYTE
				je case1
				cmp sizeArray,TYPE WORD
				je case2
				cmp sizeArray,TYPE DWORD
				jge case3
				jmp default
case1:			mov ebx,BYTE_MAX
				jmp endswitch01
case2:			mov ebx,WORD_MAX
				jmp endswitch01
case3:			mov ebx,DWORD_MAX
				jmp endswitch01
default:		mov edx,OFFSET sizeArrayErr
				call WriteString
				jmp exit
endswitch01:	push eax
				push ecx
				push edi
				mov ecx,lengthArray
				mov edi,pArray
for01:			mov eax,ebx
				call RandomRange
				mov [edi], eax
				add edi,sizeArray				
				loop for01
				pop edi
				pop ecx
				pop eax
exit:			pop edx
				pop ebx
				pop ebp
				ret 12
FillArray		ENDP

				END