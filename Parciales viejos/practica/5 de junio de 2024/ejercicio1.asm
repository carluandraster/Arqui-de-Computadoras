NULL EQU -1
ES_SIZE EQU 1024
\\EXTRA 1024

; Estructura de nnom
INICIAL EQU 0
NOMBRE EQU 1
SIG EQU 5

; INVOCACIÓN
; CALL _start
; Inicializa la memoria dinámica

_start: PUSH BP
        MOV BP, SP

        ; Guardo en [ES] la próxima dirección de memoria donde reservar memoria
        MOV [ES], ES
        ADD [ES], 4

        MOV SP, BP
        POP BP
        RET

; INVOCACIÓN
; PUSH <int>
; CALL ALLOC
; ADD SP, 4
; En EAX devuelve dirección de memoria

; DOCUMENTACIÓN
; [BP+8]: cantidad de bytes que se debe reservar en memoria
; EAX: dirección de memoria (se pisa)
; BX: tamaño de memoria que quedaría

ALLOC:  PUSH BP
        MOV BP, SP
        PUSH EBX

        MOV EAX, NULL
        MOV BX, w[ES+2]
        ADD BX, [BP+8]

        CMP BX, ES_SIZE
        JP NO_MEM

SI_MEM: MOV EAX, [ES]
        ADD [ES], [BP+8]

NO_MEM: POP EBX
        MOV SP, BP
        POP BP
        RET

; INVOCACIÓN
; PUSH <char *>
; CALL nnom_create
; ADD SP, 4
; En EAX devuelve puntero a nnom

; DOCUMENTACIÓN
; [BP+8]: string nombre
; EAX puntero a struct nnom (se pisa)
; EBX = [BP+8] => [EBX] = *nombre

nnom_create:    PUSH BP
                MOV BP, SP
                PUSH EBX

                PUSH 9
                CALL ALLOC
                ADD SP, 4

                CMP EAX, NULL
                JZ FIN_NC
                    MOV EBX, [BP+8]
                    MOV [EAX+INICIAL], [EBX]
                    MOV [EAX+NOMBRE], EBX
                    MOV [EAX+SIG], NULL

FIN_NC:         POP EBX
                MOV SP, BP
                POP BP
                RET

; INVOCACIÓN
; PUSH <nnom *>
; PUSH <nnom **>
; CALL nnom_add
; ADD SP, 8
; No devuelve nada (función void)

; DOCUMENTACIÓN
; [BP+8]: header
; [BP+12]: nuevo
; EAX: n => [EAX] = *n
; EBX = [EAX] = *n
; ECX = [BP+12] = nuevo

nnom_add:   PUSH BP
            MOV BP, SP
            PUSH EAX
            PUSH EBX
            PUSH ECX

            CMP [BP+12], NULL
            JZ FIN_NA

            MOV EAX, [BP+8]
            MOV EBX, [EAX]
            MOV ECX, [BP+12]
OTRO_NA:    CMP EBX, NULL
            JZ SIGUE_NA
            CMP [EBX+INICIAL], [ECX+INICIAL]
            JNN SIGUE_NA
                MOV EAX, [EAX]
                ADD EAX, SIG
            MOV EBX, [EAX]
            MOV ECX, [BP+12]
            JMP OTRO_NA

SIGUE_NA:   MOV [ECX+SIG], EBX
            MOV EBX, ECX

FIN_NA:     POP ECX
            POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET