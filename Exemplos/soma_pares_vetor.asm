;---------------------------------------------------
; Programa: Soma os valores pares de um vetor
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 13/08/2023
; Arquivo: soma_pares_vetor.asm
;---------------------------------------------------
; Percorre o vetor X e acumula em PARES a soma de
; todos os elementos cujo bit 0 vale 0 (pares).
;---------------------------------------------------
ORG 100
I:      DB  0           ; Índice atual
TAM:    DB  6           ; Tamanho do vetor
PARES:  DB  0           ; Soma dos elementos pares
PT:     DW  X           ; Ponteiro móvel para o vetor
X:      DB  6, 13, 8, 10, 9, 23   ; Vetor

ORG 0
        LDA  I

LACO:   SUB  TAM        ; I = TAM ? (usando subtração acumulada)
        JZ   FIM        ; Se I = TAM, termina

        LDA  @PT        ; Carrega o elemento atual
        AND  #1         ; Testa bit 0
        JNZ  SENAO      ; Se bit 0 = 1, é ímpar: pula

        LDA  PARES      ; É par: acumula
        ADD  #1
        STA  PARES

SENAO:  LDA  PT         ; Avança o ponteiro
        ADD  #1
        STA  PT
        LDA  PT+1
        ADC  #0
        STA  PT+1

        LDA  I          ; Incrementa o índice
        ADD  #1
        STA  I
        JMP  LACO

FIM:    LDA  PARES
        OUT  0          ; Exibe o total de elementos pares
        HLT
        END  0
