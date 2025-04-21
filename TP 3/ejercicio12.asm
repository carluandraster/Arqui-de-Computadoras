; DOCUMENTACIÓN
; [0]: cantidad de filas N de la matriz
; [4]: cantidad de columnas M de la matriz
; [8]: matriz
; [8 + 4*[0]*[4]]: vector de mínimos
; AC, EFX: variables de control para los ciclos for
; EAX: registro donde se guardará provisoriamente el mínimo de una columna

; Ingresar matriz
        MOV EDX, DS
        MOV CH, 4
        MOV CL, 1
        MOV AL, 1
        SYS 1
        ADD EDX, 4
        SYS 1
        ; for(i:=0, i<N, i++)
        MOV AC, 0
OTRO:   CMP AC, [0]
        JZ SIGUE
            ; for(j:=0, j<M, j++)
            MOV EFX, 0
OTRO2:      CMP EFX, [4]
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
SIGUE:  ADD EDX, 4
        ; for(j:=0, j<M, j++)
        MOV EFX, 0
OTRO3:  CMP EFX, [4]
        JZ FIN
            ; min := mat[0][j] (EBX := DS + 8 + 4*EFX)
                MOV EBX, 4
                MUL EBX,EFX
                ADD EBX, 8
                ADD EBX, DS
            MOV EAX, [EBX]
            ; for(i:=1, i<N, i++)
            MOV AC, 1
OTRO4:      CMP AC, [0]
            JZ SIGUE4
                ; EBX += 4*[4]
                        MOV ECX, 4
                        MUL ECX, [4]
                        ADD EBX, ECX
                CMP [EBX], EAX
                JNN FINCICLO4
                MOV EAX, [EBX]
FINCICLO4:  ADD AC, 1
            JMP OTRO4
        ; ECX = 4*EFX + EDX = &v + 4j = v[j]
SIGUE4:         MOV ECX, 4
                MUL ECX, EFX
                ADD ECX, EDX
        MOV [ECX], EAX
        ADD EFX, 1
        JMP OTRO3
FIN:    MOV CH, 4
        MOV CL, [4]
        MOV AL, 1
        SYS 2
        STOP