;----------------------------------------------
; Rotina que copia uma área de memória terminada
; em #0 para outra
; Autores: Antonio Borges e Gabriel P. Silva
; Data:  10/08/2023
; Arquivo: copia_cadeia.asm
;---------------------------------------------
;---------------------------------------------
; Programa de teste da rotina strcopy
;---------------------------------------------
     ORG  0
TESTA_STRCOPY:
     LDS  #STACK_ADDR    ; Inicializa a pilha
     LDA  PT_ORIGEM      ; Carrega o ponteiro para a área na pilha
     PUSH
     LDA  PT_ORIGEM+1
     PUSH
     LDA  PT_DESTINO     ; Carrega o ponteiro para a área na pilha
     PUSH
     LDA  PT_DESTINO+1
     PUSH
     JSR  STRCOPY        ; Chama a rotina   
     HLT                 ; Conferir no simulador de memória
;-------------------------------
PT_ORIGEM:   DW   ORIGEM    ; ponteiro para a área origem
ORIGEM:      DB   5,7,2,8,2,1,1,9,0
PT_DESTINO:  DW   DESTINO    ; ponteiro para a área destino
DESTINO:     DS   20
STACK:       DS   32      ; região reservada para a pilha
STACK_ADDR:  DS   0       ; pilha começa no fim desta região
;-------------------------------------------------
; Rotina STRCOPY
; Na pilha: o endereço inicial e o endereço final
;-------------------------------------------------
STRCOPY:
     POP                  ; salva o endereço de retorno
     STA  RETURN_ADDR     ; jogado na pilha pelo JSR
     POP
     STA  RETURN_ADDR+1
     POP                  ; pega o destino na pilha e salva
     STA  DEST+1
     POP 
     STA  DEST
     POP                  ; pega a origem na pilha e salva
     STA  ORIG+1
     POP 
     STA  ORIG
; repete o loop enquanto byte a mover != 0
LOOP:
     LDA  @ORIG           ; copia o byte da origem para o destino
     STA  @DEST           
     OR   #0              ; testa se ^orig = 0
     JZ   FIM_STRCOPY     ; se for, termina rotina
     LDA  ORIG            ; incrementa o ponteiro ORIGEM
     ADD  #1
     STA  ORIG
     LDA  ORIG+1    
     ADC  #0
     STA  ORIG+1
     LDA  DEST            ; incrementa o ponteiro DESTINO
     ADD  #1
     STA  DEST
     LDA  DEST+1    
     ADC  #0
     STA  DEST+1
     JMP  LOOP
FIM_STRCOPY:
     LDA  RETURN_ADDR+1    ; recoloca na pilha o 
     PUSH                  ; endereço de retorno 
     LDA  RETURN_ADDR
     PUSH
     RET                   ; Sai da rotina
;---------------------------------------------------
; Variáveis da rotina
;---------------------------------------------------
ORIG:          DW  0 
DEST:          DW  0
VAL:           DB  0
RETURN_ADDR:   DW  0
END  TESTA_STRCOPY
