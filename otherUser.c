#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include "program.h"

int menuAltroDipendente(MYSQL* connessione){
	MYSQL *con = connessione;
	int scelta;
	char scelta_utente[10];
	while(1){

		printf("\n     ***** Tipo dipendente: Altro dipendente *****\n");	
		printf("\n1 - Cerca dipendente numero intero\n2 - Cerca dipendente nome e/o cognome\n3 - Termina esecuzione\n\nScegli un opzione: ");

		fgets(scelta_utente, 32, stdin);
		scelta = atoi(scelta_utente);
		switch (scelta) {
		
		case 1: 
			flush_terminal_no_input
			int result = getUserType(con);
			break;
		
		case 2: 
			flush_terminal_no_input
			break;
		
		case 3: 
			flush_terminal_no_input
			mysql_close(con);
			exit(1);
			break;

		default:
				flush_terminal_no_input
				printf("\nInserisci un numero corretto per continuare!\n");
				flushTerminal
				break;
			}
}
}