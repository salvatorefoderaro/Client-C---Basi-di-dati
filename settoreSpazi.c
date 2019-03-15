#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include "program.h"

int menuSettoreSpazi(MYSQL *connessione){

	MYSQL *con = connessione;
	int scelta;
	char scelta_utente[10];
	while(1){

		printf("\n     ***** Tipo dipendente: Settore spazi *****\n");	
		printf("\n1 - Postazioni disponibili per l'utente\n2 - Assegna dipendente ad una postazioni libera\n3 - Termina esecuzione\n\nScegli un opzione: ");	

		fgets(scelta_utente, 32, stdin);
		scelta = atoi(scelta_utente);
		switch (scelta) {
		
		case 1: // Login
			flush_terminal_no_input
			checkPostazioniDisponibili(con);
			break;
		
		case 2: // Leggi tutti i messaggi presenti
			flush_terminal_no_input
			assignToPostazioneFree(con);
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

void checkPostazioniDisponibili(MYSQL *connessione){	
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

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL checkPostazioniDisponibili(?)", strlen("CALL checkPostazioniDisponibili(?)"));
	test_stmt_error(stmt, status);

	memset(ps_params, 0, sizeof(ps_params));

	ps_params[0].buffer_type = MYSQL_TYPE_LONG;
	ps_params[0].buffer = &idDipendente;
	ps_params[0].buffer_length = sizeof(int);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	int idRisultato = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

    if(status){ flushTerminal return; }

    printf("\n\n     --> ID Postazione     \n\n");

	printResults(stmt, con);
}

void assignToPostazioneFree(MYSQL *connessione){	
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
	printf("ID Mansione: ");
	getInput(64, mansione, false);
	length[1] = sizeof(int);
	int idMansione = atoi(mansione);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL assignToPostazioneFree(?,?)", strlen("CALL assignToPostazioneFree(?,?)"));
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

    if(status){ flushTerminal return; }
}