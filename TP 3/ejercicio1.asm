        MOV EFX, 0 ; Inicializo contador
        MOV [4], 0 ; Inicializo acumulador
OTRO:   MOV EDX, DS; Apunto EDX a la primera posición del Data Segment para guardar lo ingresado por teclado
        MOV CH, 4; Voy a ingresar una celda de 4 bytes
        MOV CL, 1; Una sola celda
        MOV AL, 0x01; Tipo de dato decimal
        SYS 1; Llamada al sistema para lectura
        CMP [EDX],0; Comparo el valor apuntado en EDX con 0 para saber si es negativo.
        JN SIGUE; Si es negativo, que salte a la sección 'SIGUE' para cortar con el bucle
        ADD [4],[EDX]; Acumular lo ingresado por teclado
        ADD EFX, 1; Contar número
        JMP OTRO; Volver a iterar para ingresar un número
SIGUE:  CMP EFX, 0; Verifico si el contador es 0
        JZ FIN; Si el contador es 0, no hago la división
        DIV [4],EFX; Hago acumulador/contador y al resultado lo almaceno en [4]. Resulta que [4] ahora es el promedio y no el acumulador
FIN:    MOV EDX, DS ; Apunto EDX a DS
        ADD EDX, 4 ; Apunto EDX a [4] = [DS + 4] para mostrarlo
        MOV CH, 4; Voy a mostrar una celda de 4 bytes
        MOV CL, 1; Solo una celda
        MOV AL, 0x01; Tipo de dato decimal
        SYS 2; Muestro promedio por pantalla
        STOP; Fin del programa