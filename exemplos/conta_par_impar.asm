;-------------------------------
; Programa: Verifica conta valores pares ou impares
; Autor: Gabriel P. Silva
; Data: 08.03.2024
;------------------------------

ORG 100
VALOR:   DS  1
PARES:   DS  1
IMPARES: DS  1
STATUS   EQU 1
CHAVES   EQU 0
VISOR    EQU 0

ORG 0
; Verifica o status do painel de chave
LACO:
        IN      STATUS
        OR      #0
        JZ      LACO
; Faz a leitura do painel de chaves
        IN      0
        OR      #0
; Se o valor lido for igual a 0, termina o programa
        JZ      FIM
        STA     VALOR
; Testa se é par (bit 0=0)
        LDA     #1
        AND     VALOR
        JNZ     SENAO
; Se for par, faz pares++
        LDA     #1
        ADD     PARES
        STA     PARES
        JMP     LACO
SENAO:
; Se for ímpar, faz impares++
        LDA     #1
        ADD     IMPARES
        STA     IMPARES
        JMP     LACO
; Mostra o total de pares primeiros
FIM:    LDA     PARES
        OUT     VISOR
; Espera entar mais alguma coisa nas chaves (não conta)
LACO2:
        IN      STATUS
        OR      #0
        JZ      LACO2
; Mostra o total de impares agora
        LDA     IMPARES
        OUT     VISOR
        HLT
END 0        
