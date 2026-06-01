;---------------------------------------------------
; Programa: Lê uma letra inicial e imprime as 26
;           letras do alfabeto no terminal
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: imprime_alfabeto.asm
;---------------------------------------------------
; Idêntico a console_imprime_alfabeto.asm.
; Demonstra o uso dos TRAPs de E/S do terminal:
;   TRAP 1: lê um caractere (ACC e mem = código ASCII)
;   TRAP 2: escreve um caractere (lê da memória)
;---------------------------------------------------
ORG 100
LETRA:  DS  1
CONTA:  DB  26
CR:     DB  0Dh
LF:     DB  0Ah

ORG 0
ESPERA: LDA  #1         ; TRAP 1: lê um caractere
        TRAP LETRA
        OR   #0
        JZ   ESPERA     ; Rejeita NULL

LOOP:   LDA  #2         ; TRAP 2: escreve um caractere
        TRAP LETRA
        LDA  LETRA
        ADD  #1
        STA  LETRA
        LDA  CONTA
        SUB  #1
        STA  CONTA
        JNZ  LOOP

        LDA  #2         ; Imprime CR+LF ao final
        TRAP CR
        LDA  #2
        TRAP LF
        HLT
        END  ESPERA
