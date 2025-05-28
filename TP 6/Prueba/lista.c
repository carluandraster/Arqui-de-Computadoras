#include "lista.h"
#include <stdlib.h>
#include <stdio.h>

nodoL *crear_nodo(int valor)
{
    nodoL *aux = malloc(sizeof(nodoL));
    aux->valor = valor;
    aux->sig = NULL;
    return aux;
}

void inserta_ordenado(TLista *L, nodoL *nuevo_nodo)
{
    nodoL **aux = L;
    while (*aux != NULL && (*aux)->valor < nuevo_nodo->valor)
        aux = &(*aux)->sig;
    nuevo_nodo->sig = *aux;
    *aux = nuevo_nodo;
}

TLista ingresarLista()
{
    TLista aux = NULL;
    int nro;
    scanf("%d", &nro);
    while (nro > 0)
    {
        inserta_ordenado(&aux, crear_nodo(nro));
        scanf("%d", &nro);
    }
    return aux;
}

void imprimirLista(TLista L)
{
    nodoL *aux = L;
    while (aux != NULL)
    {
        printf("%d\n", aux->valor);
        aux = aux->sig;
    }
}