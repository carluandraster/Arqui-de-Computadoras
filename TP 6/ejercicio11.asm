NULL EQU -1

; Nodo del árbol
CLAVE EQU 0
HIJOS EQU 4

; Nodo de la lista de árboles
ARBOL EQU 0
SIG EQU 4

; INVOCACIÓN
; PUSH <int>
; PUSH <nodoL **>
; CALL ELIMINAR_NODOS_SI
; ADD SP, 8
; Devuelve cantidad de nodos eliminados en EAX

; DOCUMENTACIÓN
; [BP+8]: doble puntero a nodoL (o puntero simple a lista)
; [BP+12]: valor entero
; EAX: contador de nodos eliminados (se pisa)
; EBX: iterador
; ECX: registro auxiliar para guardar cantidad previa de nodos eliminados

ELIMINAR_NODOS_SI:  PUSH BP
                    MOV BP, SP

                    ; Registros auxiliares
                    PUSH EBX
                    PUSH ECX

                    MOV EAX, 0
                    MOV EBX, [BP+8]
OTRO_ENS:           CMP [EBX], NULL
                    JZ FIN_ENS
                        MOV ECX, EAX; Guardo una copia del contador en ECX porque ahora EAX se va a pisar
                        PUSH [BP+12]
                        PUSH EBX; Le paso &(*it)->arbol
                        CALL _ELIMINAR_NODOS_SI
                        ADD SP, 8
                        ADD EAX, ECX
                        CMP [EBX+ARBOL], NULL
                        JNZ ELSE_ENS
                            MOV ECX, [EBX]
                            MOV ECX, [ECX+SIG]
                        JMP SIGUE_ENS
ELSE_ENS:                   MOV EBX, [EBX]
                            ADD EBX, SIG
SIGUE_ENS:          JMP OTRO_ENS

FIN_ENS:            POP ECX
                    POP EBX
                    MOV SP, BP
                    POP BP
                    RET

; INVOCACIÓN
; PUSH <int>
; PUSH <nodoA **>
; CALL _ELIMINAR_NODOS_SI
; ADD SP, 8
; En EAX devuelve la cantidad de nodos eliminados

; DOCUMENTACIÓN
; [BP+8]: doble puntero a nodoA (o un puntero simple a arbol)
; [BP+12]: valor entero
; EAX: contador de nodos eliminados (se pisa)
; EBX = [BP+8] => [EBX+campo] = A->campo
; ECX: registro auxiliar

_ELIMINAR_NODOS_SI: PUSH BP
                    MOV BP, SP
                    PUSH EBX
                    PUSH ECX

                    MOV EAX, 0
                    MOV EBX, [BP+8]
                    CMP EBX, NULL
                    JZ FIN__ENS
                        CMP [EBX+CLAVE], [BP+12]
                        JNZ ELSE__ENS
                            ADD EAX, 1
                            PUSH [BP+8]
                            CALL PROMOVER_HIJO
                            ADD SP, 4
                            MOV ECX, EAX
                            PUSH [BP+12]
                            PUSH [BP+8]
                            CALL _ELIMINAR_NODOS_SI
                            ADD SP, 8
                            ADD EAX, ECX
                        JMP FIN__ENS
ELSE__ENS:                  MOV ECX, EAX
                            PUSH [BP+12]
                            ADD EBX, HIJOS
                            PUSH EBX
                            CALL ELIMINAR_NODOS_SI
                            ADD SP, 8
                            ADD EAX, ECX
FIN__ENS:           POP ECX
                    POP EBX
                    MOV SP, BP
                    POP BP
                    RET

; INVOCACIÓN
; PUSH <nodoA **>
; CALL PROMOVER_HIJO
; ADD SP, 4
; No devuelve nada

; DOCUMENTACIÓN
; [BP+8]: doble puntero a nodoA (o puntero simple a árbol)
; EAX = [BP+8] = puntero a arbol A
; EBX: iterador
; ECX: registro auxiliar

PROMOVER_HIJO:  PUSH BP
                MOV BP, SP
                PUSH EAX
                PUSH EBX
                PUSH ECX

                MOV EAX, [BP+8]
                CMP [EAX+HIJOS], NULL
                JNZ ELSE_PH1
                    MOV EAX, NULL
                JMP FIN_PH
                ; ECX := A->hijos->arbol->hijos
ELSE_PH1:       MOV ECX, [EAX+HIJOS]
                ADD ECX, ARBOL
                MOV ECX, [ECX+HIJOS]
                CMP ECX, NULL
                JNZ ELSE_PH2
                    MOV ECX, [EAX+HIJOS]
                    ADD ECX, SIG
                    MOV ECX, [ECX]
                    MOV EAX, [EAX+HIJOS]
                JMP FIN_PH
ELSE_PH2:           MOV EBX, [EAX+HIJOS]
                    ADD EBX, ARBOL
                    MOV EBX, [EBX]
                    ADD EBX, HIJOS
                    MOV EBX, [EBX]
OTRO_PH:            CMP [EBX+SIG], NULL
                    JZ SIGUE_PH
                        ADD EBX, [EBX+SIG]
                    JMP OTRO_PH
SIGUE_PH:           MOV [EBX+SIG], [EAX+HIJOS]
                    ADD [EBX+SIG], SIG
                    MOV ECX, [EBX+SIG]
                    MOV [EBX+SIG], [ECX]
                    MOV EAX, [EAX+HIJOS]

FIN_PH:         POP ECX
                POP EBX
                POP EAX
                MOV SP, BP
                POP BP
                RET