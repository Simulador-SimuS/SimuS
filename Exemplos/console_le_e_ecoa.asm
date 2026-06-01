;---------------------------------------------------
; Programa: Lê uma letra e ecoa as 26 letras
;           do alfabeto a partir dela
; Arquivo: console_le_e_ecoa.asm
;---------------------------------------------------
; Equivalente a console_imprime_alfabeto.asm,
; escrito em letras minúsculas (o assembler não
; distingue maiúsculas de minúsculas).
;---------------------------------------------------
ORG 100
LETRA:  DS  1
CONTA:  DS  1
CR:     DB  0Dh
LF:     DB  0Ah

ORG 0
ESPERA: LDA  #1         ; Lê um caractere do terminal
        TRAP LETRA      ; Resultado em ACC e em LETRA
        OR   #0
        JZ   ESPERA     ; Rejeita NULL

        LDA  #26
        STA  CONTA      ; Inicializa o contador

LOOP:   LDA  #2         ; Escreve o caractere em LETRA
        TRAP LETRA
        LDA  LETRA
        ADD  #1
        STA  LETRA      ; Avança para a próxima letra
        LDA  CONTA
        SUB  #1
        STA  CONTA
        JNZ  LOOP

        LDA  #2
        TRAP CR
        LDA  #2
        TRAP LF
        HLT
        END  0
