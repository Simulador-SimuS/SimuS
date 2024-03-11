;---------------------------------------------------
; Programa: Pisca Led
; Autor: José Antonio Borges
; Data: 09.08.2017
;---------------------------------------------------
; Constantes do programa
PINO         EQU  13
SAIDA        EQU  1
PIN_MODE     EQU  101
PIN_WRITE    EQU  102
ALTO         EQU  1
BAIXO        EQU  2
TRAP_DELAY   EQU  5

ORG 100

T1000:	        DW	1000
PIN_TRAP:	DS	3

ORG	 0
	LDA	#PINO  	       ; pino desejado = 13
	STA	PIN_TRAP
;
	LDA	#SAIDA	       ; modo de saída
	STA	PIN_TRAP +1
	LDA	#PIN_MODE
	TRAP	PIN_TRAP

LOOP:
	LDA	#ALTO	        ; coloca ‘1’  no pino 13
	STA	PIN_TRAP+1
	LDA	#PIN_WRITE
	TRAP	PIN_TRAP
;
	LDA	#TRAP_DELAY	; espera (1000 ms)
	TRAP	T1000
;
	LDA	#BAIXO	        ; coloca ‘0’  no pino 13
	STA	PIN_TRAP +1
	LDA	#PIN_WRITE
	TRAP	PIN_TRAP
;
	LDA	#TRAP_DELAY	; espera (1000 ms)
	TRAP	T1000
;
	JMP	LOOP
END	 0
