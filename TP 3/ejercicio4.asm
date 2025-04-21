        MOV EDX,DS
        MOV CH,4
        MOV CL,1
        MOV AL,0x01
        SYS 1
        MOV EBX,[EDX]
        SYS 1
        MOV ECX,[EDX]
        MOV EAX, 0; EBX*ECX = EAX
        CMP ECX,0
        JP POS
        JN NEG
        JZ FIN
POS:    ADD EAX,EBX
        SUB ECX,1
        CMP ECX,0
        JZ FIN
        JP POS
NEG:    SUB EAX,EBX
        ADD ECX,1
        CMP ECX,0
        JZ FIN
        JN NEG
FIN:    MOV [1],EAX
        MOV EDX,DS
        ADD EDX,1
        MOV CH,4
        MOV CL,1
        MOV AL,0x01
        SYS 2
        STOP