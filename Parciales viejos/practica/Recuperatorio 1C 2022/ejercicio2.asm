\\INCLUDE "ejercicio1.asm"

; struct nodoL
VALOR EQU 0
SIG EQU 4

; INVOCACIÓN
; PUSH <nodoA *>
; PUSH <nodoL **>
; CALL ELIMINAR_B
; ADD SP, 8
; No devuelve nada (función void)

; DOCUMENTACIÓN
; [BP+8]: puntero a lista L
; [BP+12]: arbol A
; EAX: registro de retorno para BUSCAR_B
; EBX: puntero a nodoL para llamar a free
; ECX = [EDX] => [ECX+campo] = (*it)->valor
; EDX: iterador

ELIMINAR_B: PUSH BP
            MOV BP, SP
            PUSH EAX
            PUSH EBX
            PUSH ECX
            PUSH EDX

            MOV EDX, [BP+8]
OTRO_EB:    CMP [EDX], NULL
            JZ FIN_EB
                MOV ECX, [EDX]
                PUSH [ECX+VALOR]
                PUSH [BP+12]
                CALL BUSCAR_B
                ADD SP, 8
                CMP EAX, 0
                JZ ELSE_EB
                    MOV EBX, [EDX]
                    MOV [EDX], [EEX+SIG]
                    PUSH EBX
                    CALL free
                    ADD SP, 4
                JMP OTRO_EB
ELSE_EB:        MOV EDX, [EDX]
                ADD EDX, SIG
                JMP OTRO_EB

FIN_EB:     POP EDX
            POP ECX
            POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET