; DOCUMENTACIÓN
; [0]: cantidad de elementos del vector
; DS+4: vector vec
; [BP-4]: i
; EAX, EBX: punteros a elementos de vec
; [EAX] = vec[i]
; [EBX] = vec[0]

MAIN:   MOV [0], 9
        PUSH BP
        MOV BP, SP

        PUSH 2; i:=2

        ; vec[i] = 501 // EAX := DS + 4 + 4*i
        MOV EAX, 4
        MUL EAX, [BP-4]
        ADD EAX, DS
        ADD EAX, 4
        MOV [EAX], 501

        ; vec[0] = 0xF0F0 & vec[i]
        MOV EBX, DS
        ADD EBX, 4
        MOV [EBX], 0xF0F0
        AND [EBX], [EAX]
        
        ; proce( i, vec )
        PUSH EBX
        PUSH [BP-4]
        CALL proce
        ADD SP, 8

        MOV SP, BP
        POP BP
        RET
        STOP

; DOCUMENTACIÓN
; [BP+8]: x
; [BP+12]: puntero a w
; EAX, EBX, ECX: punteros a elementos de w

proce:  PUSH BP
        MOV BP, SP
        PUSH EAX
        PUSH EBX
        PUSH ECX

        ; [ECX] := w[0]
        MOV ECX, [BP+12]

        ; [EBX] := w[x]
        MOV EBX, 4
        MUL EBX, [BP+8]
        ADD EBX, DS
        ADD EBX, 4

        ; [EAX] := w[x-1]
        MOV EAX, EBX
        SUB EAX, 4

        ; w[x-1] = w[x] | w[0]
        MOV [EAX], [EBX]
        OR [EAX], [ECX]

        POP ECX
        POP EBX
        POP EAX
        MOV SP, BP
        POP BP
        RET