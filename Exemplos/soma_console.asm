;---------------------------------------------------
; Programa: Calcula uma soma e imprime o resultado
;           no terminal de E/S
; Autores: Antonio Borges e Gabriel P. Silva
; Data: 10/08/2023
; Arquivo: soma_console.asm
;---------------------------------------------------
; Calcula C = A + B e verifica se o resultado é 7.
; Usa o TRAP 4 para imprimir uma string terminada
; em NULL no terminal.
;---------------------------------------------------
ORG 100
CERTO:  STR  "A soma deu certo!"
        DB   0Ah        ; Nova linha
        DB   00h        ; Terminador NULL
ERRADO: STR  "A soma deu errado!"
        DB   0Ah
        DB   00h
A:      DB   3
B:      DB   4
C:      DS   1

IMPRIME EQU  4          ; TRAP 4: imprime string terminada em NULL

ORG 0
INICIO: LDA  A          ; C = A + B
        ADD  B
        STA  C
        SUB  #7         ; Verifica se C = 7
        JNZ  ELSE
THEN:
        LDA  #IMPRIME
        TRAP CERTO      ; Imprime mensagem de acerto
        JMP  FIM
ELSE:
        LDA  #IMPRIME
        TRAP ERRADO     ; Imprime mensagem de erro
FIM:    HLT
        END  INICIO
