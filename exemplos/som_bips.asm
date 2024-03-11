; -------------------------------
; Programa: Ecoa um tom crescente em frequencia 
; Autor: Gabriel P. Silva
; Data: 08.03.2024
loop:
    LDA  #6
    TRAP freq
;  Incrementa a frequencia  
    LDA  freq
    ADD  #10
    STA  freq
;  Volta para o laço   
    JMP  loop

    NOP
    HLT
freq:   dw 440
dur:    dw 200
