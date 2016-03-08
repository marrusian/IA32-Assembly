TITLE Test Score Evaluation(2)			(TSE2.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:   Asks the user to enter an integer, from standard input,
;				 between 0 and 100 and displays the appropriate letter grade.
; Author:		 Marrusian
; Creation Date: 06/04/2018
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
includelib	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
Crlf			PROTO
Delay			PROTO
ReadInt			PROTO
ReadKey			PROTO
WriteChar		PROTO
WriteDec		PROTO
WriteString		PROTO				
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
ESC_KEY	= 1Bh
DELAY_TIME = 750
promptIntMsg	BYTE "Enter an integer between 0 and 100: ",0
promptIntErr	BYTE "Invalid integer. Try again: ",0

gradeMsg		BYTE "Grade: ",0
testScoreMsg	BYTE "Number of test scores performed: ",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
; Calls: PromptInteger, DisplayGrade
				mov ecx,0
L1:				push ecx
				call PromptInteger
				call DisplayGrade
				mov eax,DELAY_TIME
				call Delay
				call ReadKey
				cmp al,ESC_KEY
				je L2
				pop ecx
				inc ecx
				jmp L1
L2:				call Quit
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
PromptInteger	PROC USES edx
;
; Description:	Prompts the user to enter an integer between 0 and 100.
; Receives:		N/A
; Returns:		EAX = the integer
; Calls:		WriteString, ReadInt							(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET promptIntMsg
Prompt:			call WriteString
				call ReadInt
if01:			cmp eax,0
				jl then01 
				cmp eax,100
				jle endif01
then01:			mov edx,OFFSET promptIntErr
				jmp Prompt	
endif01:		ret
PromptInteger	ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
DisplayGrade	PROC USES eax edx
;
; Description:	Displays the appropiate letter grade for an integer
;				between 0 and 100.
; Receives:		EAX = the integer
; Returns:		N/A
; Calls:		WriteChar, WriteString, Crlf					(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET gradeMsg
				call WriteString
switch:			cmp eax,60
				jl  case_F
				cmp eax,70
				jl  case_D
				cmp eax,80
				jl  case_C
				cmp eax,90
				jl  case_B
				jmp case_A
case_F:			mov al,'F'
				jmp endswitch
case_D:			mov al,'D'
				jmp endswitch
case_C:			mov al,'C'
				jmp endswitch
case_B:			mov al,'B'
				jmp endswitch
case_A:			mov al,'A'
				jmp endswitch													
endswitch:		call WriteChar
				call Crlf			
				ret
DisplayGrade	ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Quit			PROC
;
; Description:  Displays the total number of test scores performed and
;			    quits the program.
; Receives:		N/A
; Returns:		N/A
; Calls:		WriteString, WriteDec, Crlf						(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET testScoreMsg
				call WriteString
				mov eax,ecx
				call WriteDec
				call Crlf
				INVOKE ExitProcess,0
Quit			ENDP

				END main																				