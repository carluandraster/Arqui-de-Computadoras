\\INCLUDE "alloc.asm"

CLAVE EQU 0
IZQ EQU 4
DER EQU 8

; INVOCACIÓN
; PUSH <int>
; CALL CREAR_NODO_ARB
; En EAX devuelve puntero a nodo

CREAR_NODO_ARB: PUSH BP
                MOV BP, SP

                PUSH 12
                CALL ALLOC
                ADD SP, 4
                CMP EAX, NULL
                JZ FIN_CREAR

                MOV [EAX+CLAVE], [BP+8]
                MOV [EAX+IZQ], null
                MOV [EAX+DER], null

FIN_CREAR_ARB:  MOV SP, BP
                POP BP
                RET

; INVOCACIÓN
; PUSH <int>
; PUSH <nodoA**>
; CALL agregarNodo
; ADD SP, 8
; No devuelve nada

; DOCUMENTACIÓN
; [BP+8]: puntero a arbol A
; [BP+12]: clave
; EAX: respuesta de crear_nodo_arb
; EBX = [BP+8] = A => [EBX] = *A y [EBX+campo] = (*A)->campo

agregarNodo:    PUSH BP
                MOV BP, SP
                PUSH EAX
                PUSH EBX

                MOV EBX, [NP+8]

                CMP [EBX], NULL
                JZ ELSE_AN1
                    PUSH [BP+12]
                    CALL CREAR_NODO_ARB
                    ADD SP, 4
                    MOV [EBX], EAX
                JMP FIN_AN
ELSE_AN1:       CMP [BP+12], [EBX+CLAVE]
                JP ELSE_AN2
                    PUSH [BP+12]
                    MOV EAX, [BP+8]
                    ADD EAX, IZQ
                    PUSH EAX
                    CALL agregarNodo
                    ADD SP, 8
                JMP FIN_AN
ELSE_AN2:           PUSH [BP+12]
                    MOV EAX, [BP+8]
                    ADD EAX, DER
                    PUSH EAX
                    CALL agregarNodo
                    ADD SP, 8

FIN_AN:         POP EBX
                POP EAX
                MOV SP, BP
                POP BP
                RET

;----------------------------------------
; imprime en in-order árbol binario de búsqueda (BST)
; parámetros: 
;  +8 puntero simple a root
;----------------------------------------
; invocación:
; push  <*root>
; call  inorder
; add   sp,4
; (no devuelve nada)
;----------------------------------------

inorder:        push    bp
                mov     bp, sp
                push    eax
                push    ebx
                push    ecx
                push    edx

                mov     ebx, [bp+8]     ; *root
                
                cmp     ebx, null
                jz      inorder_end

                ; llamo por izquierda
                push    [ebx+left]
                call    inorder
                add     sp, 4

                ; preparo en edx la dirección de la variable aux
                mov     edx, ebx
                add     edx, val    
                mov     eax, 0x0001
                mov     ecx, 0x0401
                sys     0x0002

                ; llamo por derecha
                push    [ebx+right]
                call    inorder
                add     sp, 4

inorder_end:    pop     edx
                pop     ecx
                pop     ebx
                pop     eax
                mov     sp, bp
                pop     bp
                ret

;----------------------------------------
; imprime en pre-order árbol binario de búsqueda (BST)
; parámetros: 
;  +8 puntero simple a root
;----------------------------------------
; invocación:
; push  <*root>
; call  preorder
; add   sp,4
; (no devuelve nada)
;----------------------------------------

preorder:       push    bp
                mov     bp, sp
                push    eax
                push    ebx
                push    ecx
                push    edx

                mov     ebx, [bp+8]     ; *root
                
                cmp     ebx, null
                jz      preorder_end

                ; preparo en edx la dirección de la variable aux
                mov     edx, ebx
                add     edx, val    
                mov     eax, 0x0001
                mov     ecx, 0x0401
                sys     0x0002

                ; llamo por izquierda
                push    [ebx+left]
                call    preorder
                add     sp, 4

                ; llamo por derecha
                push    [ebx+right]
                call    preorder
                add     sp, 4

preorder_end:   pop     edx
                pop     ecx
                pop     ebx
                pop     eax
                mov     sp, bp
                pop     bp
                ret

;----------------------------------------
; imprime en post-order árbol binario de búsqueda (BST)
; parámetros: 
;  +8 puntero simple a root
;----------------------------------------
; invocación:
; push  <*root>
; call  postorder
; add   sp,4
; (no devuelve nada)
;----------------------------------------

postorder:      push    bp
                mov     bp, sp
                push    eax
                push    ebx
                push    ecx
                push    edx

                mov     ebx, [bp+8]     ; *root
                
                cmp     ebx, null
                jz      postorder_end

                ; llamo por izquierda
                push    [ebx+left]
                call    postorder
                add     sp, 4

                ; llamo por derecha
                push    [ebx+right]
                call    postorder
                add     sp, 4

                ; preparo en edx la dirección de la variable aux
                mov     edx, ebx
                add     edx, val    
                mov     eax, 0x0001
                mov     ecx, 0x0401
                sys     0x0002

postorder_end:  pop     edx
                pop     ecx
                pop     ebx
                pop     eax
                mov     sp, bp
                pop     bp
                ret

; La funcion esta solicita un número e informar si el mismo se encuentra o no en el árbol.

; INVOCACIÓN
; PUSH <int>
; PUSH <nodoA*>
; CALL esta
; ADD SP, 8
; Devuelve resultado en EAX

; DOCUMENTACIÓN
; [BP-4]: 