\\INCLUDE "ejercicio1.asm"

; struct Persona
ID EQU 0
DNI EQU 2
NOMBRE EQU 12
NACIMIENTO EQU 33

; struct nodoL
PERSONA EQU 0
SIGUIENTE EQU 4

; struct Fecha
ANIO EQU 0
MES EQU 2
DIA EQU 3


; INVOCACIÓN
; PUSH <fecha>
; PUSH <int>
; PUSH <int>
; PUSH <int>
; CALL ANIOS_DIFERENCIA
; ADD SP, 16
; En EAX devuelve edad

; DOCUMENTACIÓN
; [BP+8]: año
; [BP+12]: mes
; [BP+16]: dia
; [BP+20]: fecha => w[BP+20]/b[BP+22]/b[BP+23]
; EAX: diferencia de años (se pisa)

ANIOS_DIFERENCIA:   PUSH BP
                    MOV BP, SP

                    MOV EAX, [BP+8]
                    SUB EAX, w[BP+20]

                    CMP [BP+12], b[BP+22]
                    JP FIN_AD
                    JN NO_CUMPLIO
                    CMP [BP+16], b[BP+23]
                    JNN FIN_AD
NO_CUMPLIO:         SUB EAX, 1

FIN_AD:             MOV SP, BP
                    POP BP
                    RET

; INVOCACION
; PUSH <nodoL *>
; CALL GET_MAYORES
; ADD SP, 4
; Devuelve en EAX el puntero a la cabeza de la lista de nombres

; DOCUMENTACIÓN
; [BP+8]: lista
; EAX: registro de retorno
; EBX: puntero a lista auxiliar
; ECX: iterador
; [BP-4]: lista auxiliar
; EDX: registro auxiliar

GET_MAYORES:    PUSH BP
                MOV BP, SP
                PUSH EBX
                PUSH ECX
                PUSH EDX

                PUSH NULL
                MOV ECX, [BP+8]

OTRO_GM:        CMP ECX, NULL
                JZ FIN_GM
                    PUSH [ECX+FECHA]
                    PUSH 4
                    PUSH 6
                    PUSH 2025
                    CALL ANIOS_DIFERENCIA
                    ADD SP, 16
                    CMP EAX, 18
                    JN SIGUE_GM
                        ; EDX := &it->nombre
                        MOV EDX, ECX
                        ADD EDX, NOMBRE

                        PUSH EDX
                        CALL nnom_create
                        ADD SP, 4

                        PUSH EAX

                        ; EDX := BP-4 = &aux
                        MOV EDX, BP
                        SUB BP, 4

                        PUSH EDX
                        CALL nnom_add
                        ADD SP, 8
SIGUE_GM:           MOV ECX, [ECX+SIG]
                JMP OTRO_GM

FIN_GM:         POP EDX
                POP ECX
                POP EBX
                MOV SP, BP
                POP BP
                RET