;----------------------------------------------------
; Verifica o resultado de uma soma e imprime na console
; Autores: Antonio Borges e Gabriel P. Silva
; Data:  10/08/2023
; Arquivo: soma_console.asm
;----------------------------------------------------
ORG  100    ; Carrega as variáveis a partir
            ; do endereço 100 de memória
CERTO: STR "A soma deu certo!"
         DB 0Ah
         DB 00h
ERRADO: STR "A soma deu errado!"
         DB 0Ah
         DB 00h
IMPRIME  EQU 4
A:       DB  3 
B:       DB  4
C:       DS  1

ORG 0    ; Carrega as instruções a  partir 
         ; do endereço 0 de memória
INICIO:	
         LDA A    ; ACC = A
         ADD B    ; ACC = A + B
         STA C    ; C = A + B
         SUB #7   ; ACC = ACC - 7
         JNZ ELSE ; SE ACC <> 0 GOTO ELSE
THEN: 
         LDA #IMPRIME  ; ACC = 4 (IMPRIME UMA LINHA)
         TRAP CERTO    ; IMPRIME A CADEIA CERTO
         JMP FIM       ; TERMINA
ELSE:	
         LDA #IMPRIME  ; ACC = 4 (IMPRIME UMA LINHA)
         TRAP ERRADO   ; IMPRIME A CADEIA ERRADO
FIM:
         HLT
         END INICIO   ; Define o endereço inicial de execução
