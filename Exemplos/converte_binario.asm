;------------------------------------------------------------
; Rotina para imprimir um valor binário em formato decimal
; no banner com ajustes de acordo com o valor
; Autores: Antonio Borges e Gabriel P. Silva
; Data: 10/08/2023
; Arquivo: converte_binario.asm
;------------------------------------------------------------
ORG 0     
TESTA_CONVERSAO:
     IN   STATUS
     AND  #1                
     JZ   TESTA_CONVERSAO  ; Lê o valor binário
     IN   CHAVES           ; do painel de chaves
     JSR  AJUSTA_VALOR     ; Chama a rotina de ajuste
     JSR  CONVERTE_DECIMAL ; Chama a rotina de conversão
     HLT
;-------------------------------
STACK:         DS  40      ; região reservada para a pilha
STACK_ADDR:    DS  0       ; pilha começa no fim desta região
CHAVES         EQU 0
BANNER         EQU 2
CLEAR          EQU 3
STATUS         EQU 1
;------------------------------------------------------------
; Rotina AJUSTA_VALOR
; Faz os ajustes de acordo com o valor
;------------------------------------------------------------
AJUSTA_VALOR:
     STA  VALOR_BIN
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #100           ; Subtrai 100
     JNC  MAIOR_100      ; Se o resultado for positivo, erro
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #90            ; Subtrai 90
     JNC  MAIOR_90       ; Se o resultado for positivo, desvia
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #80            ; Subtrai 80
     JNC MAIOR_80        ; Se o resultado for positivo, desvia
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #70            ; Subtrai 70
     JNC  MAIOR_70       ; Se o resultado for positivo, desvia
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #60            ; Subtrai 60
     JNC  MAIOR_60       ; Se o resultado for positivo, desvia
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #50            ; Subtrai 50
     JNC  MAIOR_50       ; Se o resultado for positivo, desvia
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #40            ; Subtrai 40
     JNC  MAIOR_40       ; Se o resultado for positivo, desvia
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #30            ; Subtrai 30
     JNC  MAIOR_30       ; Se o resultado for positivo, desvia
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #20            ; Subtrai 20
     JNC  MAIOR_20       ; Se o resultado for positivo, desvia
     LDA  VALOR_BIN      ; Carrega o valor binário
     SUB  #10            ; Subtrai 10
     JNC  MAIOR_10       ; Se o resultado for positivo, desvia
     LDA  VALOR_BIN
     RET
MAIOR_100:
     OUT   CLEAR 
     LDA   #3FH          ; Imprime ? indicando erro na 
     OUT   BANNER        ; conversão
     HLT
MAIOR_90:
     LDA  VALOR_BIN      ; Adiciona 54 
     ADD  #54            ; para valores entre 90 e 99
     STA  VALOR_BIN      ; Armazena o valor ajustado
     RET
MAIOR_80:
     LDA VALOR_BIN       ; Adiciona 48 
     ADD  #48            ; para valores entre 80 e 89
     STA  VALOR_BIN      ; Armazena o valor ajustado
     RET
MAIOR_70:
     LDA  VALOR_BIN      ; Adiciona 42 
     ADD  #42            ; para valores entre 70 e 79
     RET
MAIOR_60:
     LDA  VALOR_BIN      ; Adiciona 36
     ADD  #36            ; para valores entre 60 e 69
     RET
MAIOR_50:
     LDA  VALOR_BIN      ; Adiciona 30
     ADD  #30            ; para valores entre 50 e 59
     RET
MAIOR_40:
     LDA  VALOR_BIN      ; Adiciona 24
     ADD  #24            ; para valores entre 40 e 49
     RET
MAIOR_30:
     LDA  VALOR_BIN      ; Adiciona 18
     ADD  #18            ; para valores entre 30 e 39
     RET
MAIOR_20:
     LDA  VALOR_BIN      ; Adiciona 12
     ADD  #12            ; para valores entre 20 e 29
     RET
MAIOR_10:
     LDA  VALOR_BIN      ; Adiciona 6
     ADD  #6             ; para valores entre 10 e 20
     RET
;------------------------------------------------------------
; Rotina CONVERTE_DECIMAL
; Converte um valor binário em formato ASCII decimal
;------------------------------------------------------------
CONVERTE_DECIMAL:
     STA  VALOR_BIN      ; Recebe o valor no acumulador
     OUT  CLEAR          ; Limpa banner
     SHR                 ; Separa a parte alta
     SHR
     SHR 
     SHR
     ADD  #30H           ; Converte para ASCII
     OUT  BANNER         ; Imprime o dígito alto no banner
     LDA  VALOR_BIN      ; Carrega o valor binário
     AND  #0FH           ; Separa a parte baixa
     ADD  #30H           ; Converte para ASCII
     OUT  BANNER         ; Imprime o dígito baixo no banner
     RET
;------------------------------------------------------------
; Variáveis das rotinas
;------------------------------------------------------------
VALOR_BIN:  DB 0
            END  TESTA_CONVERSAO
