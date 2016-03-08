includelib \masm32\lib\msvcrt.lib
                .486
                .MODEL flat,c
                .STACK 100h
printf          PROTO arg1:Ptr Byte, printlist:VARARG
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .DATA

in0fmt          byte "%s",0
msg0fmt         byte 0Ah,"%s",0Ah,0
msg1fmt         byte 0Ah,"%d",0Ah,0

msg0            byte "Enter a 16-bit binary integer: ",0

string          byte   ?
complement      byte   ?
decimal         sdword ?
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .CODE
                start:

main            PROC
                mov edi,offset string
                mov al,00110000b
                mov [edi],al
                INVOKE printf, ADDR msg0fmt,ADDR string
                
                ret
main            ENDP

                end start