;--------------------------------------------------
; Programa: Imprime as letras do alfabeto
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: imprime_alfabeto.asm
;--------------------------------------------------
ORG 100
LETRA:  DS 1
CONTA:  DB 26
CR:     DB 0Dh
LF:     DB 0Ah

ORG 0 
ESPERA: LDA #1       ; Lê uma letra inicial da console
        TRAP  0 
        OR #0        
        JZ ESPERA     
        STA LETRA    ; Armazena o valor lido

LOOP:   LDA #2       ; Fica em loop até conta = 0 
        TRAP LETRA   ; Imprime o caractere na console
        LDA LETRA
        ADD #1
        STA LETRA     ; Avança para a letra seguinte
        LDA CONTA
        SUB #1
        STA CONTA
        JNZ LOOP
        LDA #2       ; Imprime retorno de carro  
        TRAP CR
        LDA #2
        TRAP CR
        HLT
        END ESPERA
