;---------------------------------------------------
; Programa: Testa se o valor lido das chaves é
;           par ou ímpar e incrementa o contador
;           correspondente
; Autor: Gabriel P. Silva
; Data: 2016
; Arquivo: par_impar.asm
;---------------------------------------------------
; Um número é par se o seu bit menos significativo
; for 0 (N AND 1 = 0).
;---------------------------------------------------
ORG 100
A:       DS  1       ; Valor lido das chaves
PARES:   DS  1       ; Contador de pares
IMPARES: DS  1       ; Contador de ímpares

ORG 0
INICIO: IN   1          ; Le status
        OR   #0     
        JZ   INICIO 
        IN   0          ; Lê o valor do painel de chaves
        STA  A          ; Guarda em A

        LDA  #1         ; Máscara para testar o bit 0
        AND  A          ; A AND 1: resultado 0 se par, 1 se ímpar
        JNZ  SENAO      ; Se bit 0 = 1, é ímpar

; --- É par: incrementa PARES ---
        LDA  PARES
        ADD  #1
        STA  PARES
        JMP  FIM

; --- É ímpar: incrementa IMPARES ---
SENAO:  LDA  IMPARES
        ADD  #1
        STA  IMPARES

FIM:    HLT
        END  0
