			ORG 0; Inicializacion del programa
			LJMP PRINCIPAL; Brinca a la etiqueta PRINCIPAL 
			ORG 002BH; Vector del temporizador 2
			LJMP TIMER; Etiqueta de la interrupcion por el temporizador 2
			ORG 0030H; Inicializacion del programa dado que del 00H - 2FH se reserva para los temporizadores.
			
PRINCIPAL: 	MOV P1, #0;
            SETB P1.0; Se declara en 0 P0.0
			SETB P1.1; Se declara en 0 P0.1	
			
			MOV R7, #20; Se le asigna 20 a R7, un numero importante para el conteo de segundos dado que 20 * 5000us = 1 segundo
			MOV IE, #0A0H;
			MOV 089H, #11H; El temporizador va a contar hasta 50000, asi que ponerle 11H asigna el temporizador a 16bits, el cual puede contar hasta 65,000 aprox
			MOV 0CDH, #03CH; Queremos que el temporizador cuente 50000, no 65000 para desbordarse, asi que al hacer la resta de 65K - 50K nos da el punto de inicio del temp en sus bits mas significativos
			MOV 0CCH, #0B0H; Lo mismo que TH2 pero para los bits menos significativos
            CLR P1.0; Se declara en 0 P0.0
			CLR P1.1; Se declara en 0 P0.1	
            SETB 0CAH; arranca el temporizador 2
			
CHINGA:		CPL P1.0; Se complementa P0.0, creando un ciclo dentro.
			SJMP CHINGA
			
TIMER:		CLR 0CAH
			DJNZ R7, IGNORA
			; aqui va lo que hace el timer cada segundo
			CPL P1.1
			MOV R7, #20; cuenta hasta 20 porque 5000us = 1 seg.
			
IGNORA:		MOV 0CDH, #03CH
			MOV 0CCH, #0B0H
			CLR 0CFH;
			SETB 0CAH;
			
			; cuando se desborde el 20, reseteas timer 2, si noes automatico, reseteas el contador de 20
			
TERMINA:	RETI
			
			END