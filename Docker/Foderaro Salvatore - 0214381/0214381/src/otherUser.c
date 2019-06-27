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
			getUserNumeroInterno(connessione);
			break;
		
		case 2: 
			flush_terminal_no_input
			getNameSurname(connessione);
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

void getUserNumeroInterno(MYSQL *connessione){

	printf("\n        ***** getUserNumeroInterno *****\n\n");

	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[1];	// input parameter buffers
	unsigned long length[1];	// Can do like that because all IN parameters have the same length
	int status;

	char nome[64];
	printf("Numero interno: ");
	getInput(64, nome, false);
	length[0] = sizeof(int);
	int idDipendente = atoi(nome);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL getUserNumeroInterno(?)", strlen("CALL getUserNumeroInterno(?)"));
	test_stmt_error(stmt, status);

	memset(ps_params, 0, sizeof(ps_params));

	ps_params[0].buffer_type = MYSQL_TYPE_LONG;
	ps_params[0].buffer = &idDipendente;
	ps_params[0].buffer_length = sizeof(int);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	if(status){flushTerminal return; }
	char *toPrint[6] = {"ID Ufficio", "Piano", "Edificio", "Mansione", "ID DIpendente", "Is da trasferire?"};
	printResults(stmt, con, toPrint);
} 

void getNameSurname(MYSQL *connessione){

	printf("\n        ***** getUserNumeroInterno *****\n\n");

	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[2];	// input parameter buffers
	unsigned long length[2];	// Can do like that because all IN parameters have the same length
	int status;

	char nome[64];
	printf("Nome dipendente: ");
	getInput(64, nome, false);
	length[0] = strlen(nome);

	char cognome[64];
	printf("Cognome dipendente: ");
	getInput(64, cognome, false);
	length[1] = strlen(cognome);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL userNameSurname(?, ?)", strlen("CALL userNameSurname(?, ?)"));
	test_stmt_error(stmt, status);

	memset(ps_params, 0, sizeof(ps_params));

	ps_params[0].buffer_type = MYSQL_TYPE_VAR_STRING;
	ps_params[0].buffer = nome;
	ps_params[0].buffer_length = strlen(nome);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	ps_params[1].buffer_type = MYSQL_TYPE_VAR_STRING;
	ps_params[1].buffer = cognome;
	ps_params[1].buffer_length = strlen(cognome);
	ps_params[1].length = &length[1];
	ps_params[1].is_null = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	if(status){flushTerminal return; }
	char *toPrint[5] = {"E-Mail Ufficio","E-Mail Personale", "ID Ufficio", "Piano", "Edificio"};
	printResults(stmt, con, toPrint);
}