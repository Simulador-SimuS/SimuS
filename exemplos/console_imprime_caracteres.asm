;---------------------------------------------------
; Programa: Imprime uma sequencia de 26 caracteres
; na console
; Autor: José Antonio Borges
; Data: 09.03.2024
;---------------------------------------------------
ORG 100
letra:  DS 1
conta:  DB 26
cr:     DB 0dh
lf:     DB 0ah

ORG 0 
espera: LDA #1       ; Lê uma letra inical da console
        TRAP  0 
        OR #0        
        JZ espera     
        STA letra    ; Armazena o valor lido

loop:   LDA #2       ; Fica em loop até conta = 0 
        TRAP letra   ; Imprime o caractere na console
        LDA letra
        ADD #1
        STA letra     ; Avança para a letra seguinte
        LDA conta
        SUB #1
        STA conta
        JNZ loop
        
        LDA #2       ; Imprime retorno de carro  
        TRAP cr
        LDA #2
        TRAP lf
        HLT

        END espera
