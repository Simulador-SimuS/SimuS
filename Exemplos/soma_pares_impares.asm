;----------------------------------------------------
; Rotina que calcula a soma dos elementos pares
; ou ímpares do vetor
; Autores: Antonio Borges e Gabriel P. Silva
; Data:  10/08/2023
; Arquivo: soma_pares_impares.asm
; opção na chave (bit 0)
;----------------------------------------------------
ORG  0
TESTA_SOMA_VETOR:
     LDS  #STACK_ADDR    ; Inicializa a pilha
     LDA  PT_VETOR       ; Carrega o endereço do vetor na pilha
     PUSH
     LDA  PT_VETOR+1
     PUSH
     LDA  TAMANHO_VETOR  ; Carrega o tamanho do vetor
     PUSH
ENTRA:
     IN   STATUS         ; Verifica se entrou dado 
     AND  #1             ;
     JZ   ENTRA   
     IN   CHAVES         ; opção 0: soma elementos pares,
                         ; 1: soma elementos ímpares
     PUSH
     JSR  SOMAVETOR      ; Chama a rotina
     OUT  VISOR          ; Mostra o acumulador no visor
     HLT
;-------------------------------
PT_VETOR:      DW  ORIGEM    ; Ponteiro para a área de origem
ORIGEM:        DB  5,7,2,8,2,1,1,9
TAMANHO_VETOR: DB  8         ; Tamanho do vetor
STACK:         DS  40        ; Região reservada para a pilha
STACK_ADDR:    DS  0         ; A pilha começa aqui
VISOR          EQU 0
CHAVES         EQU 0
STATUS         EQU 1
;----------------------------------------------------------
; Rotina SOMAVETOR
; Na pilha: o endereço de um vetor, o tamanho do vetor e 
; a opção
; Opções: 0 soma os pares, 1 soma os ímpares
;----------------------------------------------------------
SOMAVETOR:
     POP                  ; Salva o endereço de retorno
     STA  RETURN_ADDR     ; Jogado na pilha pelo JSR
     POP
     STA  RETURN_ADDR+1
     POP                  ; Pega a opção de processamento
     STA  OPC
     POP                  ; Pega o tamanho do vetor na pilha
     STA  TAMANHO         ; Salva em tamanho
     POP                  ; Pega o endereço do vetor na pilha
     STA  PVET+1          ; Salva em pvet
     POP
     STA  PVET
     LDA  #0              ; Inicializa a soma
     STA  SOMA   
     LDA  #0              ; Inicializa o contador de elementos
     STA  CONTADOR
LOOP:
     LDA  CONTADOR        ; Carrega o contador
     SUB  TAMANHO         ; Compara com o tamanho do vetor
     JZ   FIM_SOMAPAR     ; Se for igual, termina a rotina
     LDA  @PVET           ; Pega o próximo elemento
     AND  #1              ; Testa se é par ou ímpar
     XOR  OPC             ; Realiza a operação "XOR"
     JNZ  SALTA           ; Se não for, pula para SALTA
     LDA  @PVET           ; Faz a soma
     ADD  SOMA
     STA  SOMA
SALTA:
     LDA  PVET            ; Incrementa o ponteiro
     ADD  #1
     STA  PVET
     LDA  PVET+1    
     ADC  #0
     STA  PVET+1
     LDA  CONTADOR        ; Incrementa o contador de elementos
     ADD  #1 
     STA  CONTADOR
     JMP  LOOP
FIM_SOMAPAR:
     LDA  RETURN_ADDR+1   ; Recoloca na pilha o 
     PUSH                 ; endereço de retorno
     LDA  RETURN_ADDR
     PUSH
     LDA  SOMA
     RET                  ; Sai da rotina
;---------------------------------------------------
; Variáveis da rotina
;---------------------------------------------------
PVET:          DW  0 
OPC:           DB  0
SOMA:          DB  0
TAMANHO:       DB  0
CONTADOR:      DB  0
RETURN_ADDR:   DW  0
END  TESTA_SOMA_VETOR
