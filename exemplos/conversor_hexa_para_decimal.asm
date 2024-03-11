; --------------------------------------------------------
; Programa: Converte números hexadecimais para decimal
; (simplificada, para valores entre 00 e 99)
; Autor: Gabriel P. Silva
; Data: 08.03.2024
;----------------------------------------------------------
ORG  100
VALOR:   DS   1      ;
MOSTRA:  DS   1      ;
STATUS   EQU  1      ;
VISOR    EQU  0      ;

ORG  0
INICIO:  IN   STATUS ; Verifica se dado está disponível
         OR   #0     ;
         JZ   INICIO
MAIN:    IN   0      ; Lê o valor das chaves para acumulador
         STA  MOSTRA ; Armazena o valor lido
LACO:    SUB  #10    ; Se for menor que 10
         JN   SAIDA  ; não precisa converter
         STA  VALOR  ; Armazena valor auxiliar
         LDA  #6     ;
         ADD  MOSTRA ; Incrementa de 6 a cada 10 unidades
         STA  MOSTRA ; (10 -->16)
         LDA  VALOR  ;
         JMP  LACO   ;
SAIDA:   LDA  MOSTRA ;
         OUT  VISOR  ; Mostra no visor
         HLT         ; Termina a execução
END     INICIO       ; Endereço inicial de execução
