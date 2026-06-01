;---------------------------------------------------
; Programa: Soma os elementos de um vetor usando
;           o registrador SP como ponteiro
; Autores: Antonio Borges e Gabriel P. Silva
; Data: 10/08/2023
; Arquivo: soma_vetor_sp.asm
;---------------------------------------------------
; Demonstra o uso do Stack Pointer para percorrer
; um vetor: carrega SP com o endereço do vetor e
; usa POP para ler cada elemento em sequência.
;
; ATENÇÃO: este uso do SP é apenas didático.
; Em programas reais o SP deve ser reservado para
; a pilha de chamadas de subrotinas.
;---------------------------------------------------
ORG 100
VETOR:  DB  10, 20, 30, 40, 50   ; 5 elementos
PONT:   DW  VETOR                 ; Endereço do início do vetor
SOMA:   DB  0
CONT:   DB  0

ORG 0
        LDS  PONT       ; SP = endereço de VETOR

INICIO:
        POP             ; ACC = memória[SP]; SP = SP + 1
        ADD  SOMA       ; Acumula em SOMA
        STA  SOMA
        LDA  CONT       ; Incrementa o contador
        ADD  #1
        STA  CONT
        SUB  #5         ; Compara com 5 (tamanho do vetor)
        JNZ  INICIO     ; Continua enquanto CONT < 5

        LDA  SOMA
        OUT  0          ; Exibe a soma no visor
        HLT
        END  INICIO
