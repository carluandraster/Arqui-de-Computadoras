\\INCLUDE "alloc.asm"

CLAVE EQU 0
IZQ EQU 4
DER EQU 8

; INVOCACIÓN
; PUSH <int>
; CALL CREAR_NODO_ARB
; En EAX devuelve puntero a nodo

CREAR_NODO_ARB: PUSH BP
                MOV BP, SP

                PUSH 12
                CALL ALLOC
                ADD SP, 4
                CMP EAX, NULL
                JZ FIN_CREAR

                MOV [EAX+CLAVE], [BP+8]
                MOV [EAX+IZQ], null
                MOV [EAX+DER], null

FIN_CREAR_ARB:  MOV SP, BP
                POP BP
                RET

; INVOCACIÓN
; PUSH <int>
; PUSH <nodoA**>
; CALL agregarNodo
; ADD SP, 8
; No devuelve nada

; DOCUMENTACIÓN
; [BP+8]: puntero a arbol A
; [BP+12]: clave
; EAX: respuesta de crear_nodo_arb
; EBX = [BP+8] = A => [EBX] = *A y [EBX+campo] = (*A)->campo

agregarNodo:    PUSH BP
                MOV BP, SP
                PUSH EAX
                PUSH EBX

                MOV EBX, [NP+8]

                CMP [EBX], NULL
                JZ ELSE_AN1
                    PUSH [BP+12]
                    CALL CREAR_NODO_ARB
                    ADD SP, 4
                    MOV [EBX], EAX
                JMP FIN_AN
ELSE_AN1:       CMP [BP+12], [EBX+CLAVE]
                JP ELSE_AN2
                    PUSH [BP+12]
                    MOV EAX, [BP+8]
                    ADD EAX, IZQ
                    PUSH EAX
                    CALL agregarNodo
                    ADD SP, 8
                JMP FIN_AN
ELSE_AN2:           PUSH [BP+12]
                    MOV EAX, [BP+8]
                    ADD EAX, DER
                    PUSH EAX
                    CALL agregarNodo
                    ADD SP, 8

FIN_AN:         POP EBX
                POP EAX
                MOV SP, BP
                POP BP
                RET

; INVOCACIÓN
; PUSH <nodoA *>
; CALL INORDEN
; ADD SP, 4
; No devuelve nada

; DOCUMENTACIÓN
; [BP+8]: arbol A
; AL: formato
; EBX = [BP+8] => [EBX+campo] = A->campo
; CX: cantidad
; EDX: puntero

INORDEN:    PUSH BP
            MOV BP, SP
            PUSH AL
            PUSH EBX
            PUSH CX
            PUSH EDX

            MOV EBX, [BP+8]

            CMP [BP+8], NULL
            JZ FIN_INORDEN
                PUSH [EBX+IZQ]
                CALL INORDEN
                ADD SP, 4
