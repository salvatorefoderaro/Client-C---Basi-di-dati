#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include "program.h"

struct configuration conf;
char nome[64];

void test_error(MYSQL * con, int status){
	if (status) {
		fprintf(stderr, "Error: %s (errno: %d)\n", mysql_error(con),
			mysql_errno(con));
	}
}

void test_stmt_error(MYSQL_STMT * stmt, int status){
	if (status) {
		fprintf(stderr, "\nErrore: %s\n", mysql_stmt_error(stmt));
	}
}

int main(int argc, char **argv){
	flush_terminal_no_input
	MYSQL *con = mysql_init(NULL);
    load_file(&config, "tempUser.json");
	parse_config();

	if(con == NULL) {
		fprintf(stderr, "Initilization error: %s\n", mysql_error(con));
		exit(1);
	}

	if (mysql_real_connect(con, conf.host, conf.username, conf.password, conf.database, conf.port, NULL, CLIENT_MULTI_STATEMENTS) == NULL) {
		fprintf(stderr, "Connection error: %s\n", mysql_error(con));
		exit(1);
	}

	int scelta;
	char scelta_utente[10];

	while(1){
		printf("\n1 - Effettua l'accesso al sistema\n2 - Termina programma\n\nScegli un opzione: ");	
		fgets(scelta_utente, 32, stdin);
		printf("\n\n");
		scelta = atoi(scelta_utente);
		switch (scelta) {
		
		case 1:
			flush_terminal_no_input
			int result = getUserType(con);

			if (result == 1){
				load_file(&config, "settoreAmministrativo.json");
				parse_config();
				if (mysql_change_user(con,conf.username, conf.password, conf.database) != 0){
					printf("Failed to change user.  Error: %s\n", mysql_error(con));
					flushTerminal
					exit(-1);
				}
				menuSettoreAmministrativo(con);
			
			} else if (result == 2){
				load_file(&config, "settoreSpazi.json");
				parse_config();
				if (!mysql_change_user(con,conf.username, conf.password, conf.database)){
					fprintf(stderr, "Failed to change user.  Error: %s\n", mysql_error(con));
				}
				menuSettoreSpazi(con);

			}  else if (result == 3){
				load_file(&config, "otherUser.json");
				parse_config();
				if (!mysql_change_user(con,conf.username, conf.password, conf.database)){
					fprintf(stderr, "Failed to change user.  Error: %s\n", mysql_error(con));
				}
				menuAltroDipendente(con);

			} else {
				break;
			}
		
		case 2: 
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
		return 1;
}

void printResults(MYSQL_STMT *statement, MYSQL *connessione, char **resultName){
	MYSQL *con = connessione;
	MYSQL_RES *result;
	MYSQL_ROW row;
	MYSQL_FIELD *field;
	MYSQL_RES *rs_metadata;
	MYSQL_STMT *stmt = statement;
	bool is_null[4];		
	MYSQL_FIELD *fields;
	int i, num_fields, status;
	MYSQL_BIND *rs_bind;
	MYSQL_TIME *date;
	int resultSet = 0;
	int lastResultSet = 0;
	i = 0;

	do {
		resultSet = i;
		printf("\n");
		num_fields = mysql_stmt_field_count(stmt);

		if (num_fields > 0) {

			rs_metadata = mysql_stmt_result_metadata(stmt);
			test_stmt_error(stmt, rs_metadata == NULL);

			fields = mysql_fetch_fields(rs_metadata);
			rs_bind = (MYSQL_BIND *)malloc(sizeof(MYSQL_BIND) * num_fields);
			if (!rs_bind) {
				printf("Cannot allocate output buffers\n");
				exit(1);
			}
			memset(rs_bind, 0, sizeof(MYSQL_BIND) * num_fields);
			
			for (i = 0; i < num_fields; ++i) {
				rs_bind[i].buffer_type = fields[i].type;
				rs_bind[i].is_null = &is_null[i];
				rs_bind[i].buffer = malloc(fields[i].length);
				rs_bind[i].buffer_length = fields[i].length;
			}

			status = mysql_stmt_bind_result(stmt, rs_bind);
			test_stmt_error(stmt, status);
			int counter = 0;
			while (1) {
				status = mysql_stmt_fetch(stmt);
				if (status == 1 || status == MYSQL_NO_DATA){
					break;
				}
				resultSet = lastResultSet;

				for (i = 0; i < num_fields; ++i) {

					switch (rs_bind[i].buffer_type) {
						case MYSQL_TYPE_VAR_STRING: 
							if (*rs_bind[i].is_null)
								printf("%s = NULL; ", resultName[resultSet]);
							else
								printf("%s = %s; ", resultName[resultSet], (char*)rs_bind[i].buffer);
							break;

						case MYSQL_TYPE_TINY:
							if (*rs_bind[i].is_null)
								printf("%s = NULL; ", resultName[resultSet]);
							else
								printf("%s = %d; ", resultName[resultSet], *(bool*)rs_bind[i].buffer);
							break;

						case MYSQL_TYPE_LONG:
							if (*rs_bind[i].is_null)
								printf("%s = NULL; ", resultName[resultSet]);
							else
								printf("%s = %d; ", resultName[resultSet], *(int*)rs_bind[i].buffer);
							break;

						case MYSQL_TYPE_DATE:
							if (*rs_bind[i].is_null)
								printf("%s = NULL; ", resultName[resultSet]);
							else
								date = rs_bind[i].buffer;
								printf("%s = %d/%d/%d; ", resultName[resultSet], date->day, date->month, date->year);
							break;

						default:
							printf("ERROR: unexpected type (%d)\n", rs_bind[resultSet].buffer_type);
					}
					resultSet +=1;
				}
				counter = counter + 1;
				printf("\n");
			}
			if (counter == 0){
				printf("\nNessun risultato disponibile!\n");
			}
			mysql_free_result(rs_metadata);	// free metadata
			free(rs_bind);	// free output buffers
		} else {

		}

		status = mysql_stmt_next_result(stmt);
		lastResultSet = i;
		if (status > 0)
			test_stmt_error(stmt, status);
	} while (status == 0);

	for (i = 0; i < num_fields; ++i) {
		free(rs_bind[i].buffer);
	}

	mysql_stmt_close(stmt);
	flushTerminal
	return;
}

int getUserType(MYSQL *connessione){

	/* Questa funzione permette di effettuare il Login, e restituisce il tipo di utente
	se il login va a buon fine. */

	printf("\n        ***** Login dipendente *****\n\n");

	MYSQL *con = connessione;
	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[3];	
	unsigned long length[3];	
	MYSQL_BIND *rs_bind;
	int status, userType;
	bool is_null[2];		
	MYSQL_FIELD *fields;
	MYSQL_RES *rs_metadata;

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL loginUser(?, ?, ?)", strlen("CALL loginUser(?, ?, ?)"));
	test_stmt_error(stmt, status);

	memset(ps_params, 0, sizeof(ps_params));
	
	char idDipendenteChar[20];
	printf("Matricola dipendente: ");
	getInput(20, idDipendenteChar, false);
	int idDipendente = atoi(idDipendenteChar);
	length[0] = sizeof(int);

	printf("Password dipendente: ");
	char passwordDipendente[20];
	getInput(20, passwordDipendente, true);
	length[1] = strlen(passwordDipendente);

	ps_params[0].buffer_type = MYSQL_TYPE_LONG;
	ps_params[0].buffer = &idDipendente;
	ps_params[0].buffer_length = sizeof(int);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	ps_params[1].buffer_type = MYSQL_TYPE_VAR_STRING;
	ps_params[1].buffer = passwordDipendente;
	ps_params[1].buffer_length = strlen(passwordDipendente);
	ps_params[1].length = &length[1];
	ps_params[1].is_null = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	if(status){ flushTerminal return 0; }

	if(mysql_stmt_field_count(stmt) == 0) {
		fprintf(stderr, "Error while retrieving the stored procedure output\n");
		exit(1);
	}
			
	rs_metadata = mysql_stmt_result_metadata(stmt);
	
	fields = mysql_fetch_fields(rs_metadata);

	rs_bind = (MYSQL_BIND *) malloc(sizeof(MYSQL_BIND) * 1); // We know the number of parameters beforehand
	memset(rs_bind, 0, sizeof(MYSQL_BIND) * 1);

	int *idDipendente2 = malloc(sizeof(int));

	rs_bind[0].buffer_type = MYSQL_TYPE_LONG;
	rs_bind[0].is_null = &is_null[0];
	rs_bind[0].buffer = idDipendente2;
	rs_bind[0].buffer_length = sizeof(int);

	status = mysql_stmt_bind_result(stmt, rs_bind);
	test_stmt_error(stmt, status);

	status = mysql_stmt_fetch(stmt);
	if (status == 1 || status == MYSQL_NO_DATA) {
		printf("Unable to retrieve the information\n");
	}

	mysql_free_result(rs_metadata);	// free metadata
	free(rs_bind);	// free output buffers
	mysql_stmt_close(stmt);
	flushTerminal
	return *idDipendente2;
}