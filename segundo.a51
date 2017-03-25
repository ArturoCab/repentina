			ORG 0; Inicializacion del programa
			LJMP PRINCIPAL; Brinca a la etiqueta PRINCIPAL 
			ORG 002BH; Vector del temporizador 2
			LJMP TIMER; Etiqueta de la interrupcion por el temporizador 2
			ORG 0030H; Inicializacion del programa dado que del 00H - 2FH se reserva para los temporizadores.
			
PRINCIPAL: 	CLR P1.0; Se declara en 0 P0.0
			CLR P1.1; Se declara en 0 P0.1			
			MOV IE, #0A0H;
			MOV 089H, #11H; El temporizador va a contar hasta 50000, asi que ponerle 11H asigna el temporizador a 16bits, el cual puede contar hasta 65,000 aprox
			MOV 0CDH, #0C4H; Queremos que el temporizador cuente 50000, no 65000 para desbordarse, asi que al hacer la resta de 65K - 50K nos da el punto de inicio del temp en sus bits mas significativos
			MOV 0CCH, #050H; Lo mismo que TH2 pero para los bits menos significativos
			SETB 0CAH; arranca el temporizador 2
			SJMP $
			
TIMER:		MOV P1, #00H
			
TERMINA:	RETI
			
			END