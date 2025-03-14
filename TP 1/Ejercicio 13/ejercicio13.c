#include <stdio.h>

void diasActivos(char byte);

int main()
{
    char byte;
    printf("Ingrese un byte: ");
    scanf("%X", &byte);
    printf("Dias activos de la semana: \n");
    diasActivos(byte);
    return 0;
}

void diasActivos(char byte)
{
    unsigned int i;
    char diasSemana[7][10] = {"Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"};
    for (i = 0; i < 7; i++)
    {
        if (byte & 0x1)
            printf("%s\n", diasSemana[i]);
        byte = byte >> 1;
    }
}