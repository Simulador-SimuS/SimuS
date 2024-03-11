;---------------------------------------------------
; Programa: Contagem regressiva manual
; Autor: Gabriel P. Silva
; Data: 15.09.2003
; Lê o valor inicial das teclas e depois espera a tecla
; "Entra" ser acionada para decrementar o 
; valor do visor.
;---------------------------------------------------
ORG 100
X:      DS  1
VISOR   EQU 0
STATUS  EQU 1
CHAVES  EQU 0

ORG 0 
STATUS1:
        IN   STATUS           ; Verifica se o valor está pronto
        ADD  #0               ;
        JZ   STATUS1          ; Enquanto não estiver pronto fica em loop
        IN   CHAVES           ; Lê o primeiro valor das teclas
        STA  X                ; Armazena o conteúdo na memória
        OUT  VISOR            ; Mostra o valor lido no visor
STATUS2:
        IN   STATUS
        ADD  #0               ;
        JZ   STATUS2          ; Enquanto não estiver pronto fica em loop 
        LDA  X                ; Lê o ultimo valor armazenado
        SUB  #1               ; Subtrai de um 
        STA  X                ; Armazena
        OUT  VISOR            ; Coloca o resultado no visor
        IN   CHAVES           ; Descarta o valor lido
        JMP  STATUS2          ; Continua eternamente
        END  STATUS1          ; Termina o código


