        MOV EFX,0 ;Número binario
OTRO:   MOV EDX, DS
        MOV CH, 4
        MOV CL,1
        MOV AL,0x01
        SYS 1
        CMP [EDX],0
        JN FIN
        CMP [EDX],1
        JP FIN
        SHL EFX,1
        ADD EFX,[EDX]
        JMP OTRO
FIN:    MOV [4],EFX
        MOV EDX, DS
        ADD EDX,4
        MOV CH,4
        MOV CL,1
        MOV AL, 0x01
        SYS 2
        STOP