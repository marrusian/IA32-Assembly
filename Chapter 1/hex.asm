includelib \masm32\lib\msvcrt.lib
                .486
                .MODEL flat,c
                .STACK 100h
printf          PROTO arg1:Ptr Byte, printlist:VARARG
scanf           PROTO arg1:Ptr Byte, inputlist:VARARG
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .DATA

in0fmt          byte "%s",0
msg0fmt         byte 0Ah,"%s",0
msg1fmt         byte 0Ah,"%d",0Ah,0

msg0            byte "Enter a 32-bit hexadecimal integer: ",0

string          byte 8+1 dup(?)
complement      byte   ?
decimal         sdword ?
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .CODE
                start:

main            PROC
                INVOKE printf, ADDR msg0fmt, ADDR msg0
                INVOKE scanf, ADDR in0fmt, ADDR string
                call HTD
                INVOKE printf, ADDR msg1fmt, decimal                        
                ret
main            ENDP

HTD             PROC                        ; Hexadecimal to Decimal
                push eax
                push ecx
                push ebx
                push esi
                
                xor eax,eax
                mov cl,lengthof string
                dec cl
                sal cl,4
                sub cl,4           
                xor ebx,ebx
                lea esi,string

while01:        test cl,80h
                jnz endwhile01
                mov al,[esi]
                
 if01:          test al,01000000b           ; if al=>A
                jz endif01
 then01:        add eax,9               
 endif01:       and eax,00001111b           ; Convert ASCII Digit to Binary Integer

                sal eax,cl
                add ebx,eax
                sub cl,4
                inc esi
                jmp while01
endwhile01:     add decimal,ebx

                pop esi
                pop ebx
                pop ecx
                pop eax
                ret
HTD             ENDP
                end start