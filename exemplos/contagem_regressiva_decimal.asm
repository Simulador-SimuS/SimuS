;---------------------------------------------------
; Programa: Contador descrente em decimal
; Autor: Gabriel P. Silva
; Data: 08.03.2023
;---------------------------------------------------

ORG 100
COUNT:   DS   1          ;  COUNT
STATUS   EQU  1          ;
CHAVES   EQU  0          ;
VISOR    EQU  0          ;

ORG  0
MAIN:    IN   STATUS     ;
         ADD  #0         ;
         JZ   MAIN       ; Espera um valor nas chaves
         IN   CHAVES     ; ACC = Chaves
         STA  COUNT      ;
LOOP:    JSR  DECIMAL    ; VISOR = A
         LDA  COUNT      ; 
         SUB  #1         ;
         STA  COUNT      ; COUNT = ACC
         JSR  DECIMAL    ; Desvia para a subrotina de conversão
         JNZ  LOOP       ;
FIM:     HLT             ; Termina a execução
         END  MAIN       ; Endereço inicial


ORG 300
VALOR:  DS 1
MOSTRA: DS 1

DECIMAL: STA  MOSTRA     ; Rotina para converter
         STA  VALOR      ; de hexadecimal para decimal
LACO:    SUB  #10        ; 
         JN   SAIDA      ;
         STA  VALOR      ;
         LDA  #6         ;
         ADD  MOSTRA     ;
         STA  MOSTRA     ;
         LDA  VALOR      ;
         JMP  LACO       ;
SAIDA:   LDA  MOSTRA     ;
         OUT   0         ;
         RET     
