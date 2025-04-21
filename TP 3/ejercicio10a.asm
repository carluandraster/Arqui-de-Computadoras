;DOCUMENTACIÓN
; [0]: cantidad de elementos del primer vector (N)
; [4]: cantidad de elementos del segundo vector (N-1)
; [8]: contendrá la dirección de memoria del segundo vector
; [12]: primer vector
; EBX: cantidad de elementos que debería tener el segundo vector
; EEX, EFX: variables de control para ciclos for (i, j)

; Ingreso los 2 vectores
        MOV [0], 0; [0] es la cantidad de elementos del vector
        MOV EDX, DS
        ADD EDX, 12; 12 será la dirección de memoria base del primer vector
; Ingresar primer vector
OTRO:   MOV CH, 4
        MOV CL, 1
        MOV AL, 1
        SYS 1
        CMP [EDX], 0
        JN SIGUE
        ADD EDX, 4
        ADD [0], 1
        JNN OTRO
SIGUE:  MOV [8], EDX; [8] contendrá la dirección de memoria base del segundo vector
        MOV [4], 0; [4] contará los elementos del otro vector
        MOV EBX, [0]
        SUB EBX, 1
; Ingresar segundo vector
OTRO2:  MOV CH, 4
        MOV CL, 1
        MOV AL, 1
        SYS 1
        ADD [4], 1
        ADD EDX, 4
        CMP [4], EBX
        JN OTRO2
; Ahora veo qué número de v1 no está en v2
        ; for (i:=0, i<N, i++)
        MOV EEX, 0
OTRO3:  CMP EEX, [0]
        JZ FIN
        ; Apunto EBX a v1[i] donde v1[i] es un entero
        ; EBX := DS + 12 + 4*EEX= [12 + 4*EEX] = [&v1 + 4i] = &v1[i]
                MOV EBX, DS
                ADD EBX, 12; EBX ahora apunta a una celda del primer vector
                MOV AC, 4
                MUL AC, EEX
                ADD EBX, AC
        ; for (j:=0, j<N-1, j++)
        MOV EFX, 0; EFX es variable de control para otro ciclo for (j:=0)
OTRO4:          CMP EFX, [4]
                JZ SIGUE4
                ; Apunto EAX a v2[j]
                ; EAX := DS + [8] + 4*EFX = [[8] + 4*EFX] = [&v2 + 4j] = &v2[j]
                        MOV EAX, DS
                        ADD EAX, [8]; EAX ahora apunta a una celda del segundo vector
                        MOV AC, 4
                        MUL AC, EFX
                        ADD EAX, AC
                CMP [EAX], [EBX]
                JZ SIGUE4; Si existe algun i,j tal que v1[i] = v2[j], sigo recorriendo v1
FINCICLO4:      ADD EFX, 1
                JMP OTRO4
SIGUE4: CMP EFX, [4]
        JZ FIN
FINCICLO3: ADD EEX, 1
        JMP OTRO3
        ; EDX := DS + 12 + 4*EEX = &[&v1 + 4i] = &v1[i]
FIN:            MOV EDX, DS
                ADD EDX, 12
                MUL EEX, 4
                ADD EDX, EEX
        MOV CH, 4
        MOV CL, 1
        MOV AL, 1
        SYS 2
        STOP