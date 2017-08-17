;---------------------------------------------------
; Programa: Contagem regressiva manual
; Autor: Gabriel P. Silva
; Data: 15.09.2003
; L� o valor das teclas e deposi espera a tecla 
; "Entrar" ser acionada para decrementar o 
; valor do visor.
;---------------------------------------------------
STATUS1:
        IN   01               ; Verifica se o valor est� pronto
        ADD  ZERO             ; Soma com o valor 0 
        JZ   STATUS1          ; Enquanto n�o estiver pronto fica em loop
        IN   00               ; L� o primeiro valor
        STA  X                ; Armazena o conte�do na mem�ria
        OUT  00               ; Mostra o valor lido no visor 
STATUS2:
        IN 01
        ADD  ZERO             ; Soma com o valor 0
        JZ   STATUS2          ; Enquanto n�o estiver pronto fica em loop 
        LDA  X                ; L� o ultimo valor armazenado
        NOT                   ; Complementa a um
        ADD  UM               ; Complementa a dois
        ADD  UM               ; Decrementa
        NOT                   ; 
        ADD  UM               ; Complementa a dois
        STA  X                ; Soma com o primeiro valor
        OUT  00               ; Coloca o resultado no visor
        IN   00               ; Descarta o valor do teclado
        JMP STATUS2           ; Em LOOP para sempre
        END STATUS1           ; Termina o c�digo

        ORG 100
X:      DS  1
ZERO:   DB  0
UM:     DB  1 
        
