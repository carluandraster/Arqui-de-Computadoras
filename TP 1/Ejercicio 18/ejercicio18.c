#include <stdio.h>
#include <math.h>

int aInt(char s[]);

int main()
{
    printf("%d", aInt("-23"));
    return 0;
}

int aInt(char s[])
{
    int i = 1, j = 0, acum = 0;
    // Buscar el final
    while (s[i] != '\0' && s[i] >= '0' && s[i] <= '9')
        i++;
    if (s[i] != '\0')
        return 0;
    else
    {
        i--;
        while (i > 0)
        {
            acum += (s[i] & 0xF) * pow(10, j);
            i--;
            j++;
        }
        if (s[0] == '-')
            return -acum;
        else if (i > 0 || s[0] < '0' || s[0] > '9')
            return 0;
        else
            return acum + (s[0] & 0xF) * pow(10, j);
    }
}