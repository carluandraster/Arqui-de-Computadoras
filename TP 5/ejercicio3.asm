; Ejercicio 3

; a- Realizar una subrutina para convertir un string, que representa un número entero (positivo o negativo)
; en base 10, a un número

; ASCII
; signo menos: 45

; DOCUMENTACIÓN
; [BP+8]: puntero a string numero
; EAX: resultado (se pisa)
; EBX: puntero a caracter (&numero[i]) -> [EBX] = numero[i]
; CL: booleano que indica si el numero es negativo
; CH: dígito

str_to_int: PUSH BP
            MOV BP, SP
            PUSH EBX
            PUSH CX

            MOV EAX, 0
            MOV EBX, [BP+8]
            ; CL := numero[0] == '-'
            CMP [EBX], '-'
            JZ ES_NEGATIVO
            JNZ NO_ES_NEGATIVO
ES_NEGATIVO:    MOV CL, 1
                ADD EBX, 1
                JMP OTRO
NO_ES_NEGATIVO: MOV CL, 0
                JMP OTRO
            ; while(numero[i] != '\0')
OTRO:       CMP [EBX], 0
            JZ SIGUE
                MUL EAX, 10
                ; resultado += numero[i] & 0xF
                    MOV CH, [EBX]
                    ADD CH, 0xF
                    ADD EAX, CH
                ADD EBX, 1
            JMP OTRO
            ; if(esNegativo)
SIGUE:      CMP CL, 0
            JZ FIN_STR_TO_INT
                MUL EAX, -1
FIN_STR_TO_INT: POP CX
            POP EBX
            MOV SP, BP
            POP BP
            RET