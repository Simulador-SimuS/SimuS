;--------------------------------
; Programa: Encontra o menor elemento de um vetor
; Autor: Thales de Freitas
; Data: 08.05.2023
;--------------------------------
	
ORG 0
PT:     DW A
MIN:    DS 1
I:      DB 0 
DEZ:    DB 10
A:      DB 6, 2, 2, 3, 1, 5, 6, 7, 8, 9
	
ORG 100 
INICIO:
	LDA @PT
	STA MIN    ; MIN = A[0]
        JMP TESTE
FOR: 	
	LDA PT 
        ADD #1
	STA PT     ; PT = PT + 1
        LDA PT+1
        ADC #0     ; Incrementa a parte alta
        STA PT+1   ; quando necessário.
	LDA MIN    
        SUB @PT    ; A[i] < MIN ?
	JN  TESTE
	LDA @PT    ; MIN = A[i]
	STA MIN
TESTE:	
        LDA I 
	ADD #1
	STA I       ; I = I + 1
        SUB DEZ     ; I < 10 ?
	JN FOR      ; Se verdade fica no laço,
        LDA MIN     ; senão termina.
        OUT 0       ; VISOR = MIN
	HLT         ; FIM
END     INICIO
