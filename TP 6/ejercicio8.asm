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
; [BP-4]: iterador it1
; [BP-8]: iterador it2
; EAX: contador (se pisa)

eliminar_repetidos: PUSH BP
                    MOV BP, SP

                    SUB SP, 8
                    PUSH EBX

                    MOV EAX, 0
                    MOV EBX, [BP+8]

                    CMP [EBX], NULL
                    JZ FIN_ER
                    
                    MOV [BP-4], [EBX]
                    ADD [BP-4], SIG
OTRO_ER1:           CMP [BP-4], [EBX]
                    JZ FIN_ER
                        MOV [BP-8],[BP-4]
                        ADD [BP-8], ANT
OTRO_ER2:               CMP [BP-8], [EBX]
                        JZ SIGUE_ER2
                        