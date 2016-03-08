TITLE Exchanging Integers				(ExInt_Main.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Creates an array of randomly ordered integers and 
;				 exchanges each consecutive pair of integers in the arrray.
; Author:		 Marrusian
; Creation Date: 12/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB	D:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h
; --- E X T E R N A L S ---
EXTERN			FillArray@0:PROC
EXTERN			Swap@0:PROC

; --- R E D E F I N I T I O N S ---
FillArray		EQU FillArray@0
Swap			EQU Swap@0

; --- L I B - P R O C E D U R E S ---
Randomize		PROTO
DumpMem			PROTO
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; --- S Y M B O L S ---
ARRAY_SIZE = 50
				.DATA?
vector			BYTE ARRAY_SIZE DUP(?)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				call Randomize
				; FillArray(<array>, LENGTHOF <array>, TYPE <array>)
				push TYPE vector
				push LENGTHOF vector
				push OFFSET vector
				call FillArray
				mov ecx,LENGTHOF vector
				sar ecx,1
				mov esi,OFFSET vector
				; Swap(ADDR x, ADDR y, TYPE x/y)
for01:			push TYPE vector
				push esi
				add esi,TYPE vector
				push esi
				call Swap
				add esi,TYPE vector
				loop for01	
				INVOKE ExitProcess,0
main			ENDP

				END main
