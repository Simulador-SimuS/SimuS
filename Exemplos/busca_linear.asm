;---------------------------------------------------
; Programa: Busca linear em um vetor
; Arquivo: busca_linear.asm
;---------------------------------------------------
; Procura um valor (lido das chaves) em um vetor.
; Exibe no visor:
;   - O índice da primeira ocorrência (0 a N-1)
;   - 0FFh se o valor não for encontrado
;---------------------------------------------------
ORG 100
TAM:     DB   8          ; Tamanho do vetor
VETOR:   DB   3, 7, 15, 2, 9, 15, 42, 1
CHAVE:   DS   1          ; Valor procurado
PT:      DW   VETOR      ; Ponteiro móvel
I:       DB   0          ; Índice atual

CHAVES   EQU  0
STATUS   EQU  1
VISOR    EQU  0
NAO_ACH  EQU  0FFh       ; Código de "não encontrado"

ORG 0
INICIO:
        IN   STATUS     ; Aguarda dado nas chaves
        AND  #1
        JZ   INICIO
        IN   CHAVES     ; Lê o valor a procurar
        STA  CHAVE
        OUT  VISOR      ; Confirma o valor no visor

LOOP:   LDA  @PT        ; Lê VETOR[I]
        SUB  CHAVE      ; Compara com a chave
        JZ   ACHOU      ; Se igual, encontrou

        LDA  PT         ; Avança o ponteiro
        ADD  #1
        STA  PT
        LDA  PT+1
        ADC  #0
        STA  PT+1

        LDA  I          ; Incrementa o índice
        ADD  #1
        STA  I
        SUB  TAM        ; I = TAM?
        JZ   NAO_ACHOU  ; Se sim, não encontrou
        JMP  LOOP

ACHOU:
        LDA  I
        OUT  VISOR      ; Exibe o índice no visor
        HLT

NAO_ACHOU:
        LDA  #NAO_ACH
        OUT  VISOR      ; Exibe 0FFh no visor
        HLT
        END  INICIO
