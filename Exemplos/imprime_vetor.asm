;--------------------------------------------------
; Programa: Imprime um vetor no display hexadecimal
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: imprime_vetor.asm
;--------------------------------------------------
ORG 250          ; Variáveis
PT:	    DW  X    ; Ponteiro móvel para o vetor
X:      DB  10h, 30h, 25h, 45h, 22h    ; Vetor
I:      DB  0    ; Indice
TAM:    DB 5     ; Tamanho do vetor
DISPLAY EQU 0 

ORG 0
INICIO: 
    LDA  @PT     ; Faz acumulador = X[I]
    OUT  DISPLAY ; Mostra no display         
    LDA  PT      ; Incrementa o apontador
    ADD  #1      ; do tamanho de cada elemento
    STA  PT      ; Armazena de volta
    LDA  PT+1    ; Incrementa a parte alta
    ADC  #0      ; Se deu carry
    STA  PT+1    ; Armazena de volta
    LDA  I       ; Verifica se terminou
    ADD  #1      ; de acordo com o número de
    STA  I       ; elementos do vetor
    SUB  TAM     ; Subtrai do tamanho
    JN   INICIO  ; Se não acabou, vai para o início
FIM: 
    HLT          ; Termina a execução
    END INICIO
