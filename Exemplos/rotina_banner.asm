;---------------------------------------------------
; Programa: Imprime duas cadeias no banner usando
;           uma subrotina com parâmetro na pilha
; Autor: Gabriel P. Silva e Antonio Borges
; Arquivo: rotina_banner.asm
; Data: 13/08/2023
;---------------------------------------------------
; A subrotina ROTINA recebe na pilha o endereço
; de uma string terminada em NULL e a imprime no
; banner caractere a caractere.
;
; Convenção de chamada (endereço de 16 bits):
;   PUSH parte alta do endereço
;   PUSH parte baixa do endereço
;   JSR  ROTINA
;---------------------------------------------------
ORG 200
STR_PRIMEIRA: STR  "Rotina para impressao"
              DB   0
STR_SEGUNDA:  STR  "Esta e outra cadeia"
              DB   0
PT_PRIMEIRA:  DW   STR_PRIMEIRA
PT_SEGUNDA:   DW   STR_SEGUNDA

ORG 100
INICIO:
    LDA  PT_PRIMEIRA+1  ; Empilha endereço da primeira cadeia
    PUSH                ; (parte alta primeiro)
    LDA  PT_PRIMEIRA
    PUSH
    JSR  ROTINA         ; Imprime primeira cadeia

    LDA  PT_SEGUNDA+1   ; Empilha endereço da segunda cadeia
    PUSH
    LDA  PT_SEGUNDA
    PUSH
    JSR  ROTINA         ; Imprime segunda cadeia
    HLT
    END  INICIO

;---------------------------------------------------
; Subrotina ROTINA
; Parâmetro: endereço de uma string (2 bytes na pilha)
; Imprime a string no banner até encontrar NULL.
;---------------------------------------------------
ORG 300
RA:     DW  0           ; Endereço de retorno (salvo aqui)
PTR:    DW  0           ; Ponteiro para a string

CLEARB  EQU 3           ; Porta OUT para limpar o banner
BANNER  EQU 2           ; Porta OUT para escrever no banner

ROTINA:
    POP          ; Retira parte baixa do endereço de retorno
    STA  RA
    POP
    STA  RA+1    ; Retira parte alta do endereço de retorno

    POP          ; Retira parte baixa do endereço da string
    STA  PTR
    POP
    STA  PTR+1   ; Retira parte alta do endereço da string

    OUT  CLEARB  ; Limpa o banner antes de escrever

LOOP:
    LDA  @PTR    ; Lê o próximo caractere
    OR   #0      ; É NULL?
    JZ   RETORNA ; Se sim, termina
    OUT  BANNER  ; Senão imprime no banner
    LDA  PTR     ; Avança o ponteiro
    ADD  #1
    STA  PTR
    LDA  PTR+1
    ADC  #0
    STA  PTR+1
    JMP  LOOP

RETORNA:
    LDA  RA+1    ; Restaura o endereço de retorno na pilha
    PUSH
    LDA  RA
    PUSH
    RET
