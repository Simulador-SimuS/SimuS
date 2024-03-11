;-------------------------------
; Programa: Soma os elementos de um vetor
; Autor: Gabriel P. Silva
; Data: 08.03.2024
;------------------------------

DISPLAY EQU 0

ORG 100
X:   	DB 1, 2, 3, 4, 5, 6, 7, 8, 9

I:   	DB 	0
SOMA: 	DB 	0 
PTR: 	DW 	X
TAM:    DB 	9


ORG 0

INICIO: 
 	LDA 	I	; Compara o indice com o 
     	SUB 	TAM	; tamanho do vetor.
     	JN  	TOTAL	; Se for menor continua
        JMP 	FIM	; senão, termina.

TOTAL:  LDA 	SOMA	; Atualiza o valor da soma
        ADD 	@PTR	; com o valor do elemento 
        STA 	SOMA	; atual do vetor.
        OUT 	DISPLAY	; Mostra o valor atual da soma.  

INC:  	LDA 	I	; Incrementa o indice
     	ADD 	#1	; do vetor
     	STA 	I	; e atualiza na memória.
     	LDA 	PTR	; Incrementa o apontador
     	ADD 	#1	; para o proximo elemento
     	STA 	PTR	; do vetor (só funciona para vetores pequenos).
     	JMP 	INICIO	; Volta para o início.

FIM:    LDA 	SOMA	; Mostra a soma final 
        OUT 	DISPLAY ; no display em hexadecimal.
 
        HLT		; Termina a execução.
