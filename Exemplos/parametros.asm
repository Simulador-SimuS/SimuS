;--------------------------------------------------
; Programa: Passagem de parametros
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: parametros.asm
;--------------------------------------------------
ORG 0
; Declaração das variáveis do programa principal
VETOR:    DB 10, 11, 12, 15, 16
PONTEIRO: DW VETOR
TAMANHO:  DB 5 

INICIO:
    LDA  TAMANHO
    PUSH
    LDA  PONTEIRO+1
    PUSH
    LDA  PONTEIRO
    PUSH
    JSR  ROTINA
    HLT

; VOID ROTINA(CHAR *PTR)
ORG 100
; Declaração das variáveis da rotina
SP:   DS 2
PTR:  DS 2
VAL:  DS 1
TAM:  DS 1
ROTINA:
; Salva argumentos
    STS  SP     ; Salva o valor atual do SP 
    POP         ; Que aponta para o endereço 
    POP         ; de retorno na pilha. Avança o SP 
    POP         ; Retira o primeiro byte do primeiro parâmetro
    STA  PTR    ; Salva na parte baixa do ponteiro local
    POP         ; Retira o segundo byte do primeiro parâmetro
    STA  PTR+1  ; Salva na parte alta do ponteiro local
    POP         ; Retira o segundo parâmetro da pilha
    STA  TAM    ; Salva na variável local de tamanho
    LDA  @PTR   ; VAL = *PTR
    STA  VAL    ;
                ; Faz outras coisas
                ;
    LDS  SP     ; Restaura o valor de SP 
    RET         ; Retorna da sub-rotina
    END INICIO  
