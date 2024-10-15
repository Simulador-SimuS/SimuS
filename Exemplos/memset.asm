;-----------------------------------------------------------
; Rotina que preenche uma área de memória com valor
; dado (memset)
; Autor: Antonio Borges e Gabriel P. Silva
; Data:  10/08/2023
; Arquivo: memset.asm
;-----------------------------------------------------------

;----------------------------------------------------
; Programa de teste da rotina memset
;----------------------------------------------------
     ORG  0
TESTA_MEMSET:
     LDS  #STACK_ADDR    ; Inicializa a pilha
     LDA  PT_AREA        ; Carrega o ponteiro para 
     PUSH                ; a área na pilha
     LDA  PT_AREA+1
     PUSH
     LDA  CONTADOR       ; Carrega o contador (16 bits)
     PUSH                ;  na pilha 
     LDA  CONTADOR+1
     PUSH
     LDA  VALOR          ; Carrega o valor na pilha
     PUSH
     JSR  MEMSET         ; Chama a rotina   
     HLT                 ; Conferir no simulador de memória

;-------------------------------
PT_AREA:     DW   AREA   ; ponteiro para a área a preencher
AREA:        DS   512    ; área de 512 bytes
CONTADOR:    DW   512    ; contador = 512
VALOR:       DB   5      ; valor a preencher: 5
STACK:       DS   32     ; região reservada para a pilha
STACK_ADDR:  DS   0      ; pilha começa no fim desta região

;-----------------------------------------------------------
; Rotina MEMSET
; Na pilha: o endereço inicial, o número de bytes e o valor. 
;-----------------------------------------------------------
MEMSET:
     POP                 ; salva o endereço de retorno
     STA  RETURN_ADDR    ; colocado na pilha pelo JSR
     POP
     STA  RETURN_ADDR+1

     POP                 ; pega o valor da pilha e salva
     STA  VAL
     POP                 ; pega o contador da pilha e salva
     STA  CONT+1         ; em cont
     POP 
     STA  CONT
     POP                 ; pega o ponteiro da área da pilha 
     STA  PT+1           ; e salva em pt
     POP 
     STA  PT
; repete o loop enquanto contador > 0
LOOP:
     LDA  CONT           ; testa se contador = 0
     OR   CONT+1
     JZ   FIM_MEMSET     ; se for, termina rotina
     LDA  CONT           ; Decrementa o contador (16 bits)
     SUB  #1
     STA  CONT
     LDA  CONT+1    
     SBC  #0
     STA  CONT+1
     LDA  VAL            ; Preenche próximo byte da área
     STA  @PT
     LDA  PT             ; incrementa o ponteiro
     ADD  #1
     STA  PT
     LDA  PT+1    
     ADC  #0
     STA  PT+1
     JMP  LOOP
FIM_MEMSET:
     LDA  RETURN_ADDR+1  ; recoloca na pilha o endereço de retorno 
     PUSH
     LDA  RETURN_ADDR
     PUSH
     RET                 ; Sai da rotina
;---------------------------------------------------
; Variáveis da rotina
;---------------------------------------------------
CONT:          DW  0 
PT:            DW  0
VAL:           DB  0
RETURN_ADDR:   DW  0
END  TESTA_MEMSET
