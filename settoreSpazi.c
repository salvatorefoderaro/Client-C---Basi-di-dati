#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include "program.h"

void getPostazioni(MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	int status;

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL getPostazioni", strlen("CALL getPostazioni"));
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

    if(status){ flushTerminal return; }
	char *toPrint[2] = {"ID Postazione", "ID Ufficio"};
	printResults(stmt, con, toPrint);
}

void getPostazioniAttive(MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	int status;

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL getPostazioniAttive", strlen("CALL getPostazioniAttive"));
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

    if(status){ flushTerminal return; }

	char *toPrint[3] = {"ID Postazione Attiva", "Disponibile?", "ID Ufficio"};
	printResults(stmt, con, toPrint);
}

void getUserDaTrasferire(MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	int status;

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL getUserDaTrasferire", strlen("CALL getUserDaTrasferire"));
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

    if(status){ flushTerminal return; }

	char *toPrint[1] = {"ID DIpendente"};
	printResults(stmt, con, toPrint);
}

void makeScambioUser(MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[2];	
	unsigned long length[2];	
	int status;

	char nome[64];
	printf("ID Dipendente 1: ");
	getInput(64, nome, false);
	length[0] = sizeof(int);
	int idDipendente = atoi(nome);

	char nome1[64];
	printf("ID Dipendente 2: ");
	getInput(64, nome1, false);
	length[1] = sizeof(int);
	int idDipendente1 = atoi(nome1);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL makeScambioUser(?, ?)", strlen("CALL makeScambioUser(?, ?)"));
	test_stmt_error(stmt, status);

	memset(ps_params, 0, sizeof(ps_params));

	ps_params[0].buffer_type = MYSQL_TYPE_LONG;
	ps_params[0].buffer = &idDipendente;
	ps_params[0].buffer_length = sizeof(int);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	ps_params[1].buffer_type = MYSQL_TYPE_LONG;
	ps_params[1].buffer = &idDipendente1;
	ps_params[1].buffer_length = sizeof(int);
	ps_params[1].length = &length[1];
	ps_params[1].is_null = 0;

	int idRisultato = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

    if(status){ flushTerminal return; }

    printf("\n\n     ---> Scambio utenti effettuato correttamente <---     \n\n");
	flushTerminal
}

void checkUserScambiabili(MYSQL *connessione){
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

	status = mysql_stmt_prepare(stmt, "CALL getUserScambiabili(?)", strlen("CALL getUserScambiabili(?)"));
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
	printf("     ID Dipendente     |     ID Postazione      ");
	//printResults(stmt, con);
}

void inserisciPostazione(MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[2];	// input parameter buffers
	unsigned long length[2];	// Can do like that because all IN parameters have the same length
	int status;

	char nome[64];
	printf("ID Ufficio: ");
	getInput(64, nome, false);
	length[0] = sizeof(int);
	int idDipendente = atoi(nome);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL insertNewPostazione(?)", strlen("CALL insertNewPostazione(?)"));
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

    printf("\n\n     ---> Postazione inserita correttamente <---     \n\n");
	flushTerminal
	return;
}

void eliminaPostazione(MYSQL* connessione){
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[2];	// input parameter buffers
	unsigned long length[2];	// Can do like that because all IN parameters have the same length
	int status;

	char nome[64];
	printf("ID Postazione: ");
	getInput(64, nome, false);
	length[0] = sizeof(int);
	int idDipendente = atoi(nome);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL deletePostazione(?)", strlen("CALL deletePostazione(?)"));
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

    printf("\n\n     ---> Postazione eliminata correttamente <---     \n\n");
	flushTerminal
	return;
}

void disabilitaPostazione(MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[2];	// input parameter buffers
	unsigned long length[2];	// Can do like that because all IN parameters have the same length
	int status;

	char nome[64];
	printf("ID Postazione: ");
	getInput(64, nome, false);
	length[0] = sizeof(int);
	int idDipendente = atoi(nome);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL disablePostazione(?)", strlen("CALL disablePostazione(?)"));
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

    printf("\n\n     ---> Postazione disabilitata correttamente <---     \n\n");
	flushTerminal
	return;
}

void abilitaPostazione(MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[2];	
	unsigned long length[2];
	int status;

	char nome[64];
	printf("ID Postazione: ");
	getInput(64, nome, false);
	length[0] = sizeof(int);
	int idDipendente = atoi(nome);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL enablePostazione(?)", strlen("CALL enablePostazione(?)"));
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

    printf("\n\n     ---> Postazione abilitata correttamente <---     \n\n");
	flushTerminal
	return;
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

	char *toPrint[1] = {"ID Postazione Attiva"};
	printResults(stmt, con, toPrint);
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
	printf("ID Postazione: ");
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

	printf("\nUtente assegnato correttamente!\n");
	flushTerminal
}

void assegnaPostazioneToUfficio(MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[2];	// input parameter buffers
	unsigned long length[2];	// Can do like that because all IN parameters have the same length
	int status;

	char nome[64];
	printf("ID Postazione: ");
	getInput(64, nome, false);
	length[0] = sizeof(int);
	int idDipendente = atoi(nome);

    char mansione[64];
	printf("ID Ufficio: ");
	getInput(64, mansione, false);
	length[1] = sizeof(int);
	int idMansione = atoi(mansione);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL assignPostazioneToUfficio(?,?)", strlen("CALL assignPostazioneToUfficio(?,?)"));
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
	printf("\nPostazione assegnata correttamente!\n");
	flushTerminal
}

int menuSettoreSpazi(MYSQL *connessione){

	MYSQL *con = connessione;
	int scelta;
	char scelta_utente[10];
	while(1){

		printf("\n     ***** Tipo dipendente: Settore spazi *****\n");	
		printf("\n1 - Postazioni disponibili per l'utente\n2 - Assegna dipendente ad una postazioni libera\n3 - checkUserScambiabili\n4 - makeScambioUser\n5 - getPostazioni\n6 - getPostazioniAttive\n7 - getUserDaTrasferire\n8 - disabilitaPostazione\n9 - abilitaPostazione\n10 - inserisciPostazione\n11 - eliminaPostazione\n12 - Assegna postazione ad ufficio\n13 - Termina esecuzione\n\nScegli un opzione: ");	

		fgets(scelta_utente, 32, stdin);
		scelta = atoi(scelta_utente);
		switch (scelta) {
		
		case 1: 
			flush_terminal_no_input
			checkPostazioniDisponibili(con);
			break;
		
		case 2: 
			flush_terminal_no_input
			assignToPostazioneFree(con);
			break;
		
		case 3:
			flush_terminal_no_input
			checkUserScambiabili(con);
			break;
		
		case 4:
			flush_terminal_no_input
			makeScambioUser(con);
			break;
		
		case 5:
			flush_terminal_no_input
			getPostazioni(con);
			break;

		case 6:
			flush_terminal_no_input
			getPostazioniAttive(con);
			break;
		
		case 7:
			flush_terminal_no_input
			getUserDaTrasferire(con);
			break;

		case 8:
			flush_terminal_no_input
			disabilitaPostazione(con);
			break;

		case 9:
			flush_terminal_no_input
			abilitaPostazione(con);
			break;

		case 10:
			flush_terminal_no_input
			inserisciPostazione(con);
			break;

		case 11:
			flush_terminal_no_input
			eliminaPostazione(con);
			break;

		case 12:
			flush_terminal_no_input
			assegnaPostazioneToUfficio(con);
			break;

		case 13: 
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