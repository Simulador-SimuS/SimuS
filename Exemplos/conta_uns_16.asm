;------------------------------------------------------------
; Rotina que conta o número de '1's em uma palavra de 16 bits
; Autor: Gabriel P. Silva e Antonio Borges
; Data:  10/08/2023
; Arquivo: conta_uns_16.asm
;------------------------------------------------------------
ORG 200H
COUNT_ONES:
     POP
     STA  RETURN_ADDRESS
     POP
     STA  RETURN_ADDRESS+1
; Pega o endereço da palavra na pilha
     POP
     STA PT_WORD 
     POP 
     STA PT_WORD+1
; Zera o contador
     LDA #0
     STA COUNTER
; Pega o primeiro byte
     LDA @PT_WORD
     STA TEMP
; Itera sobre os bits da palavra
LOOP1:
     LDA TEMP   
; Se o bit for 1, incrementa o contador
     SHL
     STA TEMP
     JC COUNT1
     OR #0 
     JZ  NEXT 
     JMP LOOP1 
COUNT1:
     LDA COUNTER
     ADD #1
     STA COUNTER
     JMP LOOP1     
NEXT:
; Vai para o próximo byte
     LDA  PT_WORD 
     ADD  #1
     STA  PT_WORD
     LDA  PT_WORD+1
     ADC  #0
     STA  PT_WORD+1  
; Pega o segundo byte
     LDA @PT_WORD
     STA TEMP
; Itera sobre os bits da palavra
LOOP2:
     LDA TEMP    
; Se o bit for 1, incrementa o contador
     SHL
     STA TEMP
     JC COUNT2
     OR #0 
     JZ  RETURN
     JMP LOOP2 
COUNT2:
     LDA COUNTER
     ADD #1
     STA COUNTER
     JMP LOOP2     
RETURN:
     LDA RETURN_ADDRESS+1
     PUSH
     LDA RETURN_ADDRESS
     PUSH
     LDA COUNTER
; Sai da rotina
     RET
;---------------------------------------------------
; Variáveis da rotina
;---------------------------------------------------
COUNTER:         DB 0 
TEMP:            DS 1
PT_WORD:         DW 0
RETURN_ADDRESS:  DW 0
;--------------------------------------------
; Programa Principal
;--------------------------------------------
ORG 0
MAIN:
; Valor inicial do ponteiro de pilha
    LDS #STACK_ADDRESS
; Carrega o endereço da palavra na pilha
    LDA WORD_ADDRESS+1
    PUSH
    LDA WORD_ADDRESS
    PUSH 
; Chama a rotina para contar o número de '1's
    JSR COUNT_ONES
; Salva o resultado no acumulador
    STA RESULT
; Exibe o resultado no visor hexadecimal
    OUT 0
; Termina o programa
    HLT
;---------------------------------------------------
; Variáveis do programa principal
;---------------------------------------------------
STACK_ADDRESS  EQU 300H
WORD_ADDRESS:  DW  WORD
WORD:          DW  55AAH
RESULT:        DB  0 
        END MAIN
