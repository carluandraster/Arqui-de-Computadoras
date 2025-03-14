#include <stdio.h>
#define MAXCAR 19

void pasarABinario(int nro, char s[MAXCAR]);

int main()
{
    char s[MAXCAR];
    int nro;
    printf("Ingrese un numero: ");
    scanf("%d", &nro);
    pasarABinario(nro, s);
    printf("%X = %s", nro, s);
    return 0;
}

void pasarABinario(int nro, char s[MAXCAR])
{
    int i;
    s[MAXCAR] = '\0';
    for (i = MAXCAR - 1; i >= 0; i--)
    {
        if (i == 4 || i == 9 || i == 14)
            s[i] = ' ';
        else
        {
            s[i] = (nro & 0x1) + 48;
            nro = nro >> 1;
        }
    }
}