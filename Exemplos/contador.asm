;---------------------------------------------------
; Programa: Contagem regressiva
; Autor: Gabriel P. Silva
; Data: 16.09.2003
;---------------------------------------------------
STATUS1:
        IN   01               ; Verifica se o valor est� pronto
        ADD  ZERO             ; Soma com o valor 0 
        JZ   STATUS1          ; Enquanto n�o estiver pronto fica em loop
        IN   00               ; L� o primeiro valor
LOOP:   STA  X                ; Armazena o conte�do na mem�ria
        OUT  00               ; Mostra o valor lido no visor 
        LDA  X                ; L� o ultimo valor armazenado
        NOT                   ; Complementa a um
        ADD  UM               ; Decrementa
        NOT                   ; 
        JMP  LOOP             ; Em LOOP para sempre
        END STATUS1           ; Termina o c�digo

        ORG 100
X:      DS  1
ZERO:   DB  0
UM:     DB  1 
        
