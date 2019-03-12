#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include "program.h"


struct configuration conf;
char nome[64];

void printResults(MYSQL_STMT *statement, MYSQL *connessione);

void test_error(MYSQL * con, int status){
	if (status) {
		fprintf(stderr, "Error: %s (errno: %d)\n", mysql_error(con),
			mysql_errno(con));
	}
}

void test_stmt_error(MYSQL_STMT * stmt, int status){
	if (status) {
		fprintf(stderr, "Error: %s (errno: %d)\n",
			mysql_stmt_error(stmt), mysql_stmt_errno(stmt));
	}
}

int main(int argc, char **argv){
	for (int k = 0; k<10; k++){MYSQL *con = mysql_init(NULL);

    load_file(&config, "config.json");
	parse_config();

	if(con == NULL) {
		fprintf(stderr, "Initilization error: %s\n", mysql_error(con));
		exit(1);
	}

	if(mysql_real_connect(con, conf.host, conf.username, conf.password, conf.database, conf.port, NULL, 0) == NULL) {
		fprintf(stderr, "Connection error: %s\n", mysql_error(con));
		exit(1);
	}
		int scelta;
		char scelta_utente[10];
		while(1){
		printf("\n1 - Effettua l'accesso al sistema\n2 - Leggi tutti i messaggi presenti\n3 - Inserisci un nuovo messaggio\n4 - Elimina un messaggio\n5 - Effettua la registrazione\n6 - Effettua disconnessione\n7 - Termina esecuzione programma\n\nQuale operazione vuoi eseguire?\n");	
		fgets(scelta_utente, 32, stdin);
	scelta = atoi(scelta_utente);
	switch (scelta) {
	
	case 1: // Login
	flush_terminal_no_input
	checkPostazioniDisponibili(con);
		break;
	
	case 2: // Leggi tutti i messaggi presenti
		flush_terminal_no_input
		break;
	
	case 3: // Inserimento nuovo messaggio
		flush_terminal_no_input
		break;
	
	case 4: // Elimina messaggio
		flush_terminal_no_input
		break;
	
	case 5: // Registrazione
		flush_terminal_no_input
		break;
	
	case 6: // Disconnessione
		flush_terminal_no_input
		break;
	
	case 7: // Termina esecuzione programma
		flush_terminal_no_input
		return 0;
        default:
				flush_terminal_no_input
                printf("\nInserisci un numero corretto per continuare!\n");
				flushTerminal
                break;
		}
}

	getAssegnazioniPassate(con);
	}
	return 1;
}

void printResults(MYSQL_STMT *statement, MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_RES *result;
	MYSQL_ROW row;
	MYSQL_FIELD *field;
	MYSQL_RES *rs_metadata;
	MYSQL_STMT *stmt = statement;
	my_bool is_null[4];		
	MYSQL_FIELD *fields;
	int i, num_fields, status;
	MYSQL_BIND *rs_bind; // for output buffers
	MYSQL_TIME *date;

	do {
		num_fields = mysql_stmt_field_count(stmt);

		if (num_fields > 0) {

			if (con->server_status & SERVER_PS_OUT_PARAMS)
				printf("The stored procedure has returned output in OUT/INOUT parameter(s)\n");

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
			
			while (1) {
				status = mysql_stmt_fetch(stmt);
				if (status == 1 || status == MYSQL_NO_DATA){
					break;
				}

				for (i = 0; i < num_fields; ++i) {
					switch (rs_bind[i].buffer_type) {
						case MYSQL_TYPE_VAR_STRING: // Not used in this stored procedure
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								printf(" val[%d] = %s;", i, (char*)rs_bind[i].buffer);
							break;

						case MYSQL_TYPE_LONG: // Not used in this stored procedure
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								printf(" val[%d] = %d;", i, *(int*)rs_bind[i].buffer);
							break;

						case MYSQL_TYPE_DATE: // Not used in this stored procedure
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								date = rs_bind[i].buffer;
								printf(" val[%d] = %d-%d-%d;", i, date->day, date->month, date->year);
							break;

						default:
							printf("ERROR: unexpected type (%d)\n", rs_bind[i].buffer_type);
					}
				}
				printf("\n");
			}

			mysql_free_result(rs_metadata);	// free metadata
			free(rs_bind);	// free output buffers
		} else {

		}

		status = mysql_stmt_next_result(stmt);
		if (status > 0)
			test_stmt_error(stmt, status);
	} while (status == 0);

	for (i = 0; i < num_fields; ++i) {
		free(rs_bind[i].buffer);
	}

	mysql_stmt_close(stmt);
		//printf("The returned token is: %s\n", token);
	mysql_close(con);
	flushTerminal
	return;
}