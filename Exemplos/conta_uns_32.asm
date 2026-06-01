;---------------------------------------------------
; Rotina: Conta o número de bits '1' em uma palavra
;         de 32 bits (4 bytes)
; Autor: Gabriel P. Silva
; Data: 07.09.2017
; Arquivo: conta_uns_32.asm
;---------------------------------------------------
; A rotina recebe na pilha o endereço do primeiro
; byte da palavra de 32 bits e retorna no acumulador
; o total de bits '1'.
;
; Algoritmo: para cada byte, desloca para a esquerda
; repetidamente; se sair carry, incrementa o total.
; Repete para os 4 bytes.
;---------------------------------------------------
ORG 200
TESTE:    DW  55AAh, 5501h   ; Palavra de 32 bits (4 bytes)
ENDER:    DW  TESTE          ; Endereço do byte atual
RA:       DW  0              ; Endereço de retorno
TEMP:     DS  1
TOTAL:    DB  0              ; Total de bits '1'
CONTADOR: DB  0              ; Bytes já processados

ORG 0
ROTINA:
        POP
        STA  RA             ; Salva endereço de retorno
        POP
        STA  RA+1
        POP
        STA  ENDER          ; Salva o endereço da palavra (parte baixa)
        POP
        STA  ENDER+1        ; (parte alta)
        LDA  #0             ; Zera o total e o contador
        STA  TOTAL
        STA  CONTADOR

INICIO: LDA  @ENDER         ; Lê o byte atual
        STA  TEMP

LOOP:   LDA  TEMP
        OR   #0             ; Todos os bits zerados?
        JZ   CONT           ; Se sim, passa para o próximo byte
        SHL                 ; Desloca para a esquerda
        STA  TEMP
        JNC  FIM            ; Se não saiu carry, bit era 0
        LDA  #1             ; Bit era 1: incrementa total
        ADD  TOTAL
        STA  TOTAL
FIM:    JMP  LOOP

CONT:   LDA  ENDER          ; Avança para o próximo byte
        ADD  #1
        STA  ENDER
        LDA  ENDER+1
        ADC  #0
        STA  ENDER+1

        LDA  CONTADOR
        ADD  #1
        STA  CONTADOR
        SUB  #4             ; Processou os 4 bytes?
        JNZ  INICIO         ; Se não, continua

        LDA  RA+1           ; Restaura endereço de retorno
        PUSH
        LDA  RA
        PUSH
        LDA  TOTAL          ; Retorna o total no acumulador
        RET

MAIN:   LDA  ENDER+1       ; Parte alta do endereço de TESTE = 0
        PUSH
        LDA  ENDER        ; Parte baixa do endereço de TESTE
        PUSH
        JSR  ROTINA
        OUT  0              ; Exibe o resultado no visor
        HLT
        END  MAIN
