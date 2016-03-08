TITLE File of Fibonacci Numbers			(FibonacciFile.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Generates the first 47 values in the Fibonacci series, stores
;				 them in a DWORD array, and writes the array to a disk file.
; Author:		 Marrusian
; Creation Date: 02/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib	E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Clrscr			 PROTO
Crlf			 PROTO
CreateOutputFile PROTO	
WriteToFile		 PROTO
WriteString		 PROTO
WriteWindowsMsg	 PROTO
WriteDec		 PROTO
CloseFile		 PROTO	
ExitProcess		 PROTO	dwExitCode:DWORD		
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA		
INVALID_HANDLE_VALUE = -1				
FIBO_VALUES			 = 47

filename		BYTE "goldenfile.txt",0

fibErr			BYTE "ERROR: ARRAY SIZE IS LESS OR EQUAL TO 0",0
outputMsg		BYTE "Number of bytes written to file: ",0
genfileMsg		BYTE " has been CREATED with success.",0
clsfileMsg		BYTE " has been CLOSED with success.",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA?
fileHandle		DWORD ?

fiboArray		DWORD FIBO_VALUES DUP(?)	
fiboASCII		BYTE (SIZEOF fiboArray)*2 + (SIZEOF fiboArray - 1) DUP (?)	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
; Calls:		Clrscr, GenerateFibo, CreateFile, ItoA, WriteArray, CloseOpenFile.
				call Clrscr
				mov esi,OFFSET fiboArray
				mov ecx,LENGTHOF fiboArray
				call GenerateFibo
				mov edx,OFFSET filename
				call CreateFile
				mov fileHandle,eax
				mov esi,OFFSET fiboArray
				mov edi,OFFSET fiboASCII
				mov ecx,SIZEOF fiboArray
				call ItoA
				mov eax,fileHandle
				mov edx,OFFSET fiboASCII
				mov ecx,LENGTHOF fiboASCII
				call WriteArray
				mov eax,fileHandle
				mov edx,OFFSET filename
				call CloseOpenFile
				
				INVOKE ExitProcess,0				
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
GenerateFibo	PROC USES esi ecx eax ebx edx
;
; Description:	Generates values in the Fibonacci series, inserts them in a DWORD array.
;				Provides an array size-check.
; Receives:		ESI = offset of the DWORD array
;				ECX = number of values to generate
; Returns:		N/A
; Calls:		WriteString, Crlf								(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
if01:			cmp ecx,0			; if ecx > 0
				jle else01
then01:			mov eax,1
				mov ebx,1
 for01:			mov [esi],eax
				add ebx,eax
				sub eax,ebx
				neg eax		
				add esi,TYPE DWORD
				loop for01
 endfor01:		jmp endif01						
else01:			mov edx,OFFSET fibErr
				call WriteString
				call Crlf
endif01:		nop						
				ret
GenerateFibo	ENDP	

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
CreateFile		PROC USES ecx
; 
; Description:	Creates a new disk file and opens it for writing.
;				Performs a file-creation-error check.
; Receives:		EDX = the offset of a filename
; Returns:		EAX = a valid 32-bit file handle
; Calls:		CreateOutputFile, WriteString, WriteWindowsMsg, Crlf (Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push edx
				call CreateOutputFile
if01:			cmp eax,INVALID_HANDLE_VALUE	; if eax != INVALID_HANDLE_VALUE
				je else01
then01:			pop edx
				call WriteString
				push edx
				mov edx,OFFSET genfileMsg
				call WriteString
				jmp endif01
else01:			call WriteWindowsMsg
endif01:		call Crlf	
				pop edx			
				ret
CreateFile		ENDP	
	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
CloseOpenFile	PROC USES ecx
;
; Description:	Closes an open disk file.
;				Performs a file-closing-error check.
; Receives:		EAX = a valid 32-bit file handle
;				EDX = the offset of the filename
; Returns:		N/A
; Calls:		CloseFile, WriteWindowsMsg, WriteString, Crlf	(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push edx
				call CloseFile
if01:			test eax,eax					; if eax != 0
				jz else01
then01:			pop edx
				call WriteString
				push edx
				mov edx,OFFSET clsfileMsg
				call WriteString
				jmp endif01
else01:			call WriteWindowsMsg
endif01:		call Crlf	
				pop edx			
				ret
CloseOpenFile	ENDP		

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
ItoA			PROC USES esi edi ecx eax
;
; Description:	 Converts an array of integers to ASCII character codes
;				 in HEX format, where every byte is separated by a blank(space)
;				 from the previous one. 
; Preconditions: LENGTHOF <Destination Array> = (SIZEOF <Source Array>)*2 +
;											  + (SIZEOF <Source Array>-1)
; Receives:		 ESI = the offset of the array to be converted (source array)
;				 EDI = the offset of the array for storing the ASCII ch. codes
;					  (destination array)
;				 ECX = SIZEOF <Source Array>
; Returns:		 N/A
; Calls:		 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
for01:			mov al,[esi]
				mov ah,al
				shr ah,4
				and ah,0Fh
				and al,0Fh	
 if01:			cmp ah,9
				jg else01
 then01:		xor ah,00110000b
				jmp endif01
 else01:		sub ah,9
				xor ah,01000000b
 endif01:		mov [edi],ah
				inc edi
 if02:			cmp al,9
				jg else02
 then02:		xor al,00110000b
				jmp endif02
 else02:		sub al,9
				xor al,01000000b
 endif02:		mov [edi],al			
				inc edi
				mov [edi],BYTE PTR 20h
 				inc edi
 				inc esi
 				loop for01
endfor01:		nop				
				ret
ItoA			ENDP				
				
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
WriteArray		PROC USES eax edx ecx
;
; Description:	Writes an array to a disk file.
;				Performs a write-error check.
; Receives:		EAX = a 32-bit valid file handle
;				EDX = the buffer offset
;				ECX = number of array elements to write
; Returns:		N/A
; Calls:		WriteToFile, WriteString, WriteDec,
;				WriteWindowsMsg, Crlf							(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				call WriteToFile
if01:			test eax,eax				; if eax != 0
				jz else01
then01:			mov edx,OFFSET outputMsg
				call WriteString
				call WriteDec
				jmp endif01
else01:			call WriteWindowsMsg
endif01:		call Crlf						
				ret
WriteArray		ENDP	
				
				END main																