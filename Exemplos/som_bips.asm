;---------------------------------------------------
; Programa: Toca beeps com frequência crescente
; Arquivo: som_bips.asm
;---------------------------------------------------
; Usa o TRAP 6 para gerar beeps cujo pitch aumenta
; de 10 em 10 Hz a cada iteração.
; A frequência inicial é 440 Hz (Lá) e a duração
; de cada beep é de 200 ms.
;---------------------------------------------------
ORG 0
LACO:
        LDA  #6         ; TRAP 6 = sintetizador de áudio
        TRAP FREQ       ; Toca o beep com a frequência atual

        LDA  FREQ       ; Incrementa a frequência (parte baixa)
        ADD  #10
        STA  FREQ
        LDA  FREQ+1     ; Propaga carry para a parte alta
        ADC  #0
        STA  FREQ+1

        JMP  LACO       ; Repete indefinidamente
        HLT

ORG 100
FREQ:   DW  440         ; Frequência inicial: 440 Hz
DUR:    DW  200         ; Duração: 200 ms por beep
        END  0
