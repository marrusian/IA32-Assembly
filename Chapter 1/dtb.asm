includelib \masm32\lib\msvcrt.lib
                .486
                .MODEL flat,c
                .STACK 100h
printf          PROTO arg1:Ptr Byte, printlist:VARARG
scanf           PROTO arg1:Ptr Byte, inputlist:VARARG
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .DATA

in0fmt          byte "%d",0
msg0fmt         byte 0Ah,"%s",0
msg1fmt         byte 0Ah,"%s",0Ah,0

msg0            byte "Enter an integer: ",0

string          byte 32 dup(?)
integer         sdword ?
complement      byte ?
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .CODE
                start:

main            PROC
                INVOKE printf, ADDR msg0fmt, ADDR msg0
                INVOKE scanf, ADDR in0fmt, ADDR integer
                call DTB
                INVOKE printf, ADDR msg1fmt, ADDR string      
                
                ret
main            ENDP

DTB             PROC
                push eax
                push ebx
                push ecx
                push edi
                push esi
                
                xor eax,eax
                xor ecx,ecx
                lea edi,string
              
if01:           test integer,0FFFFFFFFh
                jnz else01
then01:         mov al,'0'
                mov [edi],al     
                jmp endif01
else01:         nop
 if02:          test integer+3,80h
                jnz else02
 then02:        mov complement,00110000b
                jmp endif02
 else02:        mov complement,00110001b
                inc integer
                neg integer               
 endif02:       nop               
endif01:        nop

while01:        test integer,0FFFFFFFFh
                je endwhile01
                mov eax,integer
                and eax,00000001b
                xor al,complement
                mov [edi],al      
                sar integer,1
                inc cl   
                inc edi
                jmp while01
endwhile01:     nop 

if03:           test complement,00000001b
                jz endif03
then03:         nop
                mov ebx,lengthof string
                sub ebx,ecx
                mov al,'1'
 while02:       test ebx,0FFFFFFFFh
                je endwhile02
                mov [edi],al
                inc edi
                inc cl
                dec ebx
                jmp while02
 endwhile02:    nop
endif03:        nop

                dec edi
                sar cl,1
                lea esi,string
if04:           test cl,0FFh
                jz endif04
then04:         nop
 for01:         mov al,[esi]
                xchg al,[edi]
                mov [esi],al
                inc esi
                dec edi
                loop for01
 endfor01:      nop
endif04:        nop
                
                pop esi
                pop edi
                pop ecx
                pop ebx
                pop eax

                ret
DTB             ENDP

                end start