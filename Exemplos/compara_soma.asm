;---------------------------------------------------
; Programa que lê dois números e, controlado por opção,
;    calcula o maior, o menor, a soma e a subtração
; Autor: Antonio Borges
; Data:  30/07/2023
; Arquivo: compara_soma.asm
;---------------------------------------------------
          ORG     0
INICIO:
          LDS     #FIM_PILHA   ; valor inicial do 
                               ; apontador de pilha (SP)
          JSR     LE_VALOR     ; n1 = le_valor()
          STA     N1
          JSR     LE_VALOR     ; n2 = le_valor()
          STA     N2
TESTA_OPCOES:
          JSR     LE_VALOR     ; opcao = le_valor()
          STA     OPCAO
          SUB     #0           ; caso a opção seja
          JZ      MOSTRA_MAIOR ; 0: mostra o maior
          LDA     OPCAO
          SUB     #1
          JZ      MOSTRA_MENOR ; 1: mostra o menor
          LDA     OPCAO
          SUB     #2
          JZ      MOSTRA_SOMA  ; 2: mostra a soma
          LDA     OPCAO
          SUB     #3
          JZ      MOSTRA_DIFER ; 3: mostra a diferença
          LDA     #0FFH        ; senão mostra FF no visor
          OUT     VISOR
          HLT                  ; termina   
;---Mostra o maior---------------------
MOSTRA_MAIOR:
          LDA     N1
          SUB     N2
          JC      N2MAIOR
          LDA     N1
          OUT     VISOR
          HLT
N2MAIOR:
          LDA     N2
          OUT     VISOR
          HLT
;---Mostra o menor---------------------
MOSTRA_MENOR:
          LDA     N2
          SUB     N1
          JC      N2MENOR
          LDA     N1
          OUT     VISOR
          HLT
N2MENOR:
          LDA     N2
          OUT     VISOR
          HLT
;---Mostra a soma----------------------
MOSTRA_SOMA:
          LDA     N1
          ADD     N2
          OUT     VISOR
          HLT
;---Mostra a diferenca----------------
MOSTRA_DIFER:
          LDA     N1
          SUB     N2
          OUT     VISOR
          HLT
;---Rotina que le valor das chaves---
LE_VALOR:
          IN      STATUS      ; espera status bit 1 ligado
          AND     #1
          JZ      LE_VALOR
          IN      CHAVES      ; le chaves, deixa no acumulador
          OUT     VISOR       ; e no visor   
          RET                 ; retorna
;--- Variáveis ---------------------
N1:       DS      1
N2:       DS      1
OPCAO:    DS      1
CHAVES    EQU     0
STATUS    EQU     1
VISOR     EQU     0
FIM_PILHA EQU     100H
          END     INICIO
