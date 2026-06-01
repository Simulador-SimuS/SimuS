;---------------------------------------------------
; Programa: Calcula o fatorial de N (iterativo)
; Arquivo: fatorial.asm
;---------------------------------------------------
; Calcula N! = N x (N-1) x ... x 1 de forma
; iterativa. Para N=0 ou N=1 o resultado é 1.
;
; Limitação: como o resultado é de 8 bits (0-255),
; o valor máximo de N sem overflow é 5 (5! = 120).
; O resultado é impresso em hexadecimal no visor.
;---------------------------------------------------
ORG 100
N:      DB  5           ; Valor de N (altere para testar)
RESULT: DS  1           ; Resultado de N!

ORG 0
INICIO:
        IN   STATUS     ; Aguarda dado nas chaves
        AND  #1
        JZ   INICIO
        IN   CHAVES     ; Lê N
        STA  N

        OR   #0
        JZ   ZERO       ; Se N = 0, resultado = 1

        STA  RESULT     ; RESULT = N (valor inicial)

LOOP:   LDA  N
        SUB  #1
        STA  N          ; N = N - 1
        JZ   FIM        ; Se N = 0, termina

        LDA  RESULT     ; RESULT = RESULT * N (multiplicação por somas)
        STA  AUX
        LDA  #0
        STA  RESULT
        LDA  N
        STA  MULT
SOMA:   LDA  RESULT
        ADD  AUX
        STA  RESULT
        LDA  MULT
        SUB  #1
        STA  MULT
        JNZ  SOMA
        JMP  LOOP

ZERO:   LDA  #1
        STA  RESULT
FIM:    LDA  RESULT
        OUT  VISOR
        HLT

ORG 200
AUX:    DS  1
MULT:   DS  1
CHAVES  EQU 0
STATUS  EQU 1
VISOR   EQU 0
        END INICIO
