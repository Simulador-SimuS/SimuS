;--------------------------------------------------
; Programa: Determina o maior valor de um vetor
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: maximo_vetor.asm
;--------------------------------------------------
ORG 100               ; Variáveis
TAM:      DB    10    ; Número de elementos do vetor  
IND:      DB    0     ; Indice do vetor
MAXIND:   DB    0     ; Indice do maior elemento
MAX:      DB    0     ; Valor do maior elemento
PONTEIRO: DW    VETOR ; Endereço do elemento atual 
; Vetor
VETOR:    DB    11, 27, 31, 82, 23, 80, 127, -1, 47, 6

ORG 0                 ; Código
INICIO:
    LDA  @PONTEIRO    ; Acumulador recebe vetor (0)
    STA  MAX          ; MAX = VETOR(0)
LACO:
    LDA  IND          ; Carrega o indice no acumulador
    ADD  #1           ; Incrementa de um
    STA  IND          ; Salva na memória
    SUB  TAM          ; Diminui do tamanho do vetor
    JZ   FIM          ; Quando IND e TAM forem iguais termina
    LDA  PONTEIRO     ; Carrega a parte baixa do ponteiro
    ADD  #1           ; Incrementa de um
    STA  PONTEIRO     ; Salva na memória
    LDA  PONTEIRO+1   ; Incrementa a parte alta do ponteiro
    ADC  #0           ; Se deu carray na soma anterior
    STA  PONTEIRO+1   ; Salva na memória   
    LDA  @PONTEIRO    ; Carrega VETOR(IND) no acumulador 
    SUB  MAX          ; Diminui do valor máximo 
    JN   LACO         ; Se negativo avança para o próximo
    LDA  @PONTEIRO    ; Senão troca MAX por VETOR(IND) 
    STA  MAX          ; MAX = VETOR(I)
    LDA  IND          ; Carrega IND no acumulador 
    STA  MAXIND       ; MAXIND = IND
    JMP  LACO         ; Continua   
FIM:
    LDA  MAX
    OUT  0            ; Mostra o valor maximo no visor 
    HLT
    END INICIO
