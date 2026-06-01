;---------------------------------------------------
; Programa: Soma A = B + C
; Autor: Gabriel P. Silva
; Data: 2016
; Arquivo: soma_b_c.asm
;---------------------------------------------------
; Exemplo introdutório: lê dois valores da memória,
; soma e exibe o resultado no visor hexadecimal.
;---------------------------------------------------
ORG 100

B:       DB   10    ; B = 10
C:       DB   5     ; C = 5
A:       DS   1     ; A (resultado)

ORG 0
MAIN:    LDA  B     ; ACC = B
         ADD  C     ; ACC = B + C
         STA  A     ; A = ACC
         OUT  0     ; Exibe no visor hexadecimal
         HLT        ; Termina
         END  MAIN
