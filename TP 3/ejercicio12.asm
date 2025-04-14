; Ingresar matriz
        MOV EDX, DS
        MOV CH, 1
        MOV CL, 1
        MOV AL, 1
        SYS 1
        ADD EDX, 1
        SYS 1
        ; for(i:=0, i<N, i++)
        MOV AC, 0
OTRO:   CMP AC, [0]
        JZ SIGUE
            ; for(j:=0, j<M, j++)
            MOV EFX, 0
OTRO2:      CMP EFX, [1]
            JZ SIGUE2
            ADD EDX, 4
            MOV CH, 4
            MOV CL, 1
            MOV AL, 1
            SYS 1
            ADD EFX,1
            JMP OTRO2
SIGUE2: ADD AC,1
        JMP OTRO
; Hacer vector de mínimos
        ; for(j:=0, j<M, j++)
SIGUE:  MOV EFX, 0
OTRO3:  CMP EFX, [1]
        JZ FIN
            ; min := mat[0][j]
            MOV EBX, 4
            MUL EBX,EFX
            ADD EBX, 2
            ADD EBX, DS
            MOV EAX, [EBX]
            ; for(i:=1, i<N, i++)
            MOV AC, 1
OTRO4:      CMP AC, [0]
            JZ SIGUE4
                MOV ECX, 4
                MUL ECX, [1]
                ADD EBX, ECX
                CMP [EBX], EAX
                JNN FINCICLO4
                MOV EAX, [EBX]
FINCICLO4:  ADD AC, 1
            JMP OTRO4
SIGUE4: MOV ECX, 4
        MUL ECX, EFX
        ADD ECX, EDX
        MOV [ECX], EAX
        JMP OTRO3
FIN:    MOV CH, 4
        MOV CL, [1]
        MOV AL, 1
        SYS 1
        STOP