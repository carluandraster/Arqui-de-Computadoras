#include <stdio.h>

void imprimirFecha(int fecha);

int main()
{
    int fecha = 52761;
    imprimirFecha(fecha);
    return 0;
}

void imprimirFecha(int fecha)
{
    int anio = fecha & 0x7F;
    if (anio > 50)
        printf("%u-%u-%u", 1900 + anio, (fecha >> 7) & 0xF, fecha >> 11);
    else
        printf("%u-%u-%u", 2000 + anio, (fecha >> 7) & 0xF, fecha >> 11);
}