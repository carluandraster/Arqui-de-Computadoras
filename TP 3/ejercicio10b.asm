; DOCUMENTACIÓN
; [0]:  contador de los n números ingresados
; EBX: sumatoria de los primeros números ingresados
; EFX: sumatoria de los segundos números
; EDX apuntará al número ingresado
; En [4] se guardará el número
; [8]: n-1
; AC será mi variable de contro para el siguiente ciclo for (i:=0)

        MOV [0], 0
        MOV EBX, 0
        MOV EFX, 0
        MOV EDX, DS
        ADD EDX, 4
OTRO:   MOV AL, 1
        MOV CL, 1
        MOV CH, 4
        SYS 1
        CMP [4], 0
        JN SIGUE
        ADD EBX, [4]
        ADD [0], 1
        JMP OTRO
SIGUE:  MOV [8], [0]
        SUB [8], 1
        ; for(i:= 0, i<n-1, i++)
        MOV AC, 0
OTRO2:  CMP AC, [8]
        JZ SIGUE2
        MOV AL, 1
        MOV CL, 1
        MOV CH, 4
        SYS 1
        ADD EFX, [4]
        ADD AC, 1
        JMP OTRO2
SIGUE2: MOV [4], EBX
        SUB [4], EFX
        MOV AL, 1
        MOV CL, 1
        MOV CH, 4
        SYS 2
        STOP