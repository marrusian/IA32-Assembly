TITLE College Registration			(CollegeReg.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:   Prompts the user for the grade average and credits value
;				 of a student and evaluates the data for college registration.
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
ReadInt			PROTO
WriteString		PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
; ------- C O N S T A N T S -------
TRUE = 1
FALSE = 0

MIN_CREDITS = 1
MAX_CREDITS = 30
MIN_GRADE = 0
MAX_GRADE = 400

; ------- V A R I A B L E S -------
gradeAverage	WORD ?
credits			BYTE ?

; ------- S T R I N G S -------
promptGradeMsg	BYTE "Enter your grade average: ",0
promptGradeErr	BYTE "Invalid grade average. Try again: ",0
promptCreditMsg	BYTE "Enter your number of credits: ",0
promptCreditErr	BYTE "Invalid credits value. Try again: ",0

acceptMsg		BYTE "The student can register",0
denyMsg			BYTE "The student cannot register",0
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
L1:				call PromptInfo
				test bx,0FFFFh				; if gradeAverage == 0, exit loop
				jz L2
				mov gradeAverage,bx
				mov credits,al
				mov ax,bx
				mov bl,credits
				call Evaluate
				jmp L1
L2:				INVOKE ExitProcess,0
main			ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
PromptInfo		PROC USES edx
;
; Description:	Prompts the user for the grade average and credits value.
;				Performs a range-checking on both data.
; Receives:		N/A
; Returns:		BX = the grade average
;				AL = the credit value
; Calls:		ReadInt, WriteString							(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov edx,OFFSET promptGradeMsg
PromptG:		call WriteString
				call ReadInt
if01:			cmp eax,MIN_GRADE
				jnge then01
				cmp eax,MAX_GRADE
				jle endif01
then01:			mov edx,OFFSET promptGradeErr
				jmp PromptG
endif01:		mov bx,ax
				mov edx,OFFSET promptCreditMsg
PromptC:		call WriteString
				call ReadInt
if02:			cmp eax,MIN_CREDITS
				jnge then02
				cmp eax,MAX_CREDITS
				jle endif02
then02:			mov edx,OFFSET promptCreditErr
				jmp PromptC
endif02:		ret
PromptInfo		ENDP

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Evaluate		PROC USES edx
				local OkToRegister:BYTE
;
; Decription:	Performs a college registration evaluation based on the
;			    student's grade average and credits value.
; Receives:		AX = the grade average
;				BL = the credits value				
; Returns:		ZF = 0, the student can't register
;				ZF = 1, the student can register
; Calls:		WriteString, Crlf								(Irvine32.lib)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				mov OkToRegister,FALSE
if01:			cmp ax,WORD PTR 350
				jle elseif02
				mov OkToRegister,TRUE
				jmp endif01
elseif02:		cmp ax,WORD PTR 250
				jng elseif03
				cmp bl,BYTE PTR 16
				jnle elseif03
				mov OkToRegister,TRUE
				jmp endif01
 elseif03:		cmp bl,BYTE PTR 12
				jnle endif01
				mov OkToRegister,TRUE
endif01:
if02:			test OkToRegister,0FFh
				jz else02
				mov edx,OFFSET acceptMsg
				jmp endif02
else02:			mov edx,OFFSET denyMsg
endif02:		call WriteString
				call Crlf	
				call Crlf			
				ret
Evaluate    	ENDP
				END main	