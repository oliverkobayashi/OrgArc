jmp main

; alocar variaveis
posNave: var #1			; Contem a posicao atual da Nave

main:
	Loadn R0, #1150			
	store posNave, R0		; Zera Posicao Atual da Nave
	
	loadn r7, #0    ; Contador
	loadn r1, #0 	; Resto 0 do MOD

loop: 	
		; Nave
		loadn r0, #10
		mod r0, r7, r0
		cmp r0, r1
		ceq Atualisa_Nave
		
		call Delay		 ; Aguarda um momento
		; Check Criterio de parada e Break

		inc r7	; count++
		jmp loop

		
fim:
	halt

Atualisa_Nave:
		push r0
		push r1

		load r0, posNave
		loadn r1, #' '  ; Espaco em branco para Apagar a Nave
		outchar r1, r0	 ; Apaga a nave
		
		inc R0			 ; Recalcula a posicao
		loadn r1, #1200 ; Criterio de Parada
		cmp r0, r1
		jne Atualisa_Nave_Skip
		loadn r0, #0
		
	Atualisa_Nave_Skip:
		store posNave, r0
		
		loadn r1, #'O'  ; Char Nave
		outchar r1, r0   ; Desenha a Nave
		
		pop r1
		pop r0
		rts


;********************************************************
;                       DELAY
;********************************************************		


Delay:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	Push R0
	Push R1
	
	Loadn R1, #15   ; a
   Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	Loadn R0, #3000	; b
   Delay_volta1: 
	Dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	JNZ Delay_volta1	
	Dec R1
	JNZ Delay_volta2
	
	Pop R1
	Pop R0
	
	RTS							;return

;-------------------------------