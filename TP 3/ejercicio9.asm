        MOV EDX, DS
        ADD EDX, 3
        MOV CH, 4
        MOV CL, 1
        MOV AL, 0x01
        SYS 1
OTRO:   MOV [1], 0; Contador de 1s
        MOV EDX, DS
        MOV CH, 4
        MOV CL, 1
        MOV AL, 0x01
        SYS 1
        CMP [EDX], 0
        JN FIN
ITER:   CMP [EDX], 0
        JZ ESCRIB
        MOV EFX, [EDX]
        AND EFX, [3]
        ADD [1], EFX
        SHR [EDX], 1
        JMP ITER
ESCRIB: MOV EDX, DS
        ADD EDX, 1
        MOV CH, 4
        MOV CL, 1
        MOV AL, 0x01
        SYS 2
        JMP OTRO
:FIN    STOP