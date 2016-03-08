TITLE Show Parameters PROCEDURE				(_showParams.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
Crlf			PROTO
WriteString		PROTO
WriteHex		PROTO
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
stackParamMsg	BYTE "Stack parameters: ",0Dh,0Ah,
					 "--------------------------------",0Dh,0Ah,0
stackParamErr	BYTE "No parameters available to display",0Dh,0Ah,0
paramAddrMsg	BYTE "Address ",0
paramFormat		BYTE " = ",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
ShowParams		PROC
;
; Description:	Displays the address and hexadecimal value of the 32-bit
;				parameters on the runtime stack of the procedure that
;				called it using little endian order.
; Receives:		pCount:DWORD	=	the number of parameters to display
; Format:		ShowParams(n)
; Returns:		N/A
; Calls:		WriteString, WriteHex, Crlf						(Irvine32.lib)
; Symbols:
				pCount	EQU [ebp + 8]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				push ebp							
				push esi			
				mov esi,ebp			; Save the EBP of the calling program
				add esi,8			; Skip calling program's return address, go to its first parameter offset
				mov ebp,esp
				add ebp,4			; Correct the offset displacement created by pushing ESI
				push edx
				push ecx
				push eax
				mov ecx,pCount
if01:			test ecx,ecx
				jz else01
				mov edx,OFFSET stackParamMsg
				call WriteString
for01:			mov edx,OFFSET paramAddrMsg
				call WriteString
				mov eax,esi
				call WriteHex
				mov edx,OFFSET paramFormat
				call WriteString
				mov eax,[esi]
				call WriteHex
				add esi,TYPE DWORD
				call Crlf
				loop for01
endfor01:		jmp endif01
else01:			mov edx,OFFSET stackParamErr
				call WriteString
endif01:		pop eax
				pop ecx
				pop edx
				pop esi
				pop ebp
				ret 4
ShowParams		ENDP

				END