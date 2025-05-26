\\INCLUDE "ejercicio5.asm"
; La siguiente función toma 2 listas ordenadas. Luego, vacía una para insertar en la otra. Los nodos se reutilizan.

; INVOCACIÓN
; PUSH <nodoL**>
; PUSH <nodoL**>
; CALL intercalar
; ADD SP, 8
; No devuelve nada (función void)

; DOCUMENTACIÓN
; [BP+8]: puntero a lista a. Es la lista que se va a llenar.
; [BP+12]: puntero a lista b. Es la lista que se va a vaciar.
; [BP-4]: iterador aux
; &aux->sig = aux + sig = [BP-4] + sig = EAX => [EAX] = aux->sig
; EBX = [BP+12] = b => [EBX] = *b

INTERCALAR: PUSH BP
            MOV BP, SP
            SUB SP, 4
            PUSH EAX
            PUSH EBX

            MOV EBX, [BP+12]
OTRO_INT:   CMP [EBX], NULL
            JZ SIGUE_INT
                MOV [BP-4], [EBX]
                MOV EAX, [BP-4]
                ADD EAX, SIG
                MOV [EBX], EAX
                PUSH [BP-4]
                PUSH [BP+8]
                CALL inserta_ordenado
                ADD SP, 8
            JMP OTRO_INT

SIGUE_INT:  POP EBX
            POP EAX
            ADD SP, 4
            MOV SP, BP
            POP BP
            RET