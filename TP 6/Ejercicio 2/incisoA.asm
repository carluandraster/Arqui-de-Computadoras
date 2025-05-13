; DOCUMENTACIÓN
; [0]: j
; [4]: cantidad de elementos del vector arreglo[5]
; [8]: primer elemento del vector arreglo[5]
; [BP-4]: puntero a arreglo[5]
; EAX: puntero auxiliar a un elemento del vector
; EBX: otro puntero a un elemento del vector

MAIN:   MOV [0], 3

        PUSH BP
        MOV BP, SP

        MOV [4], 5
        ; [BP-4] := DS + 8
        PUSH DS
        ADD [BP-4], 8

        ; arreglo[0] = 1020
        MOV EAX, [BP-4]
        MOV [EAX], 1020

        ;arreglo[1] = arreglo[0] | 0x3FF
        MOV EBX, [BP-4]
        ADD EBX, 4
        MOV [EBX], [EAX]
        OR [EBX], 0x3FF

        ; calculo( j, arreglo)
        PUSH [BP-4]
        PUSH [0]
        CALL calculo
        ADD SP, 8

        MOV SP, BP
        POP BP
        RET
        STOP

; DOCUMENTACIÓN
; [BP+4]: x
; [BP+8]: puntero a vec[]
; EAX: un puntero a un elemento de vec
; EBX: un puntero a otro elemento de vec
; ECX: otro puntero
calculo:    PUSH BP
            MOV BP, SP
            PUSH EAX
            PUSH EBX
            PUSH ECX

            ; EAX := vec + 4x -> [EAX] := vec[x] 
            MOV EAX, 4
            MUL EAX, [BP+4]
            ADD EAX, [BP+8]

            ; EBX := vec + 4(x-1) -> [EBX] := vec[x-1]
            MOV EBX, [BP+4]
            SUB EBX, 1
            MUL EBX, 4
            ADD EBX, [BP+8]

            ; ECX := vec -> [ECX] := vec[0]
            MOV ECX, [BP+8]

            ; vec[x] = vec[x-1] & vec[0] -> [EAX] := [EBX] & [ECX]
            MOV [EAX], [EBX]
            AND [EAX], [ECX]
            
            POP ECX
            POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET