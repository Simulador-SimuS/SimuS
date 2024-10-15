;---------------------------------------------------
; Exemplo de cálculo da série de Fibonacci com 
; subrotina recursiva (16 bits)
; Autores: Gabriel P. Silva e Antonio Borges
; Data: 01/08/2023
; Arquivo: fibonacci.asm
;----------------------------------------------------
      ORG     0
      LDS     #300h          ; Inicializa a posição da pilha
      LDA     #10            ; Valor de N (exemplo: N = 10)
      JSR     FIB            ; Subrotina para calcular Fibo
      POP                    ; Tira resultado da pila
      OUT     VISOR          ; Imprime em hexadecimal
      HLT
;-----------------------------
FIB:  
      PUSH                    ; Coloca n na pilha
      SUB     #1              ; Compara n com 1        
      JZ      FIB_ONE         ; Se n = 1, pula para fib_one
      SUB     #1              ; Compara n com um
      JZ      FIB_TWO         ; Se n = 2, pula para fib_two
      POP                     ; Tira n da pilha
      SUB     #1              ; Decrementa n
      PUSH                    ; Coloca n-1 de volta na pilha
      JSR     FIB             ; Chamada recursiva para n-1
      POP                     ; Retira resultado da pilha
      STA     FIB_N_1         ; Armazena o resultado
      POP                     ; Retira n-1 da pilha 
      SUB     #1              ; Subtrai 1 de n-1
      STA     TEMP            ; Salva n-2 em temp
      LDA     FIB_N_1         ; Carrega fib_n_1 no acumulador
      PUSH                    ; Salva fib_n_1 na pilha
      LDA     TEMP            ; Recarrega n-2
      JSR     FIB             ; Chamada recursiva para n-2
      POP                     ; Retira resultado da pilha
      STA     FIB_N_2         ; Salva o resultado em fib_n_2
      POP                     ; retira fib_n_1 da pilha
      ADD     FIB_N_2         ; Soma fib(n-1) e fib(n-2)
      STA     FIB_RESULT      ;
      POP                     ;
      STA     RA              ; Salva endereço de retorno
      POP                     ;
      STA     RA+1            ;
      LDA     FIB_RESULT      ; Carrega resultado
      PUSH                    ; Salva na pilha
      LDA     RA+1            ;
      PUSH                    ; Restaura endereço de retorno
      LDA      RA 
      PUSH
      RET                     ; Retorna
FIB_ONE:
FIB_TWO:
      POP                     ; Retira n da pilha
      POP                     ;
      STA      RA             ; Salva endereço de retorno
      POP                     ;
      STA      RA+1           ;
      LDA      #1             ; Carrega 1  
      PUSH                    ; Salva na pilha
      LDA      RA+1           ;
      PUSH                    ; Restaura endereço de retorno
      LDA      RA 
      PUSH
      RET                     ; Retorna 
;------------------------------------
VISOR       EQU     0

N:          DB      0          ; Variáveis usadas na subrotina
FIB_N_1:    DW      0
FIB_N_2:    DW      0
TEMP:       DW      0
RA:         DW      0
FIB_RESULT: DW      0

            END  0
