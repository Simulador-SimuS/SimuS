;---------------------------------------------------
; Programa: Calcula a soma de 1 a N (lido das chaves)
; Autor: Antonio Borges
; Data: 30/07/2023
; Arquivo: soma_1_n.asm
;---------------------------------------------------
          ORG     0
INICIO:
          IN      STATUS   ; espera status bit 1 ligado
          AND     #1
          JZ      INICIO

          IN      CHAVES   ; n, soma = in(chaves)  
          STA     N          
          STA     SOMA   

LOOP:                      ; início do loop 
          LDA     N        ; n = n - 1
          SUB     #1
          STA     N 
          JZ      FIM_LOOP ; se n chegar a zero sai do loop 
          ADD     SOMA     ; soma = soma + n 
          STA     SOMA
          JMP     LOOP     ; repete loop
FIM_LOOP:
          LDA     SOMA     ; out (visor, soma) 
          OUT     VISOR
          HLT              ; termina
;---Declaração das variáveis----------------
SOMA:     DS      1            
N:        DS      1
CHAVES    EQU     0
STATUS    EQU     1
VISOR     EQU     0
          END     INICIO
