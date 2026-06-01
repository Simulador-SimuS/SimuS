;---------------------------------------------------
; Programa: Calcula a soma de 1 até N
;           onde N é lido do painel de chaves
; Autor: Antonio Borges
; Data: 30/07/2023
; Arquivo: soma_1_n.asm
;---------------------------------------------------
; Calcula: SOMA = N + (N-1) + (N-2) + ... + 1
; Algoritmo: começa com SOMA = N, decrementa N e
; acumula até N = 0.
;---------------------------------------------------
          ORG     0
INICIO:
          IN      STATUS      ; Aguarda dado disponível
          AND     #1          ; Testa bit de status
          JZ      INICIO      ; Repete enquanto não estiver pronto

          IN      CHAVES      ; Lê N das chaves
          STA     N           ; N = valor lido
          STA     SOMA        ; SOMA começa com N

LOOP:     LDA     N           ; N = N - 1
          SUB     #1
          STA     N
          JZ      FIM_LOOP    ; Se N = 0, termina
          ADD     SOMA        ; SOMA = SOMA + N
          STA     SOMA
          JMP     LOOP

FIM_LOOP: LDA     SOMA        ; Exibe a soma no visor
          OUT     VISOR
          HLT
;--- Variáveis ---
SOMA:     DS      1
N:        DS      1
CHAVES    EQU     0
STATUS    EQU     1
VISOR     EQU     0
          END     INICIO
