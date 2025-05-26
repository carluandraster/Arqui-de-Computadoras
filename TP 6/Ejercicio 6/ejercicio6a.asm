\\INCLUDE "ejercicio5.asm"

; La siguiente función toma los valores de 2 listas y crea una nueva con los valores de las 2 listas

; INVOCACIÓN
; PUSH <nodoL*>
; PUSH <nodoL*>
; CALL intercalar
; ADD SP, 8
; En EAX devuelve puntero a lista

; DOCUMENTACIÓN
; [BP+8]: lista a
; [BP+12]: lista b
; [BP-4]: lista auxiliar
; [BP-8]: iterador
; &it->valor = it + valor = [BP-8] + VALOR
; EBX := [BP-8] + VALOR => [EBX] = it->valor (1)
; ECX := [BP-8] + SIG => [ECX] = it->sig (2)
; EDX := BP-4 => EDX = &aux

INTERCALAR: PUSH BP
            MOV BP, SP

            ; Variables locales
            PUSH NULL
            PUSH [BP+8]

            ; Registros auxiliares
            PUSH EBX
            PUSH ECX
            PUSH EDX

OTRO_INT1:  CMP [BP-8], NULL
            JZ SIGUE_INT1
                ; Por (1)
                MOV EBX, [BP-8]
                ADD EBX, VALOR

                ; Por (2)
                MOV ECX, [BP-8]
                ADD ECX, SIG

                ; crear_nodo(it->valor)
                PUSH [EBX]
                CALL crear_nodo
                ADD SP, 4

                ; inserta_ordenado(&aux, crear_nodo(it->valor))
                PUSH EAX
                MOV EDX, BP
                SUB EDX, 4
                PUSH EDX
                CALL inserta_ordenado
                ADD SP, 8

                ; it = it->sig
                MOV [BP-8], [ECX]
            JMP OTRO_INT1
SIGUE_INT1: MOV [BP-8], [BP+12]
OTRO_INT2:  CMP [BP-8], NULL
            JZ SIGUE_INT2
                ; Por (1)
                MOV EBX, [BP-8]
                ADD EBX, VALOR

                ; Por (2)
                MOV ECX, [BP-8]
                ADD ECX, SIG

                ; crear_nodo(it->valor)
                PUSH [EBX]
                CALL crear_nodo
                ADD SP, 4

                ; inserta_ordenado(&aux, crear_nodo(it->valor))
                PUSH EAX
                MOV EDX, BP
                SUB EDX, 4
                PUSH EDX
                CALL inserta_ordenado
                ADD SP, 8

                ; it = it->sig
                MOV [BP-8], [ECX]
            JMP OTRO_INT2
SIGUE_INT2: MOV EAX, [BP-4]

            POP EDX
            POP ECX
            POP EBX
            ADD SP, 8
            MOV SP, BP
            POP BP
            RET