            MOV [4],0 ; Acumulador
            MOV EFX,1 ; Potencias de 2. Se inicializa en 2^0
OTRO:       MOV EDX,DS
            MOV CH,4
            MOV CL,1
            MOV AL,0x01
            SYS 1
            CMP [0], 0
            JN FIN
            JZ MULTIPLICAR
            CMP [0], 1
            JP FIN
            ADD [4],EFX
MULTIPLICAR: MUL EFX,2
            JMP OTRO
FIN:        MOV EDX,DS
            ADD EDX,4
            MOV CH,4
            MOV CL,1
            MOV AL,0x01
            SYS 2
            STOP