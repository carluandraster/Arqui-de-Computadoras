; DOCUMENTACIÓN
; [0]: cantidad de elementos del vector
; [1, 2, 3, 4]: máximo del vector
; [5]: cantidad de apariciones
: [6]: base del vector 

; Ingresar el vector
        ; [0] = N
        MOV EDX, DS; En [0] voy a guardar la cantidad de elementos del vector
        MOV CL, 1
        MOV CH, 1
        MOV AL, 1
        SYS 1
        ADD EDX, 6; El vector se encontrará a partir de la dirección 6 de memoria
        ; for(i:=0, i<N, i++)
        MOV AC, 0
OTRO:   CMP AC, [0]
        JZ SIGUE
        MOV CL, 1
        MOV CH, 4
        MOV AL, 1
        SYS 1
        ADD EDX, 4
        JMP OTRO
; Hallar el máximo y su cantidad de apariciones
SIGUE:  MOV EBX, [6]; EBX será el máximo del vector (max:=v[0])
        MOV [5], 1; [5] será el contador de apariciones del máximo (ap:=1)
        ; for(i:=1,i<N,i++)
        MOV AC,1; A AC lo vuelvo a usar como variable de control (i:=1)
OTRO2:  CMP AC, [0]
        JZ SIGUE2
        MOV EAX, 4; EAX guarda V[i]
        MUL EAX, AC
        ADD EAX, 6
        MOV EAX, [EAX]
        CMP EAX, EBX
        JNP ELSE
        MOV EBX, EAX
        MOV [5], 1
ELSE:   JN FINCIC2
        ADD [5], 1
FINCIC2:ADD AC, 1
        JMP OTRO2
SIGUE2: MOV [1], EBX
        ; Mostrar máximo
        MOV EDX, DS
        ADD EDX, 1
        MOV CL, 1
        MOV CH, 4
        MOV AL, 1
        SYS 2
        ; Mostrar cantidad de apariciones del máximo
        ADD EDX, 4
        MOV CL, 1
        MOV CH, 1
        MOV AL, 1
        SYS 2
        STOP