; Ejercicio 2
; Librería assembler equivalente a string.h en C

; SLEN: recibe un puntero a un string y devuelve en ECX la cantidad de caracteres (sin incluir
; el terminator) del string.

; DOCUMENTACIÓN
; [BP+8]: puntero a string
; ECX: contador de caracteres
; EAX: puntero a caracter para recorrer el string
SLEN:       PUSH BP
            MOV BP, SP
            PUSH EAX

            MOV ECX, 0
            MOV EAX, [BP+8]
            ; while (cadena[i] != '\0')
OTRO_SLEN:  CMP b[EAX], 0
            JZ FIN_SLEN
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
; [BP+8]: puntero a string destino de la copia (b)
; [BP+12]: puntero a string a copiar (a)
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
; [BP+8]: puntero a string A
; [BP+12]: puntero a string B
; EBX: puntero a caracter de B
; EAX: puntero a caracter A
; ECX: registro de retorno (se pisa)

SCMP:       PUSH BP
            MOV BP, SP
            PUSH EAX
            PUSH EBX

            MOV EBX, [BP+12]
            MOV EAX, [BP+8]
            ; while ((a[i] > 0 || b[i] > 0) && a[i] == b[i])
OTRO_SCMP:  CMP b[EAX], b[EBX]
            JNZ FIN_SCMP
            CMP b[EAX], 0; Si a[i] == b[i] y a[i] == '\0' entonces b[i] también es el caracter nulo
            JZ FIN_SCMP
            ; Avanzo
                ADD EAX, 1
                ADD EBX, 1
            JMP OTRO_SCMP
FIN_SCMP:   MOV ECX, b[EAX]
            SUB ECX, b[EBX]

            POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET

; SCAT: recibe dos punteros a strings y concatena al primero el segundo (es responsabilidad
; del programador que a continuación del primer string no se pisen datos).

; DOCUMENTACIÓN
; [BP+8]: puntero a string A
; [BP+12]: puntero a string B
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
; [BP+8]: puntero a string (texto)
; [BP+12]: caracter c
; [BP+16]: puntero a vector de strings (textos)
; EAX: puntero a caracter del string
; b[EAX] = texto[i]
; EBX: puntero a la cantidad de elementos del vector
; ECX: puntero a elemento del vector textos
; [ECX] = textos[j]

; LLAMADA A FUNCIÓN
; PUSH textos
; PUSH c
; PUSH texto
; CALL SPLIT
; ADD SP, 12

SPLIT:      PUSH BP
            MOV BP, SP
            PUSH EAX
            PUSH EBX
            PUSH ECX

            ; Inicializar variables
                MOV EAX, [BP+8]
                MOV EBX, [BP+16]
                SUB EBX, 4
                MOV ECX, [BP+16]

            ; Si el caracter es justo el caracter nulo, guardar puntero a string en vector
            CMP [BP+12],0
            JNZ OTRO_SPLIT1
                MOV [EBX], 1
                MOV [ECX], [BP+8]
            JMP FIN_SPLIT
            
            ; while (texto[i] == c)
OTRO_SPLIT1: CMP b[EAX], [BP+12]
            JNZ SIGUE_SPLIT1
                MOV b[EAX], 0
                ADD EAX, 1
            JMP OTRO_SPLIT1
            ; Primer append de textos
SIGUE_SPLIT1: MOV [EBX], 1
            MOV [ECX], EAX
            ADD ECX, 4
            ; while(texto[i] != '\0')
OTRO_SPLIT2: CMP b[EAX], 0
            JZ FIN_SPLIT
                ; while(texto[i] == c)
OTRO_SPLIT3:    CMP b[EAX], [BP+12]
                JNZ FIN_CIC_SPL
                    MOV b[EAX], 0
                    ADD EAX, 1
                    ; if (texto[i] != c && texto[i] != '\0') then textos.append(&texto[i])
                    CMP b[EAX], 0
                    JZ FIN_SPLIT
                    CMP b[EAX], [BP+12]
                    JZ OTRO_SPLIT3
                        ADD [EBX], 1
                        MOV [ECX], EAX
                        ADD ECX, 4
FIN_CIC_SPL:    ADD EAX, 1
            JMP OTRO_SPLIT2 ; Fin ciclo while 2

FIN_SPLIT:  POP ECX
            POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET

; STRIM: recibe un puntero a string como parámetro variable, y devuelve el string quitando los
; espacios (white spaces) del comienzo y del final.

; CODIFICACIÓN ASCII
; espacio = 32
; tabulación = 09

; DOCUMENTACIÓN
; [BP+8]: puntero a string (texto)
; EAX, EBX: punteros a caracteres de texto (&texto[i], &texto[j])
; b[EAX] = texto[i]
; b[EBX] = texto[j]

STRIM:      PUSH BP
            MOV BP, SP
            PUSH EAX
            PUSH EBX

            MOV EAX, [BP+8]
            ; while (texto[i] != '\0')
OTRO_STRIM1: CMP b[EAX], 0
            JZ FIN_STRIM
                ; if(texto[i] == ' ' || texto[i] == '   ') then propagar onda de corrimiento
                CMP b[EAX], 32
                JZ IF_STRIM
                CMP b[EAX], 9
                JZ IF_STRIM
                JMP FIN_CIC_STRIM
IF_STRIM:           MOV EBX, EAX
                    ; while(texto[j] != '\0')
OTRO_STRIM2:        CMP b[EBX], 0
                    JZ FIN_CIC_STRIM
                        MOV b[EBX], b[EBX+1]
                        ADD EBX, 1
                    JMP OTRO_STRIM2 ; Fin ciclo while
FIN_CIC_STRIM:  ADD EAX, 1
            JMP OTRO_STRIM1; Fin ciclo while

FIN_STRIM:  POP EBX
            POP EAX
            MOV SP, BP
            POP BP
            RET