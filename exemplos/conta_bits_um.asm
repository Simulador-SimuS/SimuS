;---------------------------------------------------
; Programa: Rotina que conta o número de bits em
;           uma palavra de 32 bits
; Autor: Gabriel P. Silva
; Data: 08.03.20124
;---------------------------------------------------
ORG 100
TESTE:    DW 55AAh, 5501h     ; Palavra de 32 bits
ENDER:    DW 0                ; Salva endereço do byte na palavra
PC:       DW 0                ; Salva apontador de instruções
TEMP:     DS 1                
TOTAL:    DB 0                ; Total de bits em '1'
CONTADOR: DB 0                ; Número de bytes já lidos

ORG 0
ROTINA:  POP
         STA PC
         POP
         STA PC+1              ; Tira o PC da pilha e salva na memória
         POP
         STA ENDER
         POP
         STA ENDER+1           ; Salva o endereço da palavra
INICIO:  LDA @ENDER
         STA TEMP
LOOP:    LDA TEMP
         OR  #0                ; Se estiver tudo zerado acabou
         JZ  CONT              ;
         SHL                   ; Senão desloca de um bit para esquerda
         STA TEMP              ;
         JNC  FIM              ; Testa se  igual a '1'
         LDA  #1               ; se for incrementa total
         ADD  TOTAL            ;
         STA  TOTAL            ;
FIM:     JMP LOOP
CONT:    LDA ENDER
         ADD #1
         STA ENDER             ; ENDER = ENDER + 1
         LDA CONTADOR
         ADD #1
         STA CONTADOR          ; CONTADOR = CONTADOR + 1
         SUB #4                ; Leu os quatro bytes?
         JNZ INICIO
         LDA PC+1              ; Restaura o PC para a pilha
         PUSH
         LDA PC
         PUSH
         LDA TOTAL             ; Coloca o total no acumulador
         RET
         NOP
MAIN:    LDA #0               ; macete para parte alta do endereço
         PUSH
         LDA #TESTE
         PUSH
         JSR ROTINA
         OUT 0
         HLT
END      MAIN
