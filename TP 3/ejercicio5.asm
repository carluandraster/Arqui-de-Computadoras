        MOV [0],1; Acá se guardará el factorial
        MOV EFX,2; Número de iteración
INGR:   MOV EDX,DS
        ADD EDX, 4
        MOV CH,4
        MOV CL,1
        MOV AL, 0x01
        SYS 1
        CMP [EDX],0
        JN INGR; No se admiten números negativos
        JZ FIN
        CMP [EDX],1
        JZ FIN
FAC:    MOV EBX,[0]
        MOV ECX,EFX
        JMP MULT
DESP:   MOV [0],EAX
        ADD EFX,1
        CMP EFX,[EDX]
        JNP FAC
        JP FIN
MULT:   MOV EAX, 0; EBX*ECX = EAX
POS:    ADD EAX,EBX
        SUB ECX,1
        CMP ECX,0
        JZ DESP
        JP POS
FIN:    MOV EDX,DS
        MOV CH,4
        MOV CL,1
        MOV AL,0x01
        SYS 2
        STOP