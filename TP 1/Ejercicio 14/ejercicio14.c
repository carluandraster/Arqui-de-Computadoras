#include <stdio.h>
#include <math.h>

void menu(short int *);
void weekday_set(char *, short int);
void weekday_reset(char *, short int);
void diasActivos(char byte);

int main()
{
    short int respuesta;
    short int nro;
    char byte = 0;

    menu(&respuesta);
    while (respuesta != 4)
    {
        if (respuesta == 1)
        {
            do
            {
                printf("Ingrese el nro del dia de la semana que desea activar: ");
                scanf("%d", &nro);
            } while (nro > 6 || nro < 0);
            weekday_set(&byte, nro);
        }
        else if (respuesta == 2)
        {
            do
            {
                printf("Ingrese el nro del dia de la semana que desea desactivar: ");
                scanf("%d", &nro);
            } while (nro > 6 || nro < 0);
            weekday_reset(&byte, nro);
        }
        else
        {
            printf("Dias activos de la semana: \n");
            diasActivos(byte);
        }
        menu(&respuesta);
    }

    return 0;
}

void menu(short int *respuesta)
{
    printf("MENU DE OPCIONES\n");
    printf("Seleccione una de las siguientes opciones\n");
    printf("1 - Activar un dia de la semana\n");
    printf("2 - Desactivar un dia de la semana\n");
    printf("3 - Ver los dias activos de la semana\n");
    printf("4 - Salir\n");
    scanf("%d", respuesta);
    while (*respuesta > 4 || *respuesta < 1)
    {
        printf("La opcion ingresada no es valida. Por favor, ingresela de nuevo.\n");
        scanf("%d", respuesta);
    }
}

void weekday_set(char *byte, short int n)
{
    *byte = *byte | (int)pow(2, n);
}

void weekday_reset(char *byte, short int n)
{
    *byte = *byte & ~(int)pow(2, n);
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