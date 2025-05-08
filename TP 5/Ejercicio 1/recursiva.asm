; DOCUMENTACIÓN del main
; [0]: base de la potencia
; [4]: exponente
; [8]: resultado para mostrar por pantalla
; EAX: registro reservado para que la función potencia devuelva su resultado

TEXTO EQU "Ingrese un par de numeros: "

main:   PUSH BP
        MOV BP, SP
        ; Mostrar que ingrese un par de numeros
            MOV EDX, KS
            ADD EDX, TEXTO
            SYS 4
        ; Ingresar el par de números
            ; Ingresar base
                MOV EDX, DS
                MOV CL, 1
                MOV CH, 4
                MOV AL, 1
                SYS 1
            ; Ingresar exponente
                ADD EDX, 4
OTRO0:          SYS 1
                ; Si la base y el exponente son 0 al mismo tiempo, se insiste con otro exponente porque 0^0 es una indeterminación
                    CMP [0], 0
                    JNZ SIGUE0
                    CMP [4], 0
                    JZ OTRO0
SIGUE0:     ; Llamar a la función
            PUSH [DS]
            PUSH [DS + 4]
            CALL potencia
            ADD SP, 8
            MOV [8], EAX
        ; Mostrar resultado
            MOV EDX, DS
            ADD EDX, 8
            MOV CL, 1
            MOV CH, 4
            MOV AL, 1
            SYS 2
        STOP

; DOCUMENTACIÓN de la función potencia
; [BP + 12]: base
; [BP + 8]: exponente
; EAX: registro reservado para el retorno
; EBX: registro auxiliar
            ; Prólogo
potencia:       PUSH BP
                MOV BP, SP
                PUSH EBX
            ; if(b == 0)
            CMP [BP + 8], 0
            JNZ ELSE
                ; return 1
                    MOV EAX, 1
                    JMP FIN_POTENCIA
            ; else if (b<0)
ELSE:       JP ELSE2
                ; return 1/potencia(a,-b)
                    PUSH [BP+12]
                    ; EBX := -b
                        MOV EBX, 0
                        SUB EBX, [BP + 8]
                    PUSH EBX
                    CALL potencia
                    ADD SP, 4
                    ; EBX := 1/EAX
                        MOV EBX, 1
                        DIV EBX, EAX
                    MOV EAX, EBX
                    JMP FIN_POTENCIA
                ; else return a*potencia/(a,b-1)
                    ; EBX := b-1
ELSE2:                  MOV EBX, [BP+8]
                        SUB EBX, 1
                    PUSH [BP + 12]
                    PUSH EBX
                    CALL potencia
                    ADD SP, 4
                    ; EBX := a*EAX
                        MOV EBX, [BP+12]
                        MUL EBX, EAX
                    MOV EAX, EBX
            ; Epílogo
FIN_POTENCIA:   POP EBX
                MOV SP, BP
                POP BP
                RET