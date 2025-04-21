        MOV EFX, 1; Nro de iteración
ENTR:   MOV EDX, DS
        MOV CH, 4
        MOV CL, 1
        MOV AL 0x01
        SYS 1
        CMP [EDX], 0
        JNP ENTR; No se admite ni 0 ni números negativos
ITER:   MOV AC, [EDX]
        ADD EFX, 1
        CMP EFX, [EDX]
        JNN TRUE
        JMP RESTO
DESP:   CMP AC, 0
        JZ FALSE
        JMP ITER
RESTO:  SUB AC, EFX; Hago el resto de dividir [EDX] por EFX
        CMP AC, EFX
        JN DESP
        JMP RESTO
TRUE:   MOV [4], 1
        JMP FIN
FALSE:  MOV [4], 0
        JMP FIN
FIN:    MOV EDX, DS
        ADD EDX, 4
        MOV CH, 4
        MOV CL, 1
        MOV AL 0x01
        SYS 2
        STOP