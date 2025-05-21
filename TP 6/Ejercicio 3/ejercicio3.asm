es_size EQU 1024

\\EXTRA es_size
\\INCLUDE "../alloc.asm"

; DOCUMENTACIÓN
; [BP-4]: z
; [BP-8]: vec
; EBX: sizeof(int) * 100
; ECX: z -> [ECX] = *z

MAIN:   PUSH BP
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

        ; *z = 100 (a donde apunta z, asigno un 100)
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
; [BP+8]: vec
; [BP+12]: Z
; [BP-4]: s
; [BP-8]: i
; EAX: registro de retorno
; EBX: puntero a elemento de vec

funcion1:   PUSH BP
            MOV BP, SP

            ; Variables locales
            SUB SP, 4
            SUB SP, 4

            ; Registros auxiliares
            PUSH EBX

            ; vec[0] = 1
            MOV [BP+8],1

            ;for (i = 1; i < z; i++) do vec[i] = vec[i-1] * i;
            MOV EBX, [BP+8]
            ADD EBX, 4
            MOV [BP-8], 1
OTRO:       CMP [BP-8],