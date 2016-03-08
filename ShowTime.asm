TITLE Display Local Time					(ShowTime.asm)
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
; Description:	 Calls two MS-Windows functions (SetConsoleCursorPosition
;				 & GetLocalTime).
; Author:		 Marrusian
; Creation Date: 16/08/2014
; Revisions:	 N/A
; Date:			 N/A
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
INCLUDELIB E:\masm32\lib\Irvine32.lib
				.386
				.MODEL flat,stdcall
				.STACK 100h

; --- S T R U C T U R E S ---
COORD			STRUCT
X				WORD ?
Y				WORD ?
COORD			ENDS

SYSTEMTIME		STRUCT
wYear			WORD ?
wMonth			WORD ?
wDayOfWeek		WORD ?
wDay			WORD ?
wHour			WORD ?
wMinute			WORD ?
wSeconds		WORD ?
wMilliseconds	WORD ?
SYSTEMTIME		ENDS

Crlf			PROTO
WriteDec		PROTO
WriteString		PROTO
Gotoxy			PROTO
GetStdHandle	PROTO nStdHandle:DWORD
GetLocalTime	PROTO lpSystemTime:PTR SYSTEMTIME
SetConsoleCursorPosition PROTO hConsoleOutput:DWORD, dwCursorPosition:COORD
ExitProcess		PROTO dwExitCode:DWORD
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.DATA
; --- C O N S T A N T S ---
STD_OUTPUT_HANDLE = -11

; --- V A R I A B L E S ---
sysTime			SYSTEMTIME <>
XYPos			COORD <10,5>
consoleHandle	DWORD ?
colonStr		BYTE ":",0
myValue			DWORD ?  
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
				.CODE
main			PROC
				INVOKE GetStdHandle, STD_OUTPUT_HANDLE
				mov consoleHandle,eax
				INVOKE SetConsoleCursorPosition, consoleHandle, XYPos
				INVOKE GetLocalTime, ADDR sysTime
				mov edx,OFFSET colonStr
				movzx eax,sysTime.wHour
				call WriteDec
				call WriteString
				movzx eax,sysTime.wMinute
				call WriteDec
				call WriteString
				movzx eax,sysTime.wSeconds
				call WriteDec
				call Crlf
				INVOKE ExitProcess,0
main			ENDP

				END main