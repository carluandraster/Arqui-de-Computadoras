typedef struct nodoL
{
    int valor;
    struct nodoL *sig;
} nodoL;

typedef nodoL *TLista;

nodoL *crear_nodo(int valor);
void inserta_ordenado(TLista *L, nodoL *nuevo_nodo);
TLista ingresarLista();
void imprimirLista(TLista L);