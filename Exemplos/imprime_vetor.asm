;---------------------------------------------------
; Programa: Percorre um vetor e exibe cada elemento
;           no visor hexadecimal
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: imprime_vetor.asm
;---------------------------------------------------
; Usa um ponteiro (PT) para percorrer o vetor e um
; índice (I) para contar os elementos exibidos.
;---------------------------------------------------
ORG 250
PT:      DW  X           ; Ponteiro móvel para o vetor
X:       DB  10h, 30h, 25h, 45h, 22h    ; Vetor com 5 elementos
I:       DB  0           ; Índice (conta elementos exibidos)
TAM:     DB  5           ; Tamanho do vetor
DISPLAY  EQU 0

ORG 0
INICIO:
    LDA  @PT         ; ACC = X[I]
    OUT  DISPLAY     ; Exibe no visor

    LDA  PT          ; Avança o ponteiro (parte baixa)
    ADD  #1
    STA  PT
    LDA  PT+1        ; Propaga carry para a parte alta
    ADC  #0
    STA  PT+1

    LDA  I           ; Incrementa o índice
    ADD  #1
    STA  I
    SUB  TAM         ; Compara com o tamanho do vetor
    JN   INICIO      ; Enquanto I < TAM, continua

FIM:
    HLT
    END  INICIO
