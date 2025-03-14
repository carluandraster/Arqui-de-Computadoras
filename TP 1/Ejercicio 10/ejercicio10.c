#include <stdio.h>

int main()
{
    short int n = 0x02A3;
    printf("a) %X\n", (n >> 8) & 0xFF);
    printf("b) %X\n", n & 0xFF);
    printf("c) %X\n", n & 0x1);
    printf("d) %X\n", (n >> 15) & 0x1);
    printf("e) %X\n", (n >> 4) & 0xFFF);
    printf("f) %X\n", n & 0xF);
    return 0;
}
