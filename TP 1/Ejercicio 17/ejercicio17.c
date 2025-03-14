#include <stdio.h>

char aMayus(char *letra);

int main()
{
    char letra;
    printf("%s", aMayus("Hola"));
    return 0;
}

char aMayus(char *letra)
{
    return *letra & ~' ';
}