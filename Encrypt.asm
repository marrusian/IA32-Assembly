TITLE Encription Program				(Encrypt.asm)

includelib	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
ReadString		PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
KEY = 239
BUFMAX = 128

sPrompt			BYTE "Enter the plain text: ",0
sEncrypt		BYTE "Cipher text:          ",0
sDecrypt		BYTE "Decrypted:            ",0
  
				.DATA?
buffer			BYTE BUFMAX+1 DUP(?)
bufSize			DWORD ?
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
; Calls: InputString, TranslateBuffer, DisplayMessage
				call InputString
				call TranslateBuffer
				mov edx,OFFSET sEncrypt
				call DisplayMessage
				call TranslateBuffer
				mov edx,OFFSET sDecrypt
				call DisplayMessage
				INVOKE ExitProcess,0
main			ENDP
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
InputString		PROC USES edx ecx eax
;
; Description:	Prompts the user for a plaintext string. Saves the string
;				and its length.
; Receives:		N/A
; Returns:		N/A
; Calls:		WriteString, ReadString, Crlf					(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET sPrompt
				call WriteString
				mov ecx,BUFMAX
				mov edx,OFFSET buffer
				call ReadString
				mov bufSize,eax
				call Crlf
				ret
InputString		ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
TranslateBuffer	PROC USES ecx esi
;
; Description:	Translated the string by XOR-ing each byte with the
;				encryption key byte.
; Receives:		N/A
; Returns:		N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov ecx,bufSize
				mov esi,0
for01:			xor buffer[esi],KEY
				inc esi
				loop for01
endfor01:		nop
				ret
TranslateBuffer	ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
DisplayMessage	PROC USES edx
;
; Description:  Displays the encrypted or decrypted message.
; Receives:		EDX = the message offset
; Returns:		N/A
; Calls:		WriteString, Crlf								(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				call WriteString
				mov edx,OFFSET buffer
				call WriteString
				call Crlf
				call Crlf
				ret
DisplayMessage	ENDP

				END main