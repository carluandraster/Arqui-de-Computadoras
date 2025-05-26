\\INCLUDE "ejercicio5.asm"


\\EXTRA 1024
ES_SIZE EQU 1024

MAIN:   PUSH BP
        MOV BP, SP

        MOV EAX, ES
        ADD EAX, 4
        MOV [EAX], 27
        MOV [EAX+4], -1

        PUSH EAX
        CALL imprimir
        ADD SP, 4

        MOV SP, BP
        POP BP
        RET
        STOP