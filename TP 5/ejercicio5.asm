\\INCLUDE "string.asm"

; DOCUMENTACIÓN`
; [BP-4]: numero. Es donde se guarda el resultado de la operacion
; [BP-8]: otro numero
; [DS]: string
; [DS+50]: vector de punteros a elementos de la operacion
; EFX: puntero al vector

MAIN:   PUSH BP
        MOV BP, SP

        ; Mostrar mensajito inicial
            TEXTO EQU "Ingrese operacion matermatica en notacion polaca inversa\n"
            MOV EDX, KS
            ADD KS, TEXTO
            SYS 4

        ; Ingresar operacion en formato string
            MOV EDX, DS
            MOV CX, 50
            SYS 3

        ; Guardar vector
            MOV EFX, DS
            ADD EFX, 50
            PUSH EFX
            PUSH ' '
            PUSH DS
            CALL SPLIT
            ADD SP, 9