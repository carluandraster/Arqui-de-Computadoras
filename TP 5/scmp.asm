\\INCLUDE "../../string.asm"

TEXTO EQU "Prueba"
;MOV EDX, KS
;ADD EDX, TEXTO
;SYS 4

MAIN:   PUSH BP
        MOV BP, SP

        ; Ingresar un string
        MOV EDX, DS
        MOV CX, 50
        SYS 3

        ; Comparar constante TEXTO con string ingresado
        MOV EAX, KS
        ADD EAX, TEXTO
        PUSH EAX; Push KS+Texto
        PUSH DS
        CALL SCMP
        ADD SP, 8

        ; Mostrar por pantalla el resultado de SCMP
        MOV [50], ECX
        MOV EDX, DS
        ADD EDX, 50
        MOV CH, 4
        MOV CL, 1
        MOV AL, 1
        SYS 2
        
        MOV SP, BP
        POP BP
        RET
        STOP