includelib E:\masm32\lib\msvcrt.lib
                .386
                .MODEL flat,c
                .STACK 100h         
printf          PROTO arg1:Ptr Byte, printlist:VARARG
scanf           PROTO arg1:Ptr Byte, inputlist:VARARG      
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .DATA

in0fmt          byte "%s",0
msg0fmt         byte 0Ah,"%s",0
msg1fmt         byte 0Ah,"%d",0Ah,0

msg0            byte "Enter a 16-bit binary integer: ",0

string          byte 16+1 dup(?)
complement      byte  ?
decimal         sword ?
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .CODE
                start:

SaveRegs        MACRO
                push eax
                push ebx
                push ecx
                push esi
                ENDM

LoadRegs        MACRO
                pop esi
                pop ecx
                pop ebx
                pop eax
                ENDM
                
main            PROC
                INVOKE printf, ADDR msg0fmt, ADDR msg0
                INVOKE scanf, ADDR in0fmt, ADDR string
                call BTD
                INVOKE printf, ADDR msg1fmt, decimal     
                ret
main            ENDP

BTD             PROC                       ; Binary to Decimal
                SaveRegs
            
                mov cl,lengthof string
                sub cl,2
                xor ax,ax
                xor bx,bx
                lea esi,string
  
while01:        test cl,80h                 ; if cl != -1
                jnz endwhile01
                mov al,[esi]
 if01:          test al,00000001b
                jz endif01
 then01:        xor al,00110000b            ; Convert from ASCII Character to Binary Integer
                sal ax,cl
                add bx,ax
                xor ah,ah  
 endif01:       nop                      
                dec cl      
                inc esi                    
                jmp while01
endwhile01:     mov decimal,bx

                LoadRegs
                ret
BTD             ENDP

                END start							