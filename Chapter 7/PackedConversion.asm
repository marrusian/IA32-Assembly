TITLE Packed Decimal Conversion					(PDC.asm)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
; Description:	 Converts a 4-byte packed decimal integer to a string of
;				 ASCII decimal digits.
; Author:		 Marrusian
; Creation Date: 10/08/2014
; Revisions:	 N/A
; Date:			 N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.DATA			
PACKED_DECIMAL = 12345678h
buffer			BYTE (TYPE DWORD*2) DUP(?),0
sBuffer			BYTE "ASCII: ",0
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.CODE
main			PROC	
				mov eax,PACKED_DECIMAL
				mov edi,OFFSET buffer
				call PackedToAsc
				call Display_Buffer
main			ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
PackedToAsc		PROC USES eax edi ecx
;
; Description:	Converts a 4-byte PD integer to a string of ASCII decimal digits.
; Receives:		EAX = the packed integer
;				EDI = the offset of a buffer holding the ASCII digits
; Returns:		N/A
; Calls:		??
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov cx,TYPE DWORD*2-1
for01:			push eax
				push cx
				sal cl,2
				shr eax,cl
				and al,0Fh
				or  al,30h
				mov [edi],al
				pop cx
				pop eax
				inc edi
				loopw for01
				; Convert last HEX digit
				and al,0Fh
				or  al,30h
				mov [edi],al
				ret
PackedToAsc		ENDP
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
Display_Buffer	PROC
;
; Description:	Displays a buffer holding ASCII digits.
; Receives:		N/A
; Returns:		N/A
; Calls:		WriteString, Crlf								(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov edx,OFFSET sBuffer
				call WriteString
				mov edx,OFFSET buffer
				call WriteString
				call Crlf
				ret
Display_Buffer	ENDP
				END main 