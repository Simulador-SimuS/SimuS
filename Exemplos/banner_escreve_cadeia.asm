;---------------------------------------------------
; Programa: Escreve uma cadeia de caracteres no
;           banner usando endereçamento indireto
; Autor: José Antonio Borges
; Data: 2017
; Arquivo: banner_escreve_cadeia.asm
;---------------------------------------------------
; Percorre a string apontada por PTR e escreve cada
; caractere no banner usando OUT. Usa o TRAP 2 para
; escrever simultaneamente no terminal.
;
; Endereçamento indireto @PTR: lê da posição de
; memória cujo endereço está armazenado em PTR.
;---------------------------------------------------
ORG 0
INICIO:
        OUT  CLEARBANNER    ; Limpa o banner

LOOP:
        LDA  @PTR           ; Lê o próximo caractere
        OR   #0             ; Testa se é NULL (fim da string)
        JZ   FIM            ; Se for, termina
        OUT  BANNER         ; Escreve o caractere no banner
        LDA  #CONSOLEWRITE  ; TRAP 2: escreve no terminal
        TRAP @PTR           ; Escreve o mesmo caractere

        LDA  PTR            ; Incrementa o ponteiro (parte baixa)
        ADD  #1
        STA  PTR
        LDA  PTR+1          ; Propaga carry para a parte alta
        ADC  #0
        STA  PTR+1

        JMP  LOOP
FIM:    HLT
        END  INICIO

;---------------------------------------------------
; Dados
;---------------------------------------------------
GABRIEL: STR  "Gabriel P. Silva"
         DB   0             ; Terminador NULL
PTR:     DW   GABRIEL       ; Ponteiro para a string

; Constantes de hardware
CLEARBANNER   EQU  3        ; Porta OUT para limpar o banner
BANNER        EQU  2        ; Porta OUT para escrever no banner
; Constante de TRAP
CONSOLEWRITE  EQU  2        ; TRAP 2: escreve um caractere
