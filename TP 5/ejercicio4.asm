\\INCLUDE "../Ejercicio 3/conversor.asm"

; DOCUMENTACIÓN
; [BP+8]: cantidad de argumentos (argc = 3)
; [BP+12]: puntero a vector de punteros a parámetros (argv)
; [0]: opA
; BL: operacion
; [4]: opB
; EAX: valor de retorno función str_to_int (ver ejercicio 3) y función auxiliar
; ECX: puntero a elemento de argv (ECX = &argv[i])

EXCEPTION EQU "Operacion invalida\n"

MAIN:   PUSH BP
        MOV BP, SP
        

        CMP l[BP+8],3
        JNZ FIN

        MOV ECX, l[BP+12]
        ; [0] := str_to_int(argv[0])
            PUSH [ECX]
            CALL str_to_int
            ADD SP, 4
            MOV l[DS], EAX
        ; BL := argv[1]
            ADD ECX, 4
            MOV EAX, [ECX]
            MOV BL, b[EAX]
        ; [4] := str_to_int(argv[2])
            ADD ECX, 4
            PUSH [ECX]
            CALL str_to_int
            ADD SP, 4
            MOV l[DS+4], EAX
        
        ; switch BL
        CMP BL, '+'
        JZ SUMA
        CMP BL, '-'
        JZ RESTA
        CMP BL, '*'
        JZ MULT
        CMP BL, '/'
        JZ DIVI
        JNZ ERROR

SUMA:   ADD l[DS], l[DS+4]
        JMP Mostr

RESTA:  SUB l[DS], l[DS+4]
        JMP Mostr

MULT:   MUL l[DS], l[DS+4]
        JMP Mostr

DIVI:   DIV l[DS], l[DS+4]
        JMP Mostr

Mostr:  MOV EDX, DS
        MOV CL, 1
        MOV CH, 4
        MOV AL, 1
        SYS 2
        JMP FIN

ERROR:  MOV EDX, KS
        ADD EDX, EXCEPTION
        SYS 4

FIN:    MOV SP, BP
        POP BP
        RET
        STOP