;---------------------------------------------------
; Programa: Calcula o MDC de dois números pelo
;           algoritmo de Euclides
; Arquivo: mdc.asm
;---------------------------------------------------
; Algoritmo de Euclides:
;   Enquanto B != 0:
;       R = A mod B  (resto da divisão A / B)
;       A = B
;       B = R
;   MDC = A
;
; O resto é calculado por subtrações sucessivas.
; Lê A e B do painel de chaves.
;---------------------------------------------------
ORG 100
A:      DS  1
B:      DS  1
R:      DS  1

CHAVES  EQU 0
STATUS  EQU 1
VISOR   EQU 0

ORG 0
INICIO:
        IN   STATUS     ; Lê A das chaves
        AND  #1
        JZ   INICIO
        IN   CHAVES
        STA  A
        OUT  VISOR

STATUS2:
        IN   STATUS     ; Lê B das chaves
        AND  #1
        JZ   STATUS2
        IN   CHAVES
        STA  B
        OUT  VISOR

; --- Algoritmo de Euclides ---
EUCLID:
        LDA  B
        OR   #0
        JZ   FIM        ; Se B = 0, MDC = A

; Calcula R = A mod B por subtrações
        LDA  A
        STA  R

RESTO:  LDA  R
        SUB  B
        JN   PROXIMO    ; Se R < B, R é o resto
        JZ   PROXIMO    ; Se R = 0, resto é 0
        STA  R
        JMP  RESTO

PROXIMO:
        LDA  B
        STA  A          ; A = B
        LDA  R
        STA  B          ; B = R
        JMP  EUCLID

FIM:    LDA  A
        OUT  VISOR      ; Exibe o MDC
        HLT
        END  INICIO
