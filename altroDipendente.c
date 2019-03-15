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
		printf("\n     3 - Termina esecuzione\n\nScegli un opzione: ");

		fgets(scelta_utente, 32, stdin);
		scelta = atoi(scelta_utente);
		switch (scelta) {
		
		case 1: // Login
			flush_terminal_no_input
			int result = getUserType(con);
			break;
		
		case 2: // Leggi tutti i messaggi presenti
			flush_terminal_no_input
			getAssegnazioniPassate(con);
			break;
		
		case 3: // Inserimento nuovo messaggio
			flush_terminal_no_input
			mysql_close(con);
			exit(1);
			break;
		
		case 4: // Termina esecuzione programma
			flush_terminal_no_input
			return 0;

		default:
				flush_terminal_no_input
				printf("\nInserisci un numero corretto per continuare!\n");
				flushTerminal
				break;
			}
}
}