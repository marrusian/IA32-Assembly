TITLE Nonrecursive Factorial				(ItFactorial_Main.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Interactively tests a nonrecursive factorial procedure.
; Author:		 Marrusian
; Creation Date: 12/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.386
				.MODEL flat,stdcall
				.STACK 100h
; --- E X T E R N A L S ---
EXTERN			PromptFactorial@0:PROC
EXTERN			Factorial@0:PROC
EXTERN			DisplayFacto@0:PROC
EXTERN			FactorialOF@0:PROC

; --- R E D E F I N I T I O N S ---
PromptFactorial	EQU	PromptFactorial@0
Factorial		EQU Factorial@0
DisplayFacto	EQU DisplayFacto@0
FactorialOF		EQU FactorialOF@0

; --- L I B - P R O C E D U R E S ---
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				call PromptFactorial
while01:		cmp eax,-1
				je endw01
if01:			cmp eax,12
				ja else01
				push eax
				call Factorial
				call DisplayFacto
				jmp endif01
else01:			call FactorialOF
endif01:		call PromptFactorial
				jmp while01
endw01:			INVOKE ExitProcess,0
main			ENDP

				END main