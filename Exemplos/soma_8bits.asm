;--------------------------------------------
; Exemplo de chamada de função com parâmetros
; Autores: Gabriel P. Silva e Antonio Borges
; Data: 01/08/2023
; Arquivo: soma_8bits.asm
;---------------------------------------------
      ORG     0
INICIO:
      LDS  #100h       ; Inicia o apontador de pilha
      LDA  X           ; coloca primeiro parâmetro na pilha
      PUSH
      LDA  Y           ; coloca segundo parâmetro na pilha
      PUSH
      JSR  FUNC2PARAM  ; chama a função
      POP              ; retira o valor de retorno na pilha
      STA  RESULT      ; salva e exibe resultado
      OUT  VISOR
      HLT
;-----------------------------
FUNC2PARAM:
      POP              ; salva o endereço de retorno
      STA  SALVARET    ; (16 bits que estão no topo da pilha)
      POP
      STA  SALVARET+1        
      POP              ; retira o segundo parâmetro da pilha
      STA  P2
      POP
      STA  P1          ; retira o primeiro parâmetro da pilha
      ADD  P2          ; executa a soma dos parâmetros
      PUSH             ; salva resultado na pilha
      LDA  SALVARET+1  ; recupera o endereço de retorno no
      PUSH             ; topo da pilha
      LDA  SALVARET    ; (na ordem inversa ao salvamento)
      PUSH
      RET              ; retorna
;----Variáveis da Rotina ---------------------
P1:       DB   1       ; primeiro parâmetro
P2:       DB   1       ; segundo parâmetro
SALVARET: DW   0       ; endereço de retorno

;----Variáveis do Programa Principal ---------
VISOR     EQU  0
X:        DB   2       ; X = 2
Y:        DB   5       ; Y = 5
RESULT:   DS   1
          END INICIO
