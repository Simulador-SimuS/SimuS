;--------------------------------------------------
; Programa: Ordena um Vetor 
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: ordena_vetor.asm
;--------------------------------------------------
	
ORG 200
PT_I:     DW 0
PT_J:     DW 0
I:        DB 0
J:        DS 1
TMP:      DS 1
ENDERX:   DW X
X:        DB 6, 2, 20, 2, 10, 5, 60, 4, 8, 65

ORG 0 
FOR_I: 	
        LDA I
        ADD #1 
        STA I       ;  i = i + 1
        LDA #8  
        SUB I       ;  i <= 8 ?
        JN  FIM     ;  Se falso termina
INICIO_I:
        LDA ENDERX
	ADD I 
	STA PT_I    ;  PT_I = &X[i]
        LDA ENDERX+1
        ADC #0
        STA PT_I+1  ;
        LDA I       ;  j = i + 1
        ADD #1
        STA J
        JMP INICIO_J
FOR_J:   
	LDA J
        ADD #1 
        STA J        ; j = j + 1
        LDA #9       ; j < = 9?
        SUB J        ; Se falso sai do laço
        JN  END_I
INICIO_J:
        LDA ENDERX
	ADD J 
        STA PT_J     ; PT_J = &X[j]
        LDA ENDERX+1
        ADC #0
        STA PT_J+1
COMP:
	LDA @PT_I    ; 
        SUB @PT_J    ; X[i] > X[j] ?
        JN  END_J    ; Senão pula
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
END INICIO_I
