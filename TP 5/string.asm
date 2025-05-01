; Ejercicio 2
; Librería assembler equivalente a string.h en C

; SLEN: recibe un puntero a un string y devuelve en ECX la cantidad de caracteres (sin incluir
; el terminator) del string.

; DOCUMENTACIÓN
; [BP + 8]: puntero a string
; ECX: contador de caracteres
; EAX: puntero a caracter para recorrer el string
SLEN:       PUSH BP
            MOV BP, SP
            PUSH EAX

            MOV ECX, 0
            MOV EAX, [BP + 8]
            ; while (cadena[i] != '\0')
OTRO_SLEN:  CMP [EAX], 0
            JP FIN_SLEN
                ADD ECX, 1
                ADD EAX, 1
            JMP OTRO_SLEN
            
FIN_SLEN:   POP EAX
            MOV SP, BP
            POP BP
            RET


; SCPY: recibe dos punteros y permite copiar una cadena de caracteres de una posición de
; memoria a otra.

; DOCUMENTACIÓN
; [BP + 8]: puntero a string destino de la copia (b)
; [BP + 12]: puntero a string a copiar (a)
; EAX: puntero a caracter de a
; EBX: puntero a caracter de b
; b:= a
SCPY:       PUSH BP
            MOV BP, SP
            PUSH EAX
            PUSH EBX

            MOV EAX, [BP+12]
            MOV EBX, [BP+8]
            ; while (a[i] != '\0')
OTRO_SCPY:  CMP [EAX], 0
            JZ FIN_SCPY
                MOV [EBX], [EAX]
                ADD EAX, 1
                ADD EBX, 1
            JMP OTRO_SCPY
FIN_SCPY:   MOV EBX, 0
            POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET