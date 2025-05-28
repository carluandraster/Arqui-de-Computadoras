; Librería de subrutinas que permiten administrar listas dinámicas simplemente enlazadas de números enteros

\\INCLUDE "alloc.asm"

VALOR EQU 0
SIG EQU 4
PRUEBA EQU "Se ha detectado una iteracion\n"

; crear_nodo recibe un valor de 4 bytes por parámetro y devuelve en EAX el puntero al nodo
; El campo siguiente del nodo es null

; INVOCACIÓN
; PUSH <int>
; CALL crear_nodo
; ADD SP, 4
; En EAX devuelve puntero a nodo

; DOCUMENTACIÓN
; [BP+8]: valor pasado como parámetro
; EAX: registro de retorno

crear_nodo: PUSH BP
            MOV BP, SP
            
            PUSH 8
            CALL ALLOC
            ADD SP, 4
            CMP EAX, NULL
            JZ FIN_CREAR

            MOV [EAX+VALOR], [BP+8]
            MOV [EAX+SIG], null

FIN_CREAR:  MOV SP, BP
            POP BP
            RET

; inserta_ordenado recibe una lista y un puntero a nodo como parámetros y, según la clave del nodo, inserta en la lista de tal manera que siga ordenada
; Asume por precondición que la lista, de ser distina de null, ya está ordenada

; INVOCACIÓN
; PUSH <nodoL*>
; PUSH <nodoL**>
; CALL inserta_ordenado
; ADD SP, 8
; No devuelve nada (función void)

; DOCUMENTACIÓN
; [BP+8]: lista: nodoL** => *lista = [[BP+8]]
; [BP+12]: nuevo_nodo: nodoL* => nuevo_nodo->valor = [[BP+12]+VALOR] y nuevo_nodo->sig = [[BP+12]+SIG]
; EAX := iterador auxiliar (nodoL** aux) => [[EAX]+VALOR] = (*aux)->valor y [[EAX]+SIG] = (*aux)->sig
; EBX = [EAX] = *aux => (*aux)->valor = [EBX+VALOR]
; ECX = [BP+12] => nuevo_nodo->valor = [ECX+VALOR]

inserta_ordenado:   PUSH BP
                    MOV BP, SP
                    PUSH EAX
                    PUSH EBX
                    PUSH ECX

                    MOV EAX, [BP+8]
                    
OTRO_INSORD:        CMP [EAX], null
                    JZ SIGUE_INSORD

                    MOV EBX, [EAX]
                    MOV ECX, [BP+12]

                    CMP [EBX+VALOR], [ECX+VALOR]
                    JNN SIGUE_INSORD
                        MOV EAX, EBX
                        ADD EAX, SIG
                    JMP OTRO_INSORD

SIGUE_INSORD:       MOV [ECX+VALOR], [EAX]
                    MOV [EAX], [BP+12]

                    POP ECX
                    POP EBX
                    POP EAX
                    MOV SP, BP
                    POP BP
                    RET

; remover es una subrutina que recibe un valor numérico como parámetro y remueve los nodos de la lista que contengan a ese número
; Asume lista ordenada aunque también considera la posibilidad de que esté más de una vez

; INVOCACIÓN
; PUSH <int>
; PUSH < nodoL**>
; CALL remover
; ADD SP, 8
; No devuelve nada (función void)

; DOCUMENTACIÓN
; [BP+8]: L (puntero a lista o doble puntero a nodo)
; [BP+12]: valor (entero)
; [BP-4]: variable local auxiliar aux: nodoL**
; EAX = [BP-4] => [EAX] = *aux: nodoL* (1)
; EBX = [EAX] + VALOR => [EBX] = [[EAX] + VALOR] = (*aux)->valor (2)
; ECX = [EAX] + SIG => [ECX] = [[EAX] + SIG] = (*aux)->sig (3)

remover:    PUSH BP
            MOV BP, SP
            PUSH [BP+8]
            PUSH EAX
            PUSH EBX
            PUSH ECX

otro_rem1:  MOV EAX, [BP-4]; Por (1)

            ; Por (2)
            MOV EBX, [EAX]
            ADD EBX, VALOR

            ; Por (3)
            MOV ECX, [EAX]
            ADD ECX, SIG

            CMP [EAX], null
            JZ otro_rem2
            CMP [EBX], [BP+12]
            JNN otro_rem2
                MOV [BP-4], [ECX]
            JMP otro_rem1

            ; Por (2)
otro_rem2:  MOV EBX, [EAX]
            ADD EBX, VALOR

            ; Por (3)
            MOV ECX, [EAX]
            ADD ECX, SIG

            CMP [EAX], null
            JZ FIN_REM
            CMP [EBX], [BP+12]
            JZ FIN_REM
                MOV [EAX], [ECX]
            JMP otro_rem2

FIN_REM:    POP ECX
            POP EBX
            POP EAX
            ADD SP, 4
            MOV SP, BP
            POP BP
            RET

; buscar es una función que recibe como parámetros una lista ordenada y un valor de 4 bytes y devuelve, en caso de 
; encontrar una coincidencia, devuelve un puntero al nodo y, en caso de no encontrarse coincidencias, devuelve null

; INVOCACIÓN
; PUSH <int>
; PUSH <nodoL *>
; CALL buscar
; ADD SP, 8
; Devuelve resultado en EAX

; DOCUMENTACIÓN
; [BP+8]: lista (puntero al primer nodo). Se supone que está ordenada
; [BP+12]: valor entero
; [BP-4]: variable auxiliar. Es un puntero a nodo que sirve para recorrer la lista. Lo llamaremos aux
; [BP-4] = aux => *aux = [[BP-4]] => es necesario un registro
; EBX = [BP-4] => [EBX] = *aux (1)
; &aux->valor = aux + VALOR = EBX + VALOR => aux->valor = [EBX+valor]
; aux->sig = [EBX+sig]
; No es necesario más registros

buscar: PUSH BP
        MOV BP, SP
        PUSH [BP+8]; Variable auxiliar
        PUSH EBX

otro_b: MOV EBX, [BP-4]; Por (1)
        CMP [EBX], NULL
        JZ sigue_b
        CMP [EBX+VALOR], [BP+12]
        JNN sigue_b
            MOV [BP-4], [EBX+SIG]
        JMP otro_b

sigue_b: CMP [BP-4], NULL
        JZ SI_B
        CMP [EBX+VALOR],[BP+12]
        JNZ NO_B
SI_B:       MOV EAX, [BP-4]
            JMP FIN_B
NO_B:       MOV EAX, NULL
            JMP FIN_B

FIN_B:  POP EBX
        ADD SP, 4
        MOV SP, BP
        POP BP
        RET

; imprimir es una subrutina que recibe una lista e imprime por pantalla los valores de los nodos

; INVOCACIÓN
; PUSH <nodoL*>
; CALL imprimir
; ADD SP, 4
; No devuelve nada (función void)

; DOCUMENTACIÓN
; [BP+8]: lista L
; [BP-4]: variable auxiliar para recorrer la lista (de ahora en adelante, aux)
; EDX: puntero para mostrar número por pantalla
; AL: formato
; CX: celdas y tamaño de las mismas
; &aux-> valor = &aux + valor = [BP-4] + valor => aux->valor = [[BP-4] + valor]
; De la misma forma, aux->sig = [[BP-4] + sig]
; Es necesario usar registro para direccionar ambos campos
; EDX := [BP-4] + valor => [EDX] = [[BP-4] + valor] = aux->valor (1)
; EFX := [BP-4] + sig => [EFX] = [[BP-4] + sig] = aux->sig (2)

imprimir:   PUSH BP
            MOV BP, SP
            PUSH [BP+8]
            PUSH AL
            PUSH CX
            PUSH EDX
            PUSH EFX

otro_imp:   CMP [BP-4], NULL
            JZ FIN_IMP
                MOV EDX, KS
                ADD EDX, PRUEBA
                SYS 4

                ; Por (1)
                MOV EDX, [BP-4]
                ADD EDX, VALOR

                ; Por (2)
                MOV EFX, [BP-4]
                ADD EFX, SIG

                MOV AL, 1
                MOV CL, 1
                MOV CH, 4
                SYS 2

                MOV [BP-4], [EFX]
            JMP otro_imp

FIN_IMP:    POP EFX
            POP EDX
            POP CX
            POP AL
            ADD SP, 4
            MOV SP, BP
            POP BP
            RET