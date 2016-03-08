                .386
                .MODEL flat,c
                .STACK 100h              
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .DATA
var1            BYTE 0FFh
var2            SBYTE 80h
var3            WORD 0FFFFh
var4            SWORD 8000h
var5            DWORD 0FFFFFFFFh
var6            SDWORD 80000000h
var7            QWORD 1234567812345678h
var8            TBYTE ?
var9            REAL4 2.0
var10           REAL8 2.5E200
var11           REAL10 3.2E3123
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
                .CODE
                start:

main            PROC

                            
                ret
main            ENDP

                END start                