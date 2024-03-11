;---------------------------------------------------
; Programa: Contagem regressiva
; Autor: Gabriel P. Silva
; Data: 08.03.2024
;---------------------------------------------------
        ORG 100
X:      DS  1
ZERO:   DB  0
STATUS  EQU 1
CHAVES  EQU 0
VISOR   EQU 0

ORG 0 
STATUS1:
        IN   STATUS           ; Verifica se o valor está pronto
        ADD  #0               ; Soma com o valor 0
        JZ   STATUS1          ; Enquanto não estiver pronto fica em loop
        IN   CHAVES           ; Lê o primeiro valor
LOOP:   STA  X                ; Armazena o conteúdo na memória
        OUT  VISOR            ; Mostra o valor lido no visor
        LDA  X                ; Lê o ultimo valor armazenado
        NOT                   ; Complementa a um
        SUB  #1               ; Subtrai 
        JMP  LOOP             ; Em LOOP para sempre
        END STATUS1           ; Endereço inicial de execução


