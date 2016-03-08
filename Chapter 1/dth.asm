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

string          byte 8 dup(?)
integer         sdword ?
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .CODE
                start:

main            PROC
                INVOKE printf, ADDR msg0fmt, ADDR msg0
                INVOKE scanf, ADDR in0fmt, ADDR integer
                call DTH
                INVOKE printf, ADDR msg1fmt, ADDR string
                
                ret
main            ENDP

DTH             PROC
                push eax
                push ebx
                push ecx
                push esi
                push edi

                xor eax,eax
                xor ecx,ecx
                lea edi,string

if01:           cmp integer,0
                jle else01
then01:         nop
 while01:       cmp integer,0
                je endwhile01
                mov eax,integer
                and eax,0Fh             ; Eax (mod 16)
  if001:        cmp al,9                ; Convert Binary Integer To ASCII Character
                jg else001
  then001:      xor al,00110000b
                jmp endif001
  else001:      sub al,9
                xor al,01000000b
  endif001:     mov [edi],al

                sar integer,4
                inc cl
                inc edi
                jmp while01
 endwhile01:    nop
                jmp endif01
else01:         nop
 if02:          cmp integer,0
                je else02
 then02:        inc integer
                neg integer
  while02:      cmp integer,0
                je endwhile02
                mov eax,integer
                and eax,0Fh             ; Eax (mod 16)
                sub al,15
                neg al
   if002:       cmp al,9                ; Convert Binary Integer To ASCII Character
                jg else002
   then002:     xor al,00110000b
                jmp endif002
   else002:     sub al,9
                xor al,01000000b
   endif002:    mov [edi],al             

                sar integer,4
                inc cl
                inc edi               
                jmp while02
  endwhile02:   nop
                mov al,'F'
                mov ebx,8
                sub ebx,ecx
  while03:      cmp ebx,0
                je endwhile03     
                mov [edi],al
                inc edi
                inc cl
                dec ebx
                jmp while03
  endwhile03:   nop
                jmp endif02
 else02:        mov al,'0'
                mov [edi],al
 endif02:       nop
endif01:        nop

                dec edi
                sar cl,1
                lea esi,string
if03:           test cl,0FFh
                jz endif03
then03:         nop
 for01:         mov al,[esi]
                xchg al,[edi]
                mov [esi],al
                inc esi
                dec edi
                loop for01
 endfor01:      nop
endif03:        nop

                pop edi
                pop esi
                pop ecx
                pop ebx
                pop eax
                ret
DTH             ENDP

                end start