NULL EQU -1
VALOR EQU 0
SIG EQU 4
NullPointerException EQU "NullPointerException\n"

; La siguiente función, como su nombre lo indica, invierte el orden de una lista

; INVOCACIÓN
; PUSH <nodoL**>
; CALL invertir
; ADD SP, 4
; No devuelve nada

; DOCUMENTACIÓN
; [BP+8]: puntero a lista L (doble puntero a nodo)
; EAX: puntero a nodo extraído
; EBX: longitud de la lista
; ECX = [BP+8] => [ECX] = *L
; EDX: contador i
; EEX = EAX+SIG

INVERTIR:   PUSH BP
            MOV BP, SP

            PUSH EAX
            PUSH EBX
            PUSH ECX
            PUSH EDX
            PUSH EEX

            ; EBX := length(*L)
            MOV ECX, [BP+8]
            PUSH [ECX]
            CALL length
            ADD SP, 4
            MOV EBX, EAX

            ; for(i = 1, i<length(*L), i++)
            MOV EDX, 1
OTRO_INV:   CMP EDX, EBX
            JNN SIGUE_INV
                PUSH EDX
                PUSH [BP+8]
                CALL EXTRAER_NODO
                ADD SP, 8
                
                MOV EEX, EAX
                ADD EEX, SIG
                MOV EEX, [ECX]
                MOV [ECX], EAX
            ADD EDX, 1
            JMP OTRO_INV

SIGUE_INV:  POP EEX
            POP EDX
            POP ECX
            POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET

; La siguiente funcion recibe una lista y devuelve su longitud

; INVOCACIÓN
; PUSH <nodoL*>
; CALL length
; ADD SP, 4
; Devuelve resultado en EAX

; DOCUMENTACIÓN
; [BP+8]: lista
; EAX: contador
; [BP-4]: iterador aux
; &aux->sig = aux + sig = [BP-4] + sig => aux->sig = [[BP-4] + sig] = [EBX]
; EBX: [BP-4]+sig

length:     PUSH BP
            MOV BP, SP

            PUSH [BP+8]
            PUSH EBX
            
            MOV EAX, 0

OTRO_LEN:   CMP [BP-4], NULL
            JZ SIGUE_LEN
                ADD EAX, 1
                MOV EBX, [BP-4]
                ADD EBX, SIG
                MOV [BP-4], [EBX]
            JMP OTRO_LEN

SIGUE_LEN:  POP EBX
            ADD SP, 4
            MOV SP, BP
            POP BP
            RET

; extraer_nodo remueve un nodo por su índice de una lista y devuelve su puntero

; INVOCACIÓN
; PUSH <int>
; PUSH <nodoL**>
; CALL EXTRAER_NODO
; ADD SP, 8
; En EAX devuelve resultado

; DOCUMENTACIÓN
; [BP+8]: puntero a lista L
; [BP+12]: indice entero
; [BP-4]: doble puntero a nodo aux
; EAX: registro de resultado
; EBX: numero de iteracion ii
; ECX = [BP-4] => [ECX] = *aux

EXTRAER_NODO:   PUSH BP
                MOV BP, SP

                PUSH [BP+8]
                PUSH EBX
                PUSH ECX
                PUSH EDX

                ; while(*aux != null && ii<i)
                MOV EBX, 0
OTRO_EXT_NODO:  MOV ECX, [BP-4]
                CMP [ECX], NULL
                JZ EXCEPTION
                CMP EBX, [BP+12]
                JNN RESULTADO
                    MOV EDX, [ECX]
                    ADD EDX, SIG
                    MOV [BP-4], [EDX]
                    ADD EBX, 1
                JMP OTRO_EXT_NODO
EXCEPTION:      MOV EDX, KS
                ADD EDX, NullPointerException
                SYS 4
                JMP FIN_EXT
RESULTADO:      MOV ECX, [BP-4]
                MOV EAX, [ECX]
                MOV EBX, [EAX]
                ADD EBX, SIG
                MOV [EAX], [EBX]
                
FIN_EXT:        POP EDX
                POP ECX 
                POP EBX
                ADD SP, 4
                MOV SP, BP
                POP BP
                RET