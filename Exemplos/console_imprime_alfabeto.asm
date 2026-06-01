;---------------------------------------------------
; Programa: Lê uma letra inicial do terminal e imprime
;           as 26 letras do alfabeto a partir dela
; Autor: José Antonio Borges
; Data: 2016
; Arquivo: console_imprime_alfabeto.asm
;---------------------------------------------------
; O TRAP 1 lê um caractere do terminal e retorna
; o código ASCII no acumulador E na posição de memória
; apontada pelo operando.
; O TRAP 2 escreve o caractere cujo código ASCII está
; na posição de memória apontada pelo operando.
;---------------------------------------------------
ORG 100
LETRA:  DS  1           ; Armazena a letra atual
CONTA:  DB  26          ; Contador de letras a imprimir
CR:     DB  0Dh         ; Retorno de carro
LF:     DB  0Ah         ; Avanço de linha

ORG 0
; --- Aguarda uma letra válida do terminal ---
ESPERA: LDA  #1         ; TRAP 1: lê um caractere
        TRAP LETRA      ; Resultado em ACC e em LETRA
        OR   #0         ; Testa se é NULL
        JZ   ESPERA     ; Rejeita NULL

; --- Imprime 26 letras a partir da lida ---
LOOP:   LDA  #2         ; TRAP 2: escreve um caractere
        TRAP LETRA      ; Imprime o caractere em LETRA
        LDA  LETRA
        ADD  #1
        STA  LETRA      ; Avança para a próxima letra
        LDA  CONTA
        SUB  #1
        STA  CONTA
        JNZ  LOOP       ; Repete até imprimir 26 letras

        LDA  #2         ; Imprime CR+LF ao final
        TRAP CR
        LDA  #2
        TRAP LF
        HLT
        END  0
