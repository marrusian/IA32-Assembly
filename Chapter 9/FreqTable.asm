TITLE Frequency Table						(FreqTable.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Constructs and tests a character frequency table.
; Author:		 Marrusian
; Creation Date: 14/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
WriteDec		PROTO
DumpMem			PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
target			BYTE "AAEBDCFBBC",0
freqTable		DWORD 256 DUP(0)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				push OFFSET freqTable
				push OFFSET target
				call Get_frequencies
				mov ebx,TYPE DWORD
				mov ecx,LENGTHOF freqTable
				mov esi,OFFSET freqTable
				call DumpMem
				mov eax,freqTable['A'*TYPE DWORD]
				call WriteDec
				call Crlf
				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Get_frequencies	PROC
;
; Description:	Calculates the frequencies of the characters in a string.
; Receives:		str1:PTR BYTE		=	pointer to the string
;			tableF:PTR DWORD	=	pointer to array of 256 DWORDs initialized to 0
;			(every array position is indexed by its corresponding ASCII code)
; Returns:		N/A
; Format:		Get_frequencies(ADDR str1, ADDR tableF)
; Calls:		N/A
; Symbols:
				tableF		EQU	DWORD PTR [ebp + 12]
				str1		EQU DWORD PTR [ebp + 8]
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				enter 0,0
				push esi
				push edi
				push ebx
				push eax
				mov esi,tableF
				mov edi,str1
				xor eax,eax
while01:		scasb
				jz endw01
				movzx ebx,BYTE PTR [edi-1]
				inc DWORD PTR [esi+ebx*TYPE DWORD]
				jmp while01
endw01:			pop eax
				pop ebx
				pop edi
				pop esi
				leave
				ret 8
Get_frequencies	ENDP

				END main