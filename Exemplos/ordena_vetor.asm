;---------------------------------------------------
; Programa: Ordena um vetor em ordem crescente
;           (Selection Sort com dois ponteiros)
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: ordena_vetor.asm
;---------------------------------------------------
; Implementa Selection Sort com dois índices i e j.
; Para cada i de 0 a N-2, percorre j de i+1 a N-1
; e troca X[i] com X[j] se X[i] > X[j].
;---------------------------------------------------
ORG 200
PT_I:   DW  0           ; Ponteiro para X[i]
PT_J:   DW  0           ; Ponteiro para X[j]
I:      DB  0           ; Índice externo
J:      DS  1           ; Índice interno
TMP:    DS  1           ; Auxiliar para a troca
ENDERX: DW  X           ; Endereço base do vetor
X:      DB  6, 2, 20, 2, 10, 5, 60, 4, 8, 65

ORG 0
FOR_I:
        LDA  I
        ADD  #1
        STA  I          ; i = i + 1
        LDA  #8
        SUB  I          ; i <= 8 ?
        JN   FIM        ; Se não, termina

INICIO_I:
        LDA  ENDERX     ; PT_I = &X[i]
        ADD  I
        STA  PT_I
        LDA  ENDERX+1
        ADC  #0
        STA  PT_I+1

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
        LDA  ENDERX     ; PT_J = &X[j]
        ADD  J
        STA  PT_J
        LDA  ENDERX+1
        ADC  #0
        STA  PT_J+1

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
        END  INICIO_I
