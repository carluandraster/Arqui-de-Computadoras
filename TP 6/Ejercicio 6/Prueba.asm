\\INCLUDE "ejercicio6a.asm"
ES_SIZE EQU 1024
\\EXTRA 1024

MSG1 EQU "Lista A. Ingrese numeros. (-1 para terminar)\n"
MSG2 EQU "Lista B. Ingrese numeros. (-1 para terminar)\n"
MSG3 EQU "Lista intercalada: \n"

; DOCUMENTACIÓN
; [BP-4]: puntero a lista A
; [BP-8]: puntero a lista B
; EAX: puntero a lista intercalada

MAIN:   PUSH BP
        MOV BP, SP

        CALL INIT

        MOV EDX, KS
        ADD EDX, MSG1
        SYS 4
        CALL ingresarLista
        PUSH EAX

        MOV EDX, KS
        ADD EDX, MSG2
        SYS 4
        CALL ingresarLista
        PUSH EAX

        PUSH [BP-8]
        PUSH [BP-4]
        CALL INTERCALAR
        ADD SP, 8

        MOV EDX, KS
        ADD EDX, MSG3
        SYS 4

        PUSH EAX
        CALL imprimir
        ADD SP, 4

        MOV SP, BP
        POP BP
        RET
        STOP

; INVOCACION
; CALL ingresarLista
; Devuelve en EAX la lista ingresada de forma ordenada

; DOCUMENTACION
; [BP-4]: lista auxiliar
; [BP-8]: numero
; EBX: puntero a lista = &aux
; EDX: puntero a numero = &nro

ingresarLista:  PUSH BP
                MOV BP, SP

                ; Variables locales
                PUSH null
                SUB SP, 4

                ; Registros auxiliares
                PUSH EBX
                PUSH CX
                PUSH EDX

                MOV EBX, BP
                SUB EBX, 4

                MOV EDX, BP
                SUB EDX, 8

                MOV CH, 4
                MOV CL, 1
                MOV AL, 1
                SYS 1

OTRO:           CMP [BP-8], 0
                JNP FIN
                    PUSH [BP-8]
                    CALL crear_nodo
                    ADD SP, 4
                    PUSH EAX
                    PUSH EBX
                    CALL inserta_ordenado
                    ADD SP, 8

                    MOV CH, 4
                    MOV CL, 1
                    MOV AL, 1
                    SYS 1
                JMP OTRO

FIN:            MOV EAX, [BP-4]
                POP EDX
                POP CX
                POP EBX
                ADD SP, 8
                MOV SP, BP
                POP BP
                RET