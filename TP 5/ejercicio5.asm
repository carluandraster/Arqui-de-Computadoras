\\INCLUDE "string.asm"
\\INCLUDE "ejercicio3.asm"

; DOCUMENTACIÓN
; [BP-4]: numero. Es donde se guarda el resultado de la operacion
; [BP-8]: otro numero
; [DS]: string
; [50]: cantidad de elementos del vector de abajo
; [DS+54]: vector de punteros a elementos de la operacion
; AC: variable de control
; EBX: puntero a signo
; EFX: puntero al elemento del vector -> [EFX]: texto

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
OTRO:       CMP AC, [MAX_ELEM]
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
                PUSH [EFX]
                CALL STR_TO_INT
                ADD SP, 4
                PUSH EAX
                JMP FIN_CICLO

CASE_+:         ADD [SP+4],[SP]
                ADD SP, 4; Sacar de la pila el número
                JMP FIN_CICLO

CASE_-:         SUB [SP+4],[SP]
                ADD SP, 4; Sacar de la pila el número
                JMP FIN_CICLO

CASE_*:         MUL [SP+4],[SP]
                ADD SP, 4; Sacar de la pila el número
                JMP FIN_CICLO

CASE_/:         DIV [SP+4],[SP]
                ADD SP, 4; Sacar de la pila el número
                JMP FIN_CICLO

FIN_CICLO:  ADD EFX, 4
            JMP OTRO

        ; Apuntar EDX a [BP-4]
SIGUE:  MOV EDX, BP
        SUB EDX, 4
        MOV CH, 4
        MOV CL, 1
        MOV AL, 1
        SYS 2

        MOV SP, BP
        POP BP
        RET
        STOP