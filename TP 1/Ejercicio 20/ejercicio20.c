#include <stdio.h>

int main(int argc, char const *argv[])
{
    FILE *origen, *destino;
    char byte, x;
    int i = 0;
    if (argc != 4)
    {
        printf("ERROR: cantidad de parametros incorrecta");
        return 1;
    }
    origen = fopen(argv[2], "rb");
    destino = fopen(argv[3], "wb");
    if (origen == NULL || destino == NULL)
    {
        printf("ERROR: no se encontro uno de los archivos");
        return 1;
    }
    fread(&byte, 1, 1, origen);
    while (!feof(origen))
    {
        x = byte ^ argv[1][i];
        fwrite(&x, 1, 1, destino);
        fread(&byte, 1, 1, origen);
        i++;
        if (argv[1][i] == '\0')
            i = 0;
    }
    fclose(origen);
    fclose(destino);
    return 0;
}
