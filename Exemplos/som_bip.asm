;---------------------------------------------------
; Programa: Toca um único beep pelo sintetizador
; Arquivo: som_bip.asm
;---------------------------------------------------
; Usa o TRAP 6 para gerar um tom de 440 Hz (Lá)
; com duração de 1000 ms.
;
; Parâmetros do TRAP 6 (dois words a partir do
; endereço passado como operando):
;   FREQ (2 bytes): frequência em Hz
;   DUR  (2 bytes): duração em milissegundos
;---------------------------------------------------
ORG 0
        LDA  #6         ; TRAP 6 = sintetizador de áudio
        TRAP FREQ       ; Toca o beep
        NOP
        HLT

ORG 100
FREQ:   DW  440         ; 440 Hz = Lá (A4)
DUR:    DW  1000        ; 1000 ms = 1 segundo
        END  0
