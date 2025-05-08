\\INCLUDE "ejercicio3.asm"

; DOCUMENTACIÓN
; [BP+8]: cantidad de argumentos (argc = 3)
; [BP+12]: puntero a vector de punteros a parámetros (argv)
; [0]: opA
; BL: operacion
; [4]: opB
; EAX: valor de retorno función str_to_int (ver ejercicio 3)
; ECX: puntero a elemento de argv (ECX = &argv[i])

MAIN:   PUSH BP
        MOV BP, SP

        CMP [BP+8],3
        JNZ FIN

        MOV ECX, [BP+12]
        ; [0] := str_to_int(argv[0])
            PUSH ECX
            CALL str_to_int
            ADD SP, 4
            MOV [0], EAX
        ; BL := argv[1]
            ADD ECX, 4
            MOV BL, b[ECX]
        ; [4] := str_to_int(argv[2])
            ADD ECX, 4
            PUSH ECX
            CALL str_to_int
            MOV [4], EAX
        
        ; switch BL
        CMP BL, '+'
        JZ SUMA
        CMP BL, '-'
        JZ RESTA
        CMP BL, '*'
        JZ MULTIPLICACION
        CMP BL, '/'
        JZ DIVISION
        JNZ FIN

SUMA:   ADD [0], [4]
        JMP Mostrar

RESTA:  SUB [0], [4]
        JMP Mostrar

MULTIPLICACION: MUL [0], [4]
        JMP Mostrar

DIVISION:   DIV [0], [4]
        JMP Mostrar

Mostrar:    MOV EDX, DS
        MOV CL, 1
        MOV CH, 4
        MOV AL, 1
        SYS 2

FIN:    MOV SP, BP
        POP BP
        RET
        STOP