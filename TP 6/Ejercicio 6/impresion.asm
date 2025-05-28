\\INCLUDE "ejercicio5.asm"


\\EXTRA 1024
ES_SIZE EQU 1024

MAIN:   PUSH BP
        MOV BP, SP

        CALL INIT
        SYS 0xF
        CALL ingresarLista

        PUSH EAX
        CALL imprimir
        ADD SP, 4

        MOV SP, BP
        POP BP
        RET
        STOP

ingresarLista:  PUSH BP
                MOV BP, SP

                ; Variables locales
                PUSH null
                SUB SP, 4

                ; Registros auxiliares
                PUSH EBX
                PUSH ECX
                PUSH EDX

                MOV EBX, BP
                SUB EBX, 4

                MOV EDX, BP
                SUB EDX, 8

                MOV CH, 4
                MOV CL, 1
                MOV AL, 1
                SYS 1

OTRO:           CMP [EDX], 0
                JNP FIN
                    PUSH [EDX]
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
                POP ECX
                POP EBX
                ADD SP, 8
                MOV SP, BP
                POP BP
                RET