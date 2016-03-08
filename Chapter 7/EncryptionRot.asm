TITLE Encryption using Rotate				(EncryptionRot.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Performs a simple encryption by rotating each plain-text
;				 byte a varying number of positions in different directions.
;				 The key is an array of bytes, each byte representing the
;				 magnitude of the rotation and the direction.
;				 A negative value represents a rotation to the left and
;				 a positive value indicates a rotation to the right.
; Author:		 Marrusian
; Creation Date: 09/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO				
ReadString		PROTO
WriteChar		PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
; ---------- C O N S T A N T S -------
KEY_CAPACITY = 127		; 2^7-1
BUFFER_CAPACITY = 255	; 2^8-1

; ---------- V A R I A BL E S -------
keySize			BYTE ?
bufSize			BYTE ?

; ---------- S T R I N G S ----------
prtMsg			BYTE "Enter a plain-text message: ",0
prtErr			BYTE "Invalid message. Try again: ",0
keyMsg			BYTE "Enter a key: ",0
keyErr			BYTE "Invalid key. Try again: ",0
sEncrypt		BYTE "Encrypted: ",0
sDecrypt		BYTE "Decrypted: ",0

				.DATA?
; ---------- S T R I N G S ----------
buffer			BYTE BUFFER_CAPACITY DUP(?)
key				BYTE KEY_CAPACITY	 DUP(?)		; Ex: -2,4,1,0,-3,5,2,-4,-4,6
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				call PromptMsg
				call PromptKey
				call EncryptBuffer
				mov edx,OFFSET sEncrypt
				call Display_Message

				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
PromptMsg		PROC USES eax ecx edx
;
; Description:	Prompts the user for a plain-text message.
; Receives:		N/A
; Returns:		N/A
; Calls:		ReadString, WriteString							(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET prtMsg
Prompt:			call WriteString
				mov edx,OFFSET buffer
				mov ecx,LENGTHOF buffer
				call ReadString
if01:			test eax,eax
				jnz endif01
				mov edx,OFFSET prtErr
				jmp Prompt
endif01:		mov bufSize,al
				ret
PromptMsg		ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
PromptKey		PROC USES eax ecx edx
;
; Description:	Prompts the user for a key.
; Receives:		N/A
; Returns:		N/A
; Calls:		ReadString, WriteString							(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET keyMsg
Prompt:			call WriteString
				mov edx,OFFSET key
				mov ecx,LENGTHOF key
				call ReadString
if01:			test eax,eax
				jnz endif01
				mov edx,OFFSET keyErr
				jmp Prompt
endif01:		mov keySize,al
				ret
PromptKey		ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
EncryptBuffer	PROC USES ecx esi edi
;
; Description:	Encrypts or decrypts a buffer based on a key.
; Receives:		N/A
; Returns:		N/A	
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				movzx cx,bufSize
				mov esi,OFFSET key
				mov edi,OFFSET buffer
for01:			push cx
				mov cl,[esi]
if01:			test cl,00010000b			;  test for hyphen '-'
				jz else01
				and cl,00Fh
				shr BYTE PTR [edi],cl
				jmp endif01
else01:			inc esi
				mov cl,[esi]
				and cl,00Fh
				shl BYTE PTR [edi],cl
endif01:		pop cx	
				inc esi	
				inc edi
if02:			test BYTE PTR [esi],0FFh
				jnz endif02
				mov esi,OFFSET key
endif02:		loopw for01	
				ret
EncryptBuffer	ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Display_Message	PROC
;
; Description:	Displays an encrypted or decrypted message.
; Receives:		EDX = the offset of the status
; Returns:		N/A
; Calls:		WriteString, Crlf								(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤	
				call WriteString
				mov esi,OFFSET buffer
				movzx cx,bufSize
for01:			mov al,[esi]
				call WriteChar
				inc esi
				loopw for01
				call Crlf
				ret
Display_Message	ENDP
				END main