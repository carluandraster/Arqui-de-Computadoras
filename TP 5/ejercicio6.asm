\\INCLUDE "../string.asm"

; Declaración de constantes
        MENSAJE1 EQU "Ingrese una frase:\n"
        MENSAJE2 EQU "Es frase palindroma\n"
        MENSAJE3 EQU "No es frase palindroma\n"

; DOCUMENTACIÓN
; [0]: primer caracter del string
; BL: booleano que indica si el string es palíndromo

;MAIN:   PUSH BP
        MOV BP, SP

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
        CMP FL, 0
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
; EAX: puntero a caracter de s (s[i] = b[EAX])
; ECX: puntero a caracter de s (s[j] = b[ECX])
; BH: registro de respuesta de esAlfabetico
; BL: resultado de una comparación
; FL: booleano auxiliar (se pisa)

esPalindroma:   PUSH BP
                MOV BP, SP
                PUSH EAX
                PUSH BX
                PUSH ECX

                ; i:= 0; j:= slen(s)-1
                MOV EAX, [BP+8]
                PUSH [BP+8]
                CALL SLEN
                ADD SP, 4
                ADD ECX, [BP+8]
                SUB ECX, 1

                ; aux := true (verdadero hasta que se demuestre lo contrario)
                MOV FL, 1

                ; while (i<j)
otro1_ep:       CMP EAX, ECX
                JNN FIN_EP
                        ; while(!esAlfabetico(s[i]))
otro2_ep:               PUSH b[EAX]
                        CALL esAlfabetico
                        ADD SP, 4
                        CMP BH, 0
                        JZ otro3_ep; Si el caracter no es alfabético, no hacer nada
                                ADD EAX, 1
                        JMP otro2_ep
                        ; while(!esAlfabetico(s[j]))
otro3_ep:               PUSH b[ECX]
                        CALL esAlfabetico
                        ADD SP, 4
                        CMP BH, 0
                        JZ sigue3_ep; Si el caracter no es alfabético, no hacer nada
                                SUB ECX, 1
                        JMP otro3_ep
                        ; aux = s[i] == s[j]
sigue3_ep:              PUSH b[EAX]
                        PUSH b[ECX]
                        CALL CMP_IGNORE_CASE
                        ADD SP, 8
                        ; if b[EAX] != b[ECX] then aux := false; break
                        CMP BL, 0
                        JNZ sigueF_EP1
                        ADD EAX, 1
                        SUB ECX, 1
                JMP otro1_ep

sigueF_EP1:     MOV FL, 0

FIN_EP:         POP ECX
                POP BH
                POP EAX
                MOV SP, BP
                POP BP
                RET

; DOCUMENTACIÓN
; [BP+8]: caracter
; CL: caracter en mayúscula (se pisa)
upper_case:     PUSH BP
                MOV BP, SP

                ; CL := [BP+8] & ~' '
                MOV CL, [BP+8]
                AND CL, 0xDF
                
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

; DOCUMENTACIÓN
; [BP+8], [BP+12]: caracteres a comparar
; Compara 2 caracteres sin importar si es mayúscula o minúscula
; BL: resultado (se pisa)
; Si BL es positivo, [BP+8]>[BP+12]
; Si BL es negativo, [BP+8]<[BP+12]
; Si BL es 0, [BP+8]=[BP+12]
; CH: [BP+8] en mayúscula
; CL: [BP+12] en mayúscula
CMP_IGNORE_CASE:        PUSH BP
                        MOV BP, SP
                        PUSH CX

                        ; CH := upper_case([BP+8])
                        PUSH [BP+8]
                        CALL upper_case
                        ADD SP, 4
                        MOV CH, CL

                        ; CL := upper_case([BP+12])
                        PUSH [BP+12]
                        CALL upper_case
                        ADD SP, 4
                        
                        ; BL := CH-CL
                        MOV BL, CH
                        SUB BL, CL

FIN_CIC:                POP CX
                        MOV SP, BP
                        POP BP
                        RET