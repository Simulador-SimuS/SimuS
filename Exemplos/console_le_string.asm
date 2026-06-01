;---------------------------------------------------
; Programa: Lê uma string do terminal e a reescreve
; Arquivo: console_le_string.asm
;---------------------------------------------------
; Demonstra o TRAP 3 (lê string) e o TRAP 4
; (escreve string).
;
; O usuário digita uma linha de texto e pressiona
; ENTER; o programa ecoa a string precedida de "> ".
;---------------------------------------------------
ORG 100
BUFFER:  DS   80         ; Buffer para a string lida (máx. 79 + NULL)
PROMPT:  STR  "> "
         DB   0
CR:      DB   0Dh
LF:      DB   0Ah

LESTR    EQU  3          ; TRAP 3: lê string até ENTER
IMPSTR   EQU  4          ; TRAP 4: imprime string até NULL
IMPCHAR  EQU  2          ; TRAP 2: imprime caractere

ORG 0
INICIO:
        LDA  #LESTR
        TRAP BUFFER      ; Lê a string digitada para BUFFER

        LDA  #IMPSTR
        TRAP PROMPT      ; Imprime "> "

        LDA  #IMPSTR
        TRAP BUFFER      ; Imprime a string lida

        LDA  #IMPCHAR
        TRAP CR          ; Nova linha
        LDA  #IMPCHAR
        TRAP LF

        JMP  INICIO      ; Repete indefinidamente
        END  INICIO
