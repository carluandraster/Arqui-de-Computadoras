#include <stdio.h>

unsigned short int codificar(int anio, int mes, int dia);

int main()
{
    printf("%d", codificar(2025, 12, 25));
    return 0;
}

unsigned short int codificar(int anio, int mes, int dia)
{
    if (anio < 2000)
        return anio - 1900 | mes << 7 | dia << 11;
    else
        return anio - 2000 | mes << 7 | dia << 11;
}