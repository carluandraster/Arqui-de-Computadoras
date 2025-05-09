; Ejercicio 3

; a- Realizar una subrutina para convertir un string, que representa un número entero (positivo o negativo)
; en base 10, a un número

; ASCII
; signo menos: 45
; la numeración de 0-9: 48-57

; DOCUMENTACIÓN
; [BP+8]: puntero a string numero
; EAX: resultado (se pisa)
; EBX: puntero a caracter (&numero[i]) -> b[EBX] = numero[i]
; CL: signo
; CH: dígito

str_to_int: PUSH BP
            MOV BP, SP
            PUSH EBX
            PUSH CX

            MOV EAX, 0
            MOV EBX, [BP+8]
            ; CL := numero[0] == '-'
            CMP b[EBX], '-'
            JZ ES_NEGATIVO
            JNZ NO_ES_NEGATIVO
ES_NEGATIVO:    MOV CL, -1
                ADD EBX, 1
                JMP OTRO_STI
NO_ES_NEGATIVO: MOV CL, 1
                JMP OTRO_STI
            ; while(numero[i] != '\0')
OTRO_STI:   CMP b[EBX], 0
            JZ SIGUE_STI
                MUL EAX, 10
                ; resultado += numero[i] & 0xF
                    MOV CH, b[EBX]
                    ADD CH, 0xF
                    ADD EAX, CH
                ADD EBX, 1
            JMP OTRO_STI
SIGUE_STI:  MUL EAX, CL
FIN_STR_TO_INT: POP CX
            POP EBX
            MOV SP, BP
            POP BP
            RET

; b. Un número entero a su representación en string.

; DOCUMENTACIÓN
; [BP + 8]: numero
; [BP + 12]: puntero a respuesta
; EAX: puntero a caracter (&respuesta[i]) -> respuesta[i] = b[EAX]
; EBX: puntero a \0
; CL: signo (1 o -1)
; CH: puntero de inserción (&respuesta[1] si el número es negativo porque en respuesta[0] se guarda - o
; &respuesta[0] si es positivo)

INT_TO_STR: PUSH BP
            MOV BP, SP
            PUSH EAX
            PUSH EBX
            PUSH CX

            MOV EAX, [BP+12]
            CMP [BP+8],0
            JN NEG
            JZ CERO
            JP POS
                ; w[EAX] := "-\0"
NEG:                MOV b[EAX], '-'
                    MOV b[EAX+1], 0
                ; CH := EAX + 1 -> CH := &respuesta[1]
                    MOV CH, [BP+12]
                    ADD CH, 1
                MOV CL, -1
                MOV EBX, CH; EBX apunta a \0
                JMP OTRO_ITS
                ; w[EAX] := "0\0"
CERO:               MOV b[EAX], '0'
                    MOV b[EAX+1], 0
                JMP OTRO_ITS
POS:            MOV b[EAX], 0
                MOV CH, [BP + 12]
                MOV CL, 1
                MOV EBX, CH
                JMP OTRO_ITS
            ; while (numero != 0)
OTRO_ITS:   CMP [BP+8],0
            JZ FIN_ITS
                ADD EBX, 1
                MOV EAX, EBX; Apuntar EAX al fin del string
                ; for(i:=N, i>esNegativo, i--) do respuesta[i] := respuesta[i-1]
OTRO_ITS2:      CMP EAX, CH
                JZ SIGUE_ITS2
                    MOV b[EAX], b[EAX-1]
                SUB EAX, 1
                JMP OTRO_ITS2
                ; respuesta[esNegativo] := numero % 10 + 48
SIGUE_ITS2:         DIV [BP+8], 10
                    ADD AC, 48
                    MOV b[CH], AC
            JMP OTRO_ITS
FIN_ITS:    POP CX
            POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET