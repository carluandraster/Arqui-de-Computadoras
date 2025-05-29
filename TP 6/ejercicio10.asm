\\INCLUDE "ejercicio9.asm"

VALOR EQU 0
SIG EQU 4

; Dada una lista dinámica simplemente enlazada y un árbol binario de búsqueda, eliminar de la lista
; todos los nodos cuyo valor se encuentre en el árbol.

; INVOCACIÓN
; PUSH <nodoA *>
; PUSH <nodoL **>
; CALL ELIMINAR_NODOS
; ADD SP, 8
; No devuelve nada

; DOCUMENTACIÓN
; [BP+8]: puntero a lista L
; [BP+12]: arbol A
; EAX: resultado de esta
; EBX: iterador it => [EBX]+campo = &(*it)->campo
; ECX = [EBX] = *it => [ECX+campo] = (*it)->campo

ELIMINAR_NODOS: PUSH BP
                MOV BP, SP
                PUSH EAX
                PUSH EBX
                PUSH ECX

                MOV EBX, [BP+8]
OTRO_EN:        CMP [EBX], NULL
                JZ FIN_EN
                    MOV ECX, [EBX]
                    PUSH [ECX+VALOR]
                    PUSH [BP+12]
                    CALL esta
                    ADD SP, 8
                    CMP EAX, 0
                    JZ ELSE_EN
                        MOV ECX, [ECX+SIG]
                        JMP FIN_CIC_EN
ELSE_EN:            MOV EBX, [EBX]
                    ADD EBX, SIG
FIN_CIC_EN:     JMP OTRO_EN

FIN_EN:         POP ECX
                POP EBX
                POP EAX
                MOV SP, BP
                POP BP
                RET