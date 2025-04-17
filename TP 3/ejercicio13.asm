; DOCUMENTACIÓN
; [0]: ancho y alto de la matriz
; [4]: matriz
; EAX: guarda [0]-1
; AC, EBX: variables de control para los ciclos
; EEX, EFX: punteros a elementos de la matriz
; ECX: variable auxiliar para hacer cuentas

; Ingresar la matriz

        ; Ingresar N
        MOV EDX, DS
        MOV CL, 1
        MOV CH, 4
        MOV AL, 1
        SYS 1

        ; Ahora sí se ingresan los elementos de la matriz
        ; for(i:=0, i<N, i++)
        MOV EBX, 0
OTRO:   CMP EBX, [0]
        JZ SIGUE
        ; for(j:=0, j<N, j++)
        MOV AC, 0
OTRO2:      CMP AC, [0]
            JZ SIGUE2
            ADD EDX, 4
            MOV CL, 1
            MOV CH, 4
            MOV AL, 1
            SYS 1
            ADD AC, 1
            JMP OTRO2
SIGUE2: ADD EBX, 1
        JMP OTRO

; Validar que la matriz sea simétrica respecto de su diagonal principal
SIGUE:  MOV EAX, [0]
        SUBS EAX, 1
        MOV AC, 0
        MOV EBX, 1
        ; Verificar si i<N-1
OTRO3:  CMP AC, EAX
        JZ VERDADERO
OTRO4:  CMP EBX, [0]
        JZ ACTUALIZAR
        ; Apuntar EEX a mat[i][j]
        MOV EEX, DS
        ADD EEX, 4
        MOV ECX, 4
        MUL ECX, AC
        MUL ECX, [0]
        ADD EEX, ECX
        MOV ECX, 4
        MUL ECX, EBX
        ADD EEX, ECX
        ; Apuntar EFX a mat[j][i]
        MOV EFX, DS
        ADD EFX, 4
        MOV ECX, 4
        MUL ECX, EBX
        MUL ECX, [0]
        ADD EFX, ECX
        MOV ECX, 4
        MUL ECX, AC
        ADD EFX, ECX
            CMP [EEX], [EFX]
            JNZ FALSO
            ADD EBX, 1
            JMP OTRO4
ACTUALIZAR: ADD AC, 1
        MOV EBX, AC
        ADD EBX, 1
        JMP OTRO3
VERDADERO: ADD EDX, 4
        MOV [EDX], 1
        MOV CL, 1
        MOV CH, 4
        MOV AL, 1
        SYS 2
        JMP FIN
FALSO:  ADD EDX, 4
        MOV [EDX], 0
        MOV CL, 1
        MOV CH, 4
        MOV AL, 1
        SYS 2
        JMP FIN
FIN:    STOP