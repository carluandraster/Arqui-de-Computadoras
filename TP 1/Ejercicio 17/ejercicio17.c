#include <stdio.h>

void aMayus(char s[]);

int main()
{
    char s[5] = "Hola";
    aMayus(s);
    printf("%s", s);
    return 0;
}

void aMayus(char s[])
{
    int i = 0;
    while (s[i] != '\0')
    {
        s[i] = s[i] & ~' ';
        i++;
    }
}