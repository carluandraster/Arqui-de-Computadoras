; Eliminar de una lista dinámica circular doblemente enlazada, todos los nodos con valor repetido.
; Además debe devolver la cantidad de nodos eliminados.

NULL EQU -1

VALOR EQU 0
ANT EQU 4
SIG EQU 8

; INVOCACIÓN
; PUSH <T_Lista *>
; CALL eliminar_repetidos
; ADD SP, 4
; En EAX se devuelve la cantidad de nodos eliminados

; DOCUMENTACIÓN
; [BP+8]: puntero a lista L => *L = [[BP+8]] = [EBX] => EBX = [BP+8]
; ECX: iterador it1
; EDX: iterador it2
; EAX: contador (se pisa)
; EEX: registro auxiliar para remover nodo

eliminar_repetidos: PUSH BP
                    MOV BP, SP

                    SUB SP, 8
                    PUSH EBX
                    PUSH ECX
                    PUSH EDX
                    PUSH EEX

                    MOV EAX, 0
                    MOV EBX, [BP+8]

                    CMP [EBX], NULL
                    JZ FIN_ER
                    
                    MOV ECX, [EBX]
                    ADD ECX, SIG
OTRO_ER1:           CMP ECX, [EBX]
                    JZ FIN_ER
                        MOV EDX,ECX
                        ADD EDX, ANT
OTRO_ER2:               CMP EDX, [EBX]
                        JZ SIGUE_ER2
                        CMP [ECX+VALOR], [EDX+VALOR]
                        JZ REMOVER_ER2
                            MOV EDX, [EDX+ANT]
                        JMP OTRO_ER2
REMOVER_ER2:            MOV EEX, [ECX+ANT]; EEX := it1->ant
                        MOV [EEX+SIG], [ECX+SIG]
                        MOV EEX, [ECX+SIG]; EEX := it1->sig
                        MOV [EEX+ANT], [ECX+ANT]
                        ADD EAX, 1
SIGUE_ER2:          MOV ECX, [ECX+SIG]
                    JMP OTRO_ER1

FIN_ER:             POP EEX
                    POP EDX
                    POP ECX
                    POP EBX
                    ADD SP, 8
                    MOV SP, BP
                    POP BP
                    RET