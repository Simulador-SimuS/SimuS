;-------------------------------
; Programa: Soma os elementos de um vetor
; Autor: Gabriel P. Silva
; Data: 08.03.2024
;-------------------------------

DISPLAY EQU 0

ORG 100
X:   	 DB    1, 2, 3, 4, 5, 6, 7, 8, 49
I:   	 DB    0
SOMA: 	 DB    0 
PTR: 	 DW    X
TAM:     DB    9

ORG 0
INICIO: 
 	 LDA   I
         SUB   TAM
         JN    TOTAL
         JMP   FIM
;
TOTAL:   LDA   SOMA
         ADD   @PTR
         STA   SOMA
         JSR   DECIMAL
;
INC:  	 LDA   I
     	 ADD   #1
     	 STA   I 
     	 LDA   PTR
     	 ADD   #1
     	 STA   PTR       ; só funciona para vetores < 256
     	 JMP   INICIO
;
FIM:     LDA   SOMA
         JSR   DECIMAL       
         HLT
         END   0
        
ORG 1000
VALOR:   DS    1
MOSTRA:  DS    1

DECIMAL: STA   VALOR   ; Rotina simplificada
         STA   MOSTRA  ; que recebe no acumulador
LACO:    SUB   #10     ; um valor hexadecimal
         JN    SAIDA   ; que será convertido para
         STA   VALOR   ; decimal e exibido no visor.
         LDA   #6      ; Só funciona para valores
         ADD   MOSTRA  ; até 99.
         STA   MOSTRA  ;
         LDA   VALOR   ;
         JMP   LACO    ;
SAIDA:   LDA   MOSTRA  ; Exibe o valor convertido
         OUT   DISPLAY ; no visor.
         RET           ; Retorna para o programa principal.
