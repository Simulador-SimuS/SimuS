;---------------------------------------------------
; Programa: Contagem regressiva manual controlada
;           pelo painel de chaves
; Autor: Gabriel P. Silva
; Data: 15.09.2003
; Arquivo: contagem_regressiva_manual.asm
;---------------------------------------------------
; 1. Coloque o valor inicial nas chaves e pressione ENTER
; 2. A cada pressionamento de ENTER o visor decrementa
;---------------------------------------------------
ORG 0
; --- Lê o valor inicial ---
STATUS1:
        IN   1              ; Verifica se há valor disponível
        AND  #1             ; Testa bit de status
        JZ   STATUS1        ; Aguarda
        IN   0              ; Lê o valor das chaves
        STA  X              ; Guarda em X
        OUT  0              ; Exibe no visor

; --- A cada ENTER decrementa e exibe ---
STATUS2:
        IN   1
        AND  #1
        JZ   STATUS2        ; Aguarda próximo ENTER
        LDA  X              ; Lê o valor atual
        SUB  #1             ; Decrementa
        STA  X              ; Guarda de volta
        OUT  0              ; Exibe no visor
        IN   0              ; Descarta o valor do painel
        JNZ   STATUS2       ; Repete
        HLT
        END  STATUS1

ORG 100
X:      DS  1
