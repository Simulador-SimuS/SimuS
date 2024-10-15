;---------------------------------------------------
; Programa: Testa a rotina de impressão no banner
; Autor: Gabriel P. Silva e Antono Borges
; Arquivo: rotina_banner.asm
; Data: 13/08/2023
;---------------------------------------------------
ORG 200         ; Variáveis do programa principal
STR_PRIMEIRA: STR "Rotina para impressão"
             DB  0
STR_SEGUNDA: STR "Este é outra cadeia"
             DB  0
PT_PRIMEIRA: DW STR_PRIMEIRA
PT_SEGUNDA:  DW STR_SEGUNDA


ORG 100
INICIO:            
    LDA  PT_PRIMEIRA+1  ; Coloca o endereço para primeira
    PUSH                ; cadeia na pilha
    LDA  PT_PRIMEIRA
    PUSH
    JSR  ROTINA
    LDA  PT_SEGUNDA     ; Coloca o endereço da segunda 
    PUSH                ; cadeia na pilha
    LDA  PT_SEGUNDA+1
    JSR  ROTINA
    HLT
    END INICIO
;-------------------------------------------
; Rotina para impressão de uma cadeia no banner
; Declaração das variáveis da rotina
;-------------------------------------------
ORG 300
RA:     DW  0    ; Guarda o valor do endereço de retorno
PTR:    DW  0    ; Ponteiro com o endereço da string a ser impressa
; Constantes de acesso de E/S
CLEARB  EQU 3
BANNER  EQU 2
;-------------------------------------------
ROTINA:
    POP          ; Salva o endereço de retorno
    STA  RA      ; parte baixa
    POP   
    STA  RA+1    ; parte alta
    POP          ; Tira a parte baixa do endereço da string da pilha
    STA  PTR     ; Salva na parte baixa do ponteiro
    POP          ; Tira a parte alta do endereço da string da pilha
    STA  PTR+1   ; Salva na parte alta do ponteiro
    OUT  CLEARB  ; Limpa o Banner
LOOP:
    LDA  @PTR    ; Le o caractere
    OR   #0      ; É NULL?
    JZ   RETORNA ; Se for retorna
    OUT  BANNER  ; Imprime o caractere no banner
    LDA  PTR     ; Incrementa o ponteiro
    ADD  #1
    STA  PTR
    JMP  LOOP    ; Volta para o inicio
RETORNA:
    LDA RA+1     ; Recoloca o endereço de retorno na pilha
    PUSH 
    LDA RA       ; Na ordem inversa em que foi retirado
    PUSH
    RET          ; Retorna
