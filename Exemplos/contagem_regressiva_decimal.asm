;---------------------------------------------------
; Programa: Contador decrescente com saída em decimal
; Autor: Gabriel P. Silva
; Data: 2016
; Arquivo: contagem_regressiva_decimal.asm
;---------------------------------------------------
; Lê um valor N (0-99) das chaves e exibe a contagem
; regressiva N, N-1, ..., 0 em BCD no visor.
;
; A rotina DECIMAL converte o valor binário para BCD:
; subtrai 10 repetidamente acumulando 6 (ajuste BCD)
; na parte alta a cada dezena encontrada.
;---------------------------------------------------
ORG 0
MAIN:   IN   1          ; Aguarda dado disponível
        AND  #1
        JZ   MAIN       ; Repete enquanto não estiver pronto
        IN   0          ; ACC = valor das chaves
        STA  COUNT      ; Guarda o contador

LOOP:   JSR  DECIMAL    ; Exibe COUNT em decimal
        LDA  COUNT
        SUB  #1
        STA  COUNT      ; COUNT = COUNT - 1
        JNZ  LOOP       ; Repete enquanto COUNT > 0
        JSR  DECIMAL    ; Exibe o zero final
FIM:    HLT
        END  0

COUNT:  DS   1          ; Contador

;---------------------------------------------------
; Rotina DECIMAL
; Converte o valor no acumulador de binário para BCD
; e exibe no visor (porta 0).
; Funciona para valores de 0 a 99.
;---------------------------------------------------
ORG 300
VALOR:  DS 1
MOSTRA: DS 1

DECIMAL: STA  MOSTRA    ; Guarda o valor a exibir
         STA  VALOR     ; Cópia de trabalho
LACO:    SUB  #10       ; Subtrai 10
         JN   SAIDA     ; Se ficou negativo, acabou as dezenas
         STA  VALOR     ; Guarda o resto
         LDA  #6        ; Ajuste BCD: soma 6 no acumulador de exibição
         ADD  MOSTRA    ; (desloca o dígito das dezenas para o nibble alto)
         STA  MOSTRA
         LDA  VALOR     ; Recarrega o resto
         JMP  LACO
SAIDA:   LDA  MOSTRA    ; MOSTRA contém o valor em BCD
         OUT  0         ; Exibe no visor
         RET
