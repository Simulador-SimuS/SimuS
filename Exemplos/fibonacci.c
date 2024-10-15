/* 
Função recursiva que recebe um inteiro n >= 1
e devolve o n-ésimo termo da sequência de Fibonacci.
Arquivo: fibonacci.c 
*/
#include <stdio.h>
int fibonacci(int n) {
  int x;
  if (n == 1) return(1);
  if (n == 2) return(1);
  x = fibonacci(n-1) + fibonacci(n-2);
  return(x);
}

int main() {  // Função principal.
int n;
  while(n <= 0) {
    printf("Entre com um valor positivo: ");
    scanf("%d", &n);
  }
  printf("Resultado = %d \n", fibonacci(n));
  return(0);
}
