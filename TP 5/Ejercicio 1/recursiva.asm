; DOCUMENTACIÓN del main
; [0]: base de la potencia
; [4]: exponente
; [8]: resultado

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
            ADD SP, 4
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
; [BP - 4]: variable de control para ciclo for
            ; Prólogo
potencia:       PUSH BP
                MOV BP, SP