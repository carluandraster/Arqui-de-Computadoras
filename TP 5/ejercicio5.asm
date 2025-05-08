\\INCLUDE "string.asm"

; DOCUMENTACIÓN
; [BP-4]: numero. Es donde se guarda el resultado de la operacion
; [BP-8]: otro numero
; [DS]: string
; [50]: cantidad de elementos del vector de abajo
; [DS+54]: vector de punteros a elementos de la operacion
; AC: variable de control
; EEX: puntero a string
; EBX: puntero a signo
; EFX: puntero al elemento del vector

MAIN:   PUSH BP
        MOV BP, SP

        ; Constantes
            MAX_ELEM EQU 50
            MAS EQU "+"
            MENOS EQU "-"
            POR EQU "*"
            SOBRE EQU "/"

        ; Mostrar mensajito inicial
            TEXTO EQU "Ingrese operacion matermatica en notacion polaca inversa\n"
            MOV EDX, KS
            ADD KS, TEXTO
            SYS 4

        ; Ingresar operacion en formato string
            MOV EDX, DS
            MOV CX, MAX_ELEM
            SYS 3

        ; Guardar vector
            MOV EFX, DS
            ADD EFX, MAX_ELEM
            ADD EFX, 4
            PUSH EFX
            PUSH ' '
            PUSH DS
            CALL SPLIT
            ADD SP, 12
        
        ; Recorrer vector de strings
            ; for(texto in textos)
            MOV AC, 0
            CMP AC, [MAX_ELEM]
            JZ SIGUE
                ; Si es el signo +, ir a sección suma
                MOV EBX, KS
                ADD EBX, MAS
                PUSH EBX
                PUSH [EFX]
                CALL SCMP
                ADD SP, 8
                CMP EAX, 0
                JZ CASE_+

                ; Si es el signo -, ir a sección menos
                MOV EBX, KS
                ADD EBX, MENOS
                PUSH EBX
                PUSH [EFX]
                CALL SCMP
                ADD SP, 8
                CMP EAX, 0
                JZ CASE_-

                ; Si es el signo *, ir a sección menos
                MOV EBX, KS
                ADD EBX, POR
                PUSH EBX
                PUSH [EFX]
                CALL SCMP
                ADD SP, 8
                CMP EAX, 0
                JZ CASE_*

                ; Si es el signo /, ir a sección menos
                MOV EBX, KS
                ADD EBX, SOBRE
                PUSH EBX
                PUSH [EFX]
                CALL SCMP
                ADD SP, 8
                CMP EAX, 0
                JZ CASE_/

                ; Sino, asumimos que es un número