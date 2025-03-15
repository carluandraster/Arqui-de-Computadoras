#include <stdio.h>
#include <stdlib.h>

int suma(int A, int B);
int and (int A, int B);
int copiar(int A, int B);
int complemento(int A, int B);

typedef int (*Operacion)(int, int);

int main(int argc, char const *argv[])
{
    int opcion = atoi(argv[1]);
    Operacion opciones[] = {suma, and, copiar, complemento};
    if (opcion > 3)
    {
        printf("error operacion invalida");
        return 1;
    }
    else if (argc < 3)
    {
        printf("error falta el parametro A");
        return 1;
    }
    else if (argc == 3 && opcion < 2)
    {
        printf("error falta el parametro B");
        return 1;
    }
    else if (argc > 4)
    {
        printf("error demasiados argumentos");
        return 1;
    }
    else
    {
        printf("%d", opciones[opcion](atoi(argv[2]), (argc > 3) ? atoi(argv[3]) : 0));
        return 0;
    }
}

int suma(int A, int B)
{
    return A + B;
}

int and (int A, int B)
{
    return A & B;
}

int copiar(int A, int B)
{
    return A;
}

int complemento(int A, int B)
{
    return ~A;
}