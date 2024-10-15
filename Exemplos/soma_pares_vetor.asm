;---------------------------------------------------
; Programa que soma os valores pares de um vetor
; Autor: Gabriel P. Silva e Antonio Borges
; Data:  13/08/2023
; Arquivo: soma_pares_vetor.asm
;---------------------------------------------------
ORG 100          ; Variáveis
I:      DB  0
TAM:    DB  6 
PARES:  DB  0
PT:     DW  X
X:      DB  6, 13, 8, 10, 9, 23

ORG 0            ; Código
    LDA I  
LACO:            
    SUB  TAM     ; Repete até que I=6 
    JZ   FIM    
    LDA  @PT     ; Carrega o elemento no acumulador
    AND  #1      ; Testa se é par (bit 0=0)
    JNZ  SENAO
    LDA  PARES   ; Se for, faz pares++    
    ADD  #1
    STA  PARES
SENAO:           ; Endereço do elemento atual
    LDA  PT      ; Calcula o endereço de X[I]
    ADD  #1
    STA  PT
    LDA  PT+1
    ADC  #0
    STA  PT+1
    LDA  I 
    ADD  #1
    STA  I
    JMP  LACO    ; Volta ao inicio
FIM:             ; Mostra no visor o total de pares
    LDA  PARES
    OUT  0       
    HLT          ; Termina o programa
    END  0
