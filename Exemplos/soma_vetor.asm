;---------------------------------------------------
; Programa: Soma os elementos de um vetor e exibe
;           o resultado no visor hexadecimal
; Autor: Gabriel P. Silva
; Data: 2017
; Arquivo: soma_vetor.asm
;---------------------------------------------------
; Usa um ponteiro (PTR) para percorrer o vetor e
; acumula a soma em SOMA.
;---------------------------------------------------
DISPLAY EQU 0

ORG 100
X:      DB  1, 2, 3, 4, 5, 6, 7, 8, 9   ; Vetor com 9 elementos
I:      DB  0           ; Índice do elemento atual
SOMA:   DB  0           ; Acumulador da soma
PTR:    DW  X           ; Ponteiro móvel para o vetor
TAM:    DB  9           ; Número de elementos

ORG 0
INICIO:
        LDA  I
        SUB  TAM        ; Compara I com TAM
        JN   TOTAL      ; Se I < TAM, continua somando
        JMP  FIM        ; Senão exibe o resultado final

TOTAL:  LDA  SOMA
        ADD  @PTR       ; SOMA = SOMA + X[I]
        STA  SOMA

INC:    LDA  I          ; Incrementa o índice
        ADD  #1
        STA  I
        LDA  PTR        ; Avança o ponteiro
        ADD  #1
        STA  PTR
        LDA  PTR+1
        ADC  #0
        STA  PTR+1
        JMP  INICIO

FIM:    LDA  SOMA
        OUT  DISPLAY    ; Exibe a soma no visor
        HLT
        END  0
