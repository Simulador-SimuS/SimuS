;---------------------------------------------------
; Programa: Blink Led Wiring Pi
; Autor: Alonso Matos
; Data: 09.08.2017
;---------------------------------------------------
; Constantes do programa
SAIDA           EQU     1
ALTO            EQU     1
BAIXO           EQU     0
PINO            EQU     23
PIN_MODE        EQU     101
PIN_WRITE       EQU     102
TRAP_DELAY      EQU     5
; Variáveis
ORG 100
T1000:	        DW   1000
PIN_TRAP:	DS	3

ORG	 0
;a numeracao dos pinos segue a referencia do wiringPi
	LDA  #PINO             ; pino desejado = 23
	STA  PIN_TRAP
;
	LDA  #SAIDA            ; modo de saída
	STA  PIN_TRAP+1
	LDA  #PIN_MODE
	TRAP PIN_TRAP

LOOP:
	LDA  #ALTO             ; coloca ‘1’  no pino 23
	STA  PIN_TRAP+1
	LDA  #PIN_WRITE
	TRAP PIN_TRAP
;
	LDA  #TRAP_DELAY       ; espera (1000 ms)
	TRAP T1000
;
	LDA  #BAIXO	       ; coloca ‘0’  no pino 23
	STA  PIN_TRAP +1
	LDA  #PIN_WRITE
	TRAP PIN_TRAP
;
	LDA  #TRAP_DELAY       ; espera (1000 ms)
	TRAP T1000
;
	JMP  LOOP
END	 0
