NULL EQU -1

; T_ArbolBB
VALOR EQU 0
IZQ EQU 4
DER EQU 8

; INVOCACIÓN
; PUSH <int>
; PUSH <T_ArbolBB *>
; CALL BUSCAR_B
; ADD SP, 8
; En EAX devuelve -1 si encontró el valor o 0 si no encontró

; DOCUMENTACIÓN
; [BP+8]: puntero a T_ArbolBB A
; [BP+12]: valor
; EAX: registro de retorno
; EBX = [BP+8] = A => [EBX] = *A y [EBX+campo] = A->campo

BUSCAR_B:   PUSH BP
            MOV BP, SP
            PUSH EBX

            MOV EBX, [BP+8]
            CMP EBX, NULL
            JNZ ELSE_BB1
                MOV EAX, 0
            JMP FIN_BB
ELSE_BB1:   CMP [EBX+VALOR], [BP+12]
            JNZ ELSE_BB2
                MOV EAX, -1
            JMP FIN_BB
ELSE_BB2:   PUSH [BP+12]
            PUSH [EBX+IZQ]
            CALL BUSCAR_B
            ADD SP, 8

            CMP EAX, -1
            JZ FIN_BB

            PUSH [BP+12]
            PUSH [EBX+DER]
            CALL BUSCAR_B
            ADD SP, 8

FIN_BB:     POP EBX
            MOV SP, BP
            POP BP
            RET