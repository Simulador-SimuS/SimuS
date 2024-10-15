;----------------------------------------------------
; Rotina que calcula a soma dos elementos do vetor
; com uso do stack pointer
; Autores: Antonio Borges e Gabriel P. Silva
; Data:  10/08/2023
; Arquivo:soma_vetor_sp.asm
;----------------------------------------------------
ORG 100
VETOR:  DB  10, 20, 30, 40, 50
PONT:   DW  VETOR
SOMA:   DB  0
CONT:   DB  0 
ORG 0
        LDS  PONT   ; SP = & VETOR
INICIO: 
        POP         ; ACC = @SP
        ADD  SOMA   ; Totaliza com SOMA 
        STA  SOMA   ; Salva em SOMA
        LDA  CONT   ; Incrementa contador
        ADD  #1     ; 
        STA  CONT   ; Salva na memória 
        SUB  #5     ;
        JNZ  INICIO ; Continua enquanto < 5 
        HLT
        END INICIO
