;
;  Programa para tocar bips com frequencia crescente
;  utilizando a rotina de TRAP do simulador
;
ORG 0
LACO:
    LDA  #6      ; Búmero do TRAP para tocar som
    TRAP FREQ
    LDA  FREQ
    ADD  #10
    STA  FREQ
    JMP  LACO
    NOP
    HLT
ORG 100
FREQ:   DW 440
DUR:    DW 200
