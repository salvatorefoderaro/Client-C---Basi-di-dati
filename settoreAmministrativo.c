#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include "program.h"

int menuSettoreAmministrativo(MYSQL* connessione){
	MYSQL *con = connessione;
	int scelta;
	char scelta_utente[10];
	while(1){
		printf("\n     ***** Tipo dipendente: Settore amministrativo *****\n");	
		printf("\n1 - Visualizza assegnazioni passate dipendente\n2 - Modifica mansione dipendente\n3 - Termina esecuzione\n\nScegli un opzione: ");	
		fgets(scelta_utente, 32, stdin);
		scelta = atoi(scelta_utente);
		switch (scelta) {
		
		case 1: // Login
			flush_terminal_no_input
			getAssegnazioniPassate(con);
			break;
		
		case 2: // Leggi tutti i messaggi presenti
			flush_terminal_no_input
			editMansione(con);
			break;
		
		case 3: // Inserimento nuovo messaggio
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

void getAssegnazioniPassate(MYSQL *connessione){

	printf("\n        ***** getAssegnazioniPassate *****\n\n");

	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[1];	// input parameter buffers
	unsigned long length[1];	// Can do like that because all IN parameters have the same length
	int status;

	char nome[64];
	printf("ID Dipendente: ");
	getInput(64, nome, false);
	length[0] = sizeof(int);
	int idDipendente = atoi(nome);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL getAssegnazioniPassate(?)", strlen("CALL getAssegnazioniPassate(?)"));
	test_stmt_error(stmt, status);

	memset(ps_params, 0, sizeof(ps_params));

	ps_params[0].buffer_type = MYSQL_TYPE_LONG;
	ps_params[0].buffer = &idDipendente;;
	ps_params[0].buffer_length = sizeof(int);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	if(status){flushTerminal return; }

	    printf("\n     --> ID Postazione; --> Data inizio; --> Data fine; --> ID Postazione     \n\n");

	printResults(stmt, con);
}

void editMansione(MYSQL *connessione){	
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[2];	// input parameter buffers
	unsigned long length[2];	// Can do like that because all IN parameters have the same length
	int status;

	char nome[64];
	printf("ID Dipendente: ");
	getInput(64, nome, false);
	length[0] = sizeof(int);
	int idDipendente = atoi(nome);

	char mansione[64];
	printf("\nID Mansione: ");
	getInput(64, mansione, false);
	length[1] = sizeof(int);
	int idMansione = atoi(mansione);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL editMansione(?, ?)", strlen("CALL editMansione(?, ?)"));
	test_stmt_error(stmt, status);

	memset(ps_params, 0, sizeof(ps_params));

	ps_params[0].buffer_type = MYSQL_TYPE_LONG;
	ps_params[0].buffer = &idDipendente;;
	ps_params[0].buffer_length = sizeof(int);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	ps_params[1].buffer_type = MYSQL_TYPE_LONG;
	ps_params[1].buffer = &idMansione;;
	ps_params[1].buffer_length = sizeof(int);
	ps_params[1].length = &length[1];
	ps_params[1].is_null = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	if(status){ flushTerminal
	return; }
}