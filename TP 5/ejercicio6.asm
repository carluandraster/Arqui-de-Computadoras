\\INCLUDE "string.asm"

; DOCUMENTACIÓN
; [0]: primer caracter del string
; BL: booleano que indica si el string es palíndromo

MAIN:   PUSH BP
        MOV BP, SP

        ; Declaración de constantes
        MENSAJE1 EQU "Ingrese una frase:\n"
        MENSAJE2 EQU "Es frase palindroma\n"
        MENSAJE3 EQU "No es frase palindroma\n"

        ; Ingresar string
        MOV EDX, KS
        ADD EDX, MENSAJE1
        SYS 4
        MOV EDX, DS
        MOV CX, 100
        SYS 3

        ; Hacer llamada a función
        PUSH DS
        CALL esPalindroma
        ADD SP, 4

        ; Mostrar resultado
        CMP BL, 0
        JP TRUE
        JZ FALSE

TRUE:   MOV EDX, KS
        ADD EDX, MENSAJE2
        SYS 4
        JMP FIN

FALSE:  MOV EDX, KS
        ADD EDX, MENSAJE3
        SYS 4
        JMP FIN

FIN:    MOV SP, BP
        POP BP
        RET
        STOP

; DOCUMENTACIÓN
; [BP+8]: puntero a string s
; EAX: puntero a caracter de s (s[i] = b[EAX]
; ECX: puntero a caracter de s (s[j] = b[ECX]
; BL: booleano auxiliar (se pisa)

esPalindroma:   MOV BP, SP
                PUSH BP
                PUSH EAX
                PUSH ECX

                ; i:= 0; j:= slen(s)-1
                MOV EAX, [BP+8]
                PUSH [BP+8]
                CALL SLEN
                ADD SP, 4
                ADD ECX, [BP+8]
                SUB ECX, 1

                ; aux := true (verdadero hasta que se demuestre lo contrario)
                MOV BL, 1

                ; while (i<j && aux)
otro1_ep:       CMP EAX, ECX
                JNP FIN_EP
                CMP BL, 0
                JZ FIN_EP
otro2_ep:           CMP b[EAX], ' '
                    JZ ENTRA2_EP
                    CMP b[EAX], 9
                    JZ ENTRA2_EP
                    CMP b[EAX], '.'
                    JZ ENTRA2_EP
                    CMP b[EAX], ','
                    JZ ENTRA2_EP

; DOCUMENTACIÓN
; [BP+8]: caracter
; CL: caracter en mayúscula (se pisa)
upper_case:     PUSH BP
                MOV BP, SP

                ; CL := [BP+8] & ~' '
                MOV CL, ' '
                NOT CL
                AND CL, [BP+8]
                
                MOV SP, BP
                POP BP
                RET

; DOCUMENTACIÓN
; [BP+8]: caracter
; BH: registro de retorno (SE PISA)
; CL: caracter en mayúscula
esAlfabetico:   PUSH BP
                MOV BP, SP
                PUSH CL

                MOV BH, 1; Verdadero hasta que se demuestre lo contrario

                ; Obtener el caracter en mayúscula
                PUSH [BP+8]
                CALL upper_case
                ADD SP, 4

                CMP CL, 'A'
                JN NO

                CMP CL, 'Z'
                JP NO
                JMP FIN_EA

NO:             MOV BH, 0
FIN_EA:         POP CL
                MOV SP, BP
                POP BP
                RET