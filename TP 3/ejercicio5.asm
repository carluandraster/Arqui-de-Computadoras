        MOV [1],1; Acá se guardará el factorial
        MOV EFX,2; Número de iteración
:INGR   MOV EDX,DS
        MOV CH,4
        MOV CL,1
        MOV AL, 0x01
        SYS 1
        CMP [EDX],0
        JN INGR; No se admiten números negativos
        JZ FIN
        CMP [EDX],1
        JZ FIN
:FAC    MOV EBX,[1]
        MOV ECX,EFX
        JMP MULT
:DESP   MOV [1],EAX
        ADD EFX,1
        CMP EFX,[EDX]
        JNP FAC
        JP FIN
:MULT   MOV EAX, 0; EBX*ECX = EAX
:POS    ADD EAX,EBX
        SUB ECX,1
        CMP ECX,0
        JZ DESP
        JP POS
:FIN    MOV EDX,DS
        ADD EDX,1
        MOV CH,4
        MOV CL,1
        MOV AL,0x01
        SYS 2
        STOP