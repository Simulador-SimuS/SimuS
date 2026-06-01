;---------------------------------------------------
; Programa: Determina o maior valor de um vetor
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: maximo_vetor.asm
;---------------------------------------------------
; Percorre o vetor e mantém em MAX o maior valor
; encontrado até o momento. Ao final exibe MAX.
; Obs.: os valores são tratados como bytes sem sinal
; (0 a 255). O valor -1 no vetor equivale a 0FFh=255.
;---------------------------------------------------
ORG 100
TAM:      DB    10          ; Número de elementos
IND:      DB    0           ; Índice atual
MAXIND:   DB    0           ; Índice do maior elemento
MAX:      DB    0           ; Maior valor encontrado
PONTEIRO: DW    VETOR       ; Ponteiro para o elemento atual
VETOR:    DB    11, 27, 31, 82, 23, 80, 127, 0FFh, 47, 6

ORG 0
INICIO:
    LDA  @PONTEIRO      ; MAX = VETOR[0]
    STA  MAX

LACO:
    LDA  IND            ; IND = IND + 1
    ADD  #1
    STA  IND
    SUB  TAM            ; IND = TAM ?
    JZ   FIM            ; Se sim, termina

    LDA  PONTEIRO       ; Avança o ponteiro
    ADD  #1
    STA  PONTEIRO
    LDA  PONTEIRO+1
    ADC  #0
    STA  PONTEIRO+1

    LDA  @PONTEIRO      ; ACC = VETOR[IND]
    SUB  MAX            ; ACC - MAX
    JN   LACO           ; Se ACC < MAX, não troca
    JZ   LACO           ; Se ACC = MAX, não troca

    LDA  @PONTEIRO      ; Se ACC > MAX: atualiza MAX
    STA  MAX
    LDA  IND
    STA  MAXIND         ; Guarda também o índice do maior
    JMP  LACO

FIM:
    LDA  MAX
    OUT  0              ; Exibe o maior valor no visor
    HLT
    END  INICIO
