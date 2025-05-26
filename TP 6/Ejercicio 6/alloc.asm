; Ejercicio 4

NULL EQU -1
NO_MEM_EXCEPTION EQU "ERROR: se agoto la memoria heap"

; CALL INIT
; Sirve para inicializar el ES
INIT:   MOV [ES], ES
        ADD [ES], 4
        RET

; PUSH <cant_bytes> (+8)
; CALL ALLOC
; ADD SP, 4
; En EAX se devuelve dirección de memoria

ALLOC:  PUSH BP
        MOV BP, SP
        PUSH EBX
        PUSH EDX

        MOV EAX, NULL
        MOV BX, w[ES+2]
        ADD BX, [BP+8]
        CMP BX, es_size
        JP no_mem

SI_MEM: MOV EAX, [ES]
        ADD [ES], [BP+8]
        JMP FIN_ALLOC

NO_MEM: MOV EDX, KS
        ADD EDX, NO_MEM_EXCEPTION
        SYS 4

FIN_ALLOC: POP EBX
        MOV SP, BP
        POP BP
        RET