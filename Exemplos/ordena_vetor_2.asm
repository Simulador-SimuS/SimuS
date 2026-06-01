;---------------------------------------------------
; Programa: Ordena um vetor em ordem crescente
;           (versão com ponteiros diretos)
; Autor: Thales de Freitas
; Data: 02/05/2016
; Arquivo: ordena_vetor_2.asm
;---------------------------------------------------
; Variante do Selection Sort que recalcula PT_I e
; PT_J como &X[i] e &X[j] a cada iteração, sem
; manter uma variável ENDERX separada.
;---------------------------------------------------
ORG 200
PT_I:   DW  X           ; Ponteiro para X[i]
PT_J:   DW  X+1         ; Ponteiro para X[j]
I:      DB  0           ; Índice externo
J:      DS  1           ; Índice interno
TMP:    DS  1           ; Auxiliar para a troca
X:      DB  6, 2, 20, 2, 10, 5, 60, 4, 8, 0FFh

ORG 0
        JMP  INICIO_I

FOR_I:
        LDA  I
        ADD  #1
        STA  I          ; i = i + 1
        LDA  #8
        SUB  I          ; i <= 8 ?
        JN   FIM        ; Se não, termina

INICIO_I:
        LDA  #X         ; PT_I = &X[i]
        ADD  I
        STA  PT_I

        LDA  I          ; j = i + 1
        ADD  #1
        STA  J
        JMP  INICIO_J

FOR_J:
        LDA  J
        ADD  #1
        STA  J          ; j = j + 1
        LDA  #9
        SUB  J          ; j <= 9 ?
        JN   END_I      ; Se não, volta ao laço externo

INICIO_J:
        LDA  #X         ; PT_J = &X[j]
        ADD  J
        STA  PT_J

COMP:   LDA  @PT_I
        SUB  @PT_J      ; X[i] > X[j] ?
        JN   END_J      ; Não: próxima iteração

TROCA:  LDA  @PT_I      ; Troca X[i] com X[j]
        STA  TMP
        LDA  @PT_J
        STA  @PT_I
        LDA  TMP
        STA  @PT_J

END_J:  JMP  FOR_J
END_I:  JMP  FOR_I

FIM:    HLT
        END  0
