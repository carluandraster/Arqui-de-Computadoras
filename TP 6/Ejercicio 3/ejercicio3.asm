es_size EQU 1024

\\EXTRA 1024
\\INCLUDE "../alloc.asm"

; DOCUMENTACIÓN
; [BP-4]: z (ES UN PUNTERO!!!)
; [BP-8]: vec
; EBX: sizeof(int) * 100
; ECX: z -> [ECX] = *z

OFFSET_S EQU 0

        ; static int s = 0 (sentencia dentro de la funcion sum)
MAIN:   MOV [DS+OFFSET_S], 0
        JMP _MAIN

_MAIN:  PUSH BP
        MOV BP, SP

        ; Inicializar memoria dinámica
        CALL INIT

        ; int* z = malloc(sizeof(int))
        PUSH 4
        CALL ALLOC
        ADD SP, 4
        PUSH EAX

        ; int vec[] = malloc(sizeof(int) * 100)
        MOV EBX, 4
        MUL EBX, 100
        PUSH EBX
        CALL ALLOC
        ADD SP, 4
        PUSH EAX

        ; *z = 100 (a donde apunta z, asigno un 10)
        MOV ECX, [BP-4]
        MOV [ECX], 100

        ; funcion1(vec, *z)
        PUSH [ECX]
        PUSH [BP-8]
        CALL funcion1
        ADD SP, 8

        ADD SP, 8
        MOV SP, BP
        POP BP
        RET
        STOP

; DOCUMENTACIÓN
; [BP+8]: vec (ES UN PUNTERO!!!)
; [BP+12]: z -> &z = BP+12 = ECX
; [BP-4]: s
; [BP-8]: i
; EAX: registro de retorno
; EBX: puntero a elemento de vec -> [EBX] = vec[i]
; ECX: dirección de memoria de z (BP+12)
; EDX: puntero a s

funcion1:       PUSH BP
                MOV BP, SP

                ; Variables locales
                SUB SP, 4
                SUB SP, 4

                ; Registros auxiliares
                PUSH EBX
                PUSH ECX
                PUSH EDX

                ; vec[0] = 1
                MOV EBX, [BP+8]
                MOV [EBX],1

                ;for (i = 1; i < z; i++) do vec[i] = vec[i-1] * i; 
                ADD EBX, 4
                MOV [BP-8], 1
OTRO_FUNC1:     CMP [BP-8], [BP+12]
                JNN SIGUE_FUNC1
                        MOV [EBX], [EBX-4]
                        MUL [EBX], [BP-8]
                        ADD EBX, 4
                ADD [BP-8], 1
                JMP OTRO_FUNC1

                ; s = sum(vec, &z)
SIGUE_FUNC1:    MOV ECX, BP
                ADD ECX, 12
                PUSH ECX
                PUSH [BP+8]
                CALL sum
                ADD SP, 8
                MOV [BP-4], EAX

                ; print_int(s) 
                MOV EDX, BP
                SUB EDX, 4
                MOV CH, 4
                MOV CL, 1
                MOV AL, 1
                SYS 2

                POP EDX
                POP ECX
                POP EBX

                ADD SP, 8
                MOV SP, BP
                POP BP
                RET

; DOCUMENTACIÓN:
; [BP+8]: vec
; [BP+12]: n (ES UN PUNTERO!!!) -> *n = [n] = [[BP+12]]
; [DS+OFFSET_S]: s (es como si fuera una variable global)
; EAX: registro de retorno
; EBX: i
; ECX: puntero a vec[i] ([ECX] = vec[i])
; EDX: n -> [EDX] = *n

SUM:            PUSH BP
                MOV BP, SP
                PUSH EBX
                PUSH ECX
                PUSH EDX

                MOV EDX, [BP+12]

                ; for (i = 0; i < *n; i++) do s = s + vec[i];
                MOV EBX, 0
                MOV ECX, [BP+8]
OTRO_SUM:       CMP EBX, [EDX]
                JNN SIGUE_SUM
                        ADD [DS+OFFSET_S], [ECX]
                        ADD ECX, 4
                ADD EBX, 1
                JMP OTRO_SUM
SIGUE_SUM:      MOV EAX, [DS+OFFSET_S]

                POP ECX
                POP EBX
                MOV SP, BP
                POP BP
                RET