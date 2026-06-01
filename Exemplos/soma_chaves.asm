;---------------------------------------------------
; Programa: Lê dois valores do painel de chaves e
;           exibe a soma no visor hexadecimal
; Autor: Gabriel P. Silva
; Data: 15.09.2003
; Arquivo: soma_chaves.asm
;---------------------------------------------------
; Sequência de operação:
;   1. Coloque o primeiro valor nas chaves e pressione ENTER
;   2. Coloque o segundo valor nas chaves e pressione ENTER
;   3. Pressione ENTER novamente para exibir a soma
;---------------------------------------------------
ORG 100
X:      DS  1       ; Armazena o primeiro valor lido
ZERO:   DB  0       ; Constante zero para testar status

ORG 0
; --- Lê o primeiro valor ---
STATUS1:
        IN   1          ; Verifica se o painel está pronto (bit 0 = 1)
        AND  ZERO       ; Compara com zero
        JZ   STATUS1    ; Aguarda enquanto não estiver pronto
        IN   0          ; Lê o primeiro valor das chaves
        STA  X          ; Guarda em X
        OUT  0          ; Exibe no visor

; --- Lê o segundo valor ---
STATUS2:
        IN   1
        AND  ZERO
        JZ   STATUS2    ; Aguarda o segundo valor
        IN   0          ; Lê o segundo valor
        OUT  0          ; Exibe no visor
        ADD  X          ; Soma com o primeiro valor
        STA  X          ; Guarda o resultado

; --- Exibe a soma após nova confirmação ---
STATUS3:
        IN   1
        AND  ZERO
        JZ   STATUS3    ; Aguarda confirmação
        LDA  X          ; Lê o resultado
        OUT  0          ; Exibe a soma no visor
        HLT             ; Termina
        END  STATUS1
