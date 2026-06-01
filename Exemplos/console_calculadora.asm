;---------------------------------------------------
; Programa: Calculadora simples no terminal
; Arquivo: console_calculadora.asm
;---------------------------------------------------
; Lê dois números (0-9) e um operador (+, -, *)
; do terminal e imprime o resultado. 
; Só lê números de um digito e o resultado deve estar em 0 e 9.
;
; Uso:
;   1. Digite o primeiro dígito (0-9) e ENTER
;   2. Digite o operador (+, - ou *) e ENTER
;   3. Digite o segundo dígito (0-9) e ENTER
;   O resultado aparece no terminal.
;---------------------------------------------------
ORG 200
OP1:     DS  1           ; Primeiro operando (ASCII)
OP2:     DS  1           ; Segundo operando (ASCII)
OPER:    DS  1           ; Operador (+, -, *)
RESULT:  DS  1           ; Resultado
STR_RES: STR " = "
         DB  0
CR:      DB  0Dh
LF:      DB  0Ah

IMPRIME  EQU 4           ; TRAP 4: imprime string
LECHAR   EQU 1           ; TRAP 1: lê um caractere
ESCCHAR  EQU 2           ; TRAP 2: escreve um caractere

ORG 0
INICIO:
; --- Lê o primeiro operando ---
        LDA  #LECHAR
        TRAP OP1            ; Lê dígito em OP1 e ACC
        LDA  #ESCCHAR 
        TRAP OP1
        LDA  OP1
        SUB  #30h           ; Converte ASCII '0'-'9' para 0-9
        STA  OP1


; --- Lê o operador ---
        LDA  #LECHAR
        TRAP OPER           ; Lê operador em OPER
        LDA  #ESCCHAR 
        TRAP OPER

; --- Lê o segundo operando ---
        LDA  #LECHAR
        TRAP OP2
        LDA  #ESCCHAR 
        TRAP OP2
        LDA  OP2
        SUB  #30h
        STA  OP2

; --- Calcula conforme o operador ---
        LDA  OPER
        SUB  #2Bh           ; '+' = 0x2B
        JZ   SOMA
        LDA  OPER
        SUB  #2Dh           ; '-' = 0x2D
        JZ   SUBTR
        LDA  OPER
        SUB  #2Ah           ; '*' = 0x2A
        JZ   MULT
        JMP  FIM            ; Operador desconhecido

SOMA:   LDA  OP1
        ADD  OP2
        STA  RESULT
        JMP  IMPRIME_RES

SUBTR:  LDA  OP1
        SUB  OP2
        STA  RESULT
        JMP  IMPRIME_RES

MULT:   LDA  #0             ; Multiplicação por somas repetidas
        STA  RESULT
        LDA  OP2
        STA  CNT
LMULT:  LDA  CNT
        JZ   IMPRIME_RES
        LDA  RESULT
        ADD  OP1
        STA  RESULT
        LDA  CNT
        SUB  #1
        STA  CNT
        JMP  LMULT

IMPRIME_RES:
        LDA  #IMPRIME
        TRAP STR_RES        ; Imprime " = "
        LDA  RESULT
        ADD  #30h           ; Converte para ASCII (funciona para 0-9)
        STA  DIGITO
        LDA  #ESCCHAR
        TRAP DIGITO         ; Imprime o dígito resultado
FIM:    HLT

ORG 200
CNT:    DS  1
DIGITO: DS  1
        END INICIO
