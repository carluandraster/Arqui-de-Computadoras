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
OTRO_SLEN:  CMP b[EAX], 0
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
OTRO_SCPY:  CMP b[EAX], 0
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

; SCMP: recibe dos punteros a strings, y resta carácter a carácter (sin alterar los strings)
; hasta que exista una diferencia devolviendola en EAX o 0 si los strings son iguales.

; DOCUMENTACIÓN
; [BP + 8]: puntero a string B
; [BP + 12]: puntero a string A
; EBX: puntero a caracter de B
; EAX: puntero a caracter A
; EAX: registro de retorno

SCMP:       PUSH BP
            MOV BP, SP
            PUSH EBX

            MOV EAX, [BP+12]
            MOV EBX, [BP+8]
            ; while ((a[i] > 0 || b[i] > 0) && a[i] == b[i])
OTRO_SCMP:  CMP b[EAX], b[EBX]
            JNZ FIN_SCMP
            CMP b[EAX], 0
            JNZ SALTEAR
            CMP b[EBX], 0
            JZ FIN_SCMP
            ; Avanzo
SALTEAR:    ADD EAX, 1
            ADD EBX, 1
            JMP OTRO_SCMP
FIN_SCMP:   MOV EAX, b[EAX]
            SUB EAX, b[EBX]

            POP EBX
            MOV SP, BP
            POP BP
            RET

; SCAT: recibe dos punteros a strings y concatena al primero el segundo (es responsabilidad
; del programador que a continuación del primer string no se pisen datos).

; DOCUMENTACIÓN
; [BP + 8]: puntero a string A
; [BP + 12]: puntero a string B
; EAX: puntero a un caracter de string A
; EBX: puntero a un caracter de string B

SCAT:       PUSH BP
            MOV BP, SP
            PUSH EAX
            PUSH EBX

            MOV EAX, [BP+8]
            MOV EBX, [BP+12]
            ; while(a[i] != '\0')
OTRO_SCAT1: CMP b[EAX], 0
            JZ OTRO_SCAT2
                ADD EAX, 1
            JMP OTRO_SCAT1
            ; while(b[j] != '\0')
OTRO_SCAT2: CMP EBX, 0
            JZ FIN_SCAT
                MOV b[EAX], b[EBX]
                ADD EAX, 1
                ADD EBX, 1
            JMP OTRO_SCAT2
FIN_SCAT:   MOV b[EAX], 0

            POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET

; SPLIT: recibe un puntero a string, un carácter, y un puntero a un array de punteros. Divide el
; strings en varios strings reemplazando el carácter por el terminator y completa el array de
; punteros con el puntero al primer carácter de cada string, utilizando -1 para marcar el fin.

; DOCUMENTACIÓN
; [BP+8]: puntero a string
; [BP+12]: caracter
; [BP+16]: puntero a array de strings
; EAX: puntero a caracter del string

SPLIT:      PUSH BP
            MOV BP, SP
            PUSH EAX

            ; Si el caracter es justo el caracter nulo, no hay nada que hacer
            CMP [BP+12],0
            JZ FIN_SPLIT
            
            MOV EAX, [BP+8]
            ; while (texto[i] == c)
OTRO_SPLIT1: CMP b[EAX], [BP+12]