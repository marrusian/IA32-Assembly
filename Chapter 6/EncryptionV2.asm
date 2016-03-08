TITLE Message Encryption			(EncryptionV2.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Prompts the user for a plain-text message and an ecryption
;                key consisting of multiple characters and uses this key
;				 to encrypt and decrypt the plain-text by XORing each
;				 character of the key against a corresponding byte in
;				 the message. 
; Author:		 Marrusian
; Creation Date: 06/04/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
Delay			PROTO
ReadString		PROTO
ReadKey			PROTO
WriteChar		PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
; -------- C O N S T A N T S --------
KEY_CAPACITY = 20
BUFFER_CAPACITY = 2*128-1
DELAY_TIME = 1000
ESC_KEY = 1Bh
; -------- S T R I N G S --------
promptPlainMsg	BYTE "Enter the plain-text message: ",0
promptPlainErr	BYTE "Invalid message. Try again: ",0
promptKeyMsg	BYTE "Enter the key: ",0
promptKeyErr	BYTE "Invalid key. Try again: ",0
encryptMsg		BYTE "Crypted:    ",0
decryptMsg		BYTE "Decrypted:  ",0

				.DATA?
; -------- S T R I N G S --------
key				BYTE KEY_CAPACITY DUP (?)
buffer			BYTE BUFFER_CAPACITY DUP (?)
; -------- V A R I A B L E S --------
messageSize		BYTE ?
keySize			BYTE ?
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
; Calls: PromptMessage, PromptKey, TranslateBuffer, DisplayMessage, WaitOrQuit
L1:				call PromptMessage
				call PromptKey
				call TranslateBuffer
				mov edx,OFFSET encryptMsg
				call DisplayMessage
				call TranslateBuffer
				mov edx,OFFSET decryptMsg
				call DisplayMessage
				call WaitOrQuit
				jmp L1
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
PromptMessage	PROC USES edx ecx eax
;
; Description:	Prompts the user for a plain-text message.
; Receives:		N/A
; Returns:		N/A
; Calls:		WriteString, ReadString							(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET promptPlainMsg
PromptM:		call WriteString
				mov ecx,BUFFER_CAPACITY
				mov edx,OFFSET buffer
				call ReadString
if01:			test eax,0FFFFFFFFh
				jnz endif01
				mov edx,OFFSET promptPlainErr
				jmp PromptM
endif01:		mov messageSize,al
				ret
PromptMessage	ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
PromptKey		PROC USES edx ecx eax
; 
; Description:	Prompts the user for a key.
; Receives:		N/A
; Returns:		N/A
; Calls:		WriteString, ReadString, Crlf					(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET promptKeyMsg
PromptK:		call WriteString
				mov ecx,KEY_CAPACITY
				mov edx,OFFSET key
				call ReadString
if01:			test eax,0FFFFFFFFh
				jnz endif01
				mov edx,OFFSET promptKeyErr
				jmp PromptK
endif01:		mov keySize,al
				call Crlf
				ret
PromptKey		ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
TranslateBuffer	PROC USES ecx eax esi edi
;
; Description:	Encrypts a plain-text message based on a key if it's not
;				already encrypted. Otherwise, decrypts it.
; Receives:		N/A
; Returns:		N/A
; Calls:		N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				movzx ecx,messageSize
				mov esi,OFFSET key
				mov edi,OFFSET buffer
L1:				mov al,[esi]
				xor [edi],al
				inc esi
				inc edi
if01:			test BYTE PTR [esi], 0FFh
				jnz endif01
				mov esi,OFFSET key
endif01:		loop L1
				ret
TranslateBuffer	ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
DisplayMessage	PROC USES edx eax
;
; Description:	Displays the encrypted or decrypted message.
; Receives:		EDX = the offset of the message
; Returns:		N/A
; Calls:		WriteString, WriteChar, Crlf					(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				call WriteString
				mov edx,OFFSET buffer
				movzx ecx,messageSize
L1:				mov al,[edx]
				call WriteChar
				inc edx
				loop L1
				call Crlf
				ret
DisplayMessage	ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
WaitOrQuit		PROC USES eax 
;
; Description:	Inserts a delay of 1 second in which the user has the 
;				possibility to quit the program by pressing the ESC key.
;				If not, the program repeats.
; Receives:		N/A
; Returns:		N/A
; Calls:		Delay, ReadKey, Crlf							(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov eax,DELAY_TIME
				call Delay
				call ReadKey
if01:			cmp al,ESC_KEY
				jne endif01
				INVOKE ExitProcess,0
endif01:		call Crlf
				ret
WaitOrQuit		ENDP
				END main			
				
																										