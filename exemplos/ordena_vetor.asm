;---------------------------------------------------
; Programa: Ordena um vetor
; Autor: Thales de Freitas
; Data: 08.03.2024
;---------------------------------------------------
	
ORG 0
PT_I:     DW 0
PT_J:     DW 0
I:        DB 0
J:        DS 1
TMP:      DS 1
X:        DB 88, 2, 20, 2, 10, 5, 60, 4, 8, 6
TAM_1:     DB 9
PT_X:     DW X

ORG 100 
FOR_I:
        LDA I
        ADD #1
        STA I       ;  i = i + 1
        LDA TAM_1   ;
        SUB #1      ;
        SUB I       ;  i > TAM-2 ?
        JN  FIM     ;  Se verdadeiro termina
INICIO_I:
        LDA PT_X    ; Endereço inicial de X
	ADD I       ;
	STA PT_I    ;  PT_I = &X[i]
        LDA I       ;  j = i + 1
        ADD #1      ;
        STA J
        JMP INICIO_J
FOR_J:   
	LDA J
        ADD #1 
        STA J        ; j = j + 1
        LDA TAM_1    ; j > TAM-1?
        SUB J        ; Se verdadeiro sai do laço
        JN END_I
INICIO_J:
        LDA PT_X     ; Endereço inicial de X
	ADD J
        STA PT_J     ; PT_J = &X[j]
COMP:
	LDA @PT_I    ; 
        SUB @PT_J    ; X[i] > X[j] ?
        JN END_J     ; Senão pula  	
TROCA:	
	LDA @PT_I    ; Troca X[i] com X[j] 
	STA TMP      
        LDA @PT_J
        STA @PT_I
	LDA TMP
        STA @PT_J
END_J:  
        JMP FOR_J
END_I:  
        JMP FOR_I
FIM:
        HLT
END     INICIO_I
