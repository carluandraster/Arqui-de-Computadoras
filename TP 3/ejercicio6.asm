        MOV EDX,DS
        MOV CH,4
        MOV CL,1
        MOV AL,0x01
        SYS 1
        MOV EBX,[EDX]; EBX: dividendo
INGR:   SYS 1
        CMP [EDX],0
        JZ INGR; No se puede dividir por 0
        MOV ECX,[EDX]; ECX: divisor
        MOV EAX, 0; EAX: cociente
        MOV AC, EBX; AC: resto
        CMP EBX,0
        JN COND2
        JZ FIN
COND1:  CMP ECX, 0
        JP CASO1
        JN CASO2
COND2:  CMP ECX, 0
        JP CASO3
        JN CASO4
CASO1:  CMP AC, ECX
        JN FIN
        ADD EAX, 1
        SUB AC, ECX
        JMP CASO1
CASO2:  MUL ECX, -1
OTRO2:  CMP AC, ECX
        JN FIN
        SUB EAX, 1
        SUB AC, ECX
        JMP OTRO2
CASO3:  CMP AC, 0
        JNN FIN
        SUB EAX, 1
        ADD AC, ECX
        JMP CASO3
CASO4:  MUL AC,-1
        MUL ECX, -1
        JMP CASO1
FIN:    MOV [0], EAX; Cociente
        MOV [4], AC; Resto
        MOV EDX, DS
        MOV CH, 4
        MOV CL, 1
        MOV AL, 0x01
        SYS 2
        ADD EDX, 4
        SYS 2
        STOP