TITLE Boolean Calculator			(BoolCalc.asm)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
; Description:   ???
; Author:		 Marrusian
; Creation Date: 06/04/2018
; Revisions:	 N/A
; Date:			 N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
includelib	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
ReadInt			PROTO
ReadHex			PROTO
WriteString		PROTO
WriteHex		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.DATA
;------ C O N S T A N T S ------	
FIRST_CHOICE = 1
LAST_CHOICE = 5
		
;------ C A S E - T A B L E ------
caseTable		BYTE 1
				DWORD AND_op
entrySize = ($-caseTable)
				BYTE 2
				DWORD OR_op
				BYTE 3
				DWORD NOT_op
				BYTE 4
				DWORD XOR_op
entriesNumber = ($-caseTable) / entrySize	
			
; ------ S T R I N G S ------
promptMenuMsg	BYTE "Select a boolean operation to be performed: ",0Dh,0Ah
				BYTE "1. x AND y",0Dh,0Ah
				BYTE "2. x OR y",0Dh,0Ah
				BYTE "3. NOT x",0Dh,0Ah
				BYTE "4. x XOR y",0Dh,0Ah
				BYTE "5. Exit Program",0Dh,0Ah,0
promptMenuErr	BYTE "Invalid selection. Try again: ",0

promptOpMsg		BYTE "Enter the integers in hexadecimal format",0Dh,0Ah,0
leftOpMsg		BYTE "x (left operand): ",0
rightOpMsg		BYTE "y (right operand): ",0

resultMsg		BYTE "Result: ",0
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				.CODE
main			PROC	
while01:		call promptMenu
				movzx ecx,al
				mov esi,OFFSET caseTable
for01:			cmp al,[esi]				; Checks cases 1 through 4. If no calls occured, then the user chose to exit program.
				jne endif01
				call NEAR PTR [esi + 1]
				call DisplayResult
				jmp endfor01
endif01:		add esi,entrySize
				loop for01
				jmp endw01					
endfor01:		call Crlf
				jmp while01
endw01:			INVOKE ExitProcess,0			
main			ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
promptMenu		PROC USES edx
;
; Description:	Displays a menu that asks the user to make a selection
;				and returns the choice to the main program.
; Receives:		N/A
; Returns:		AL = the selected operation
; Calls:		WriteString										(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov edx,OFFSET promptMenuMsg
Prompt:			call WriteString
				call ReadInt
if01:			cmp eax,FIRST_CHOICE
				jnge else01
				cmp eax,LAST_CHOICE
				jle endif01
else01:			mov edx,OFFSET promptMenuErr
				jmp Prompt
endif01:		ret
promptMenu		ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
promptOperands	PROC
;
; Description:	Prompts the user for two integers in hexadecimal format.
;				(Just one integer if user opted for the NOT operation)
; Receives:		N/A
; Returns:		eax = left operand
;				edx = right operand
; Calls:		WriteString, ReadHex, Crlf						(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				cmp al,3h				; 3h = NOT_op Case
				pushfd
				mov edx,OFFSET promptOpMsg
				call WriteString
				mov edx,OFFSET leftOpMsg
				call WriteString
				call ReadHex
				popfd
				jz L1
				push eax
				mov edx,OFFSET rightOpMsg
				call WriteString
				call ReadHex
				mov edx,eax
				pop eax
L1:				call Crlf
				ret
promptOperands	ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
DisplayResult	PROC
;
; Description:	Displays the resulted value generated by the boolean operations
;				in hexadecimal format.
; Receives:		EAX = the value to be displayed
; Returns:		N/A
; Calls:		WriteString. WriteHex, Crlf									(Irvine32.lib)
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				mov edx,OFFSET resultMsg
				call WriteString
				call WriteHex
				call Crlf
				ret
DisplayResult	ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
AND_op			PROC USES edx
;
; Description:	Prompts the user for two hexadecimal integers and ANDs them.
; Receives:		N/A
; Returns:		EAX = the resulted value
; Calls:		N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				call promptOperands
				and eax,edx
				ret
AND_op			ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
OR_op			PROC USES edx
; Description:	Prompts the user for two hexadecimal integers and ORs them.
; Receives:		N/A
; Returns:		EAX = the resulted value
; Calls:		N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				call promptOperands
				or eax,edx
				ret
OR_op			ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
NOT_op			PROC
; Description:	Prompts the user for a hexadecimal integers and NOTs it.
; Receives:		N/A
; Returns:		EAX = the resulted value
; Calls:		N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�		
				call promptOperands
				NOT eax
				ret
NOT_op			ENDP

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
XOR_op			PROC USES edx
; Description:	Prompts the user for two hexadecimal integers and XORs them.
; Receives:		N/A
; Returns:		EAX = the resulted value
; Calls:		N/A
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�
				call promptOperands
				xor eax,edx
				ret
XOR_op			ENDP

				END main																														