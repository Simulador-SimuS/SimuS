;---------------------------------------------------
; Programa: Soma dois n�meros
; Autor: Gabriel P. Silva
; Data: 15.09.2003
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
        IN   00               ; L� o segundo valor
        OUT  00               ; Mostra o valor lido no visor 
        ADD  X                ; Soma com o primeiro valor
        STA  X                ; Armazena o resultado na mem�ria
STATUS3:
        IN 01                 ; Espera o pelo teclado
        ADD  ZERO             ; Soma com o valor 0
        JZ   STATUS3          ; Enquanto n�o estiver pronto fica em loop
        LDA  X                ; L� o resultado da mem�ria
        OUT  00               ; Exibe no visor
        HLT                   ; P�ra
        END STATUS1           ; Termina o c�digo

        ORG 100
A:      DS  1
X:      DS  1
ZERO:   DB  0

        
