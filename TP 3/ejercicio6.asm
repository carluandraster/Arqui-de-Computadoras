        MOV EDX,DS
        MOV CH,4
        MOV CL,1
        MOV AL,0x01
        SYS 1
        MOV EBX,[EDX]; EBX: dividendo
:INGR   SYS 1
        CMP [EDX],0
        JZ INGR; No se puede dividir por 0
        MOV ECX,[EDX]; ECX: divisor
        MOV EAX, 0; EAX: cociente
        MOV AC, EBX; AC: resto
        CMP EBX,0
        MOV EFX, CC
        CMP ECX, 0
        XOR CC, EFX
        JP POS
        JN NEG