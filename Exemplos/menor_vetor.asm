;---------------------------------------------------
; Programa: Encontra o menor elemento de um vetor
;           e calcula a soma de todos os elementos
; Autor: Thales de Freitas
; Data: 02/05/2016
; Arquivo: menor_vetor.asm
;---------------------------------------------------
; Percorre o vetor A e mantém em MIN o menor valor
; encontrado. Ao mesmo tempo acumula a soma total.
; Ambos são exibidos no visor ao final.
;---------------------------------------------------
ORG 100
PT:     DW  A           ; Ponteiro móvel para o vetor
MIN:    DS  1           ; Menor valor encontrado
SOMA:   DB  0           ; Soma de todos os elementos
I:      DB  0           ; Índice atual
DEZ:    DB  10          ; Tamanho do vetor
A:      DB  6, 2, 2, 3, 1, 5, 6, 7, 8, 9

ORG 0
INICIO:
        LDA  @PT        ; MIN = A[0]
        STA  MIN
        STA  SOMA       ; SOMA começa com A[0]
        JMP  TESTE

FOR:    LDA  PT         ; PT = PT + 1
        ADD  #1
        STA  PT
        LDA  PT+1
        ADC  #0
        STA  PT+1

        LDA  MIN
        SUB  @PT        ; MIN - A[I]: se negativo, A[I] > MIN (não troca)
        JN   PULA       ; Pula se MIN < A[I]
        LDA  @PT        ; Senão: MIN = A[I]
        STA  MIN

PULA:   LDA  SOMA       ; SOMA = SOMA + A[I]
        ADD  @PT
        STA  SOMA

TESTE:  LDA  I          ; I = I + 1
        ADD  #1
        STA  I
        SUB  DEZ        ; I < 10 ?
        JN   FOR        ; Se verdade continua no laço

        LDA  MIN        ; Exibe o menor elemento
        OUT  0
        LDA  SOMA       ; Exibe a soma total
        OUT  0
        HLT
        END  0
