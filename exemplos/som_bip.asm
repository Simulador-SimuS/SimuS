; -------------------------------
; Programa: Ecoa um bip 
; Autor: Gabriel P. Silva
; Data: 08.03.2024
;------------------------------
ORG 0
    LDA #6
    TRAP freq
    NOP
    HLT

freq:  DW 440
dur:   DW  1000
END 0
