        MOV [0], 0; [0] contará los n números ingresados
        MOV EBX, 0; EBX será la sumatoria de los primeros números ingresados
        MOV EFX, 0; EFX será la sumatoria de los segundos números
        MOV EDX, DS; EDX apuntará al número ingresado
        ADD EDX, 2; En [2] se guardará el número
OTRO:   MOV AL, 1
        MOV CL, 1
        MOV CH, 4
        SYS 1
        CMP [2], 0
        JN SIGUE
        ADD EBX, [2]
        ADD [0], 1
        JMP OTRO
SIGUE:  MOV [1], [0]
        SUBS [1], 1
        MOV AC, 0; AC será mi variable de contro para el siguiente ciclo for (i:=0)
OTRO2:  CMP AC, [1]
        JZ SIGUE2
        MOV AL, 1
        MOV CL, 1
        MOV CH, 4
        SYS 1
        ADD EFX, [2]
        JMP OTRO2
SIGUE2: MOV [2], EBX
        SUBS [2], EFX
        MOV AL, 1
        MOV CL, 1
        MOV CH, 4
        SYS 2
        STOP