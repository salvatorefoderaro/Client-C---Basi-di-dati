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
		exit(1);
	}
}

void test_stmt_error(MYSQL_STMT * stmt, int status){
	if (status) {
		fprintf(stderr, "Error: %s (errno: %d)\n",
			mysql_stmt_error(stmt), mysql_stmt_errno(stmt));
		exit(1);
	}
}

int main(int argc, char **argv){
	MYSQL *con = mysql_init(NULL);

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

	getAssegnazioniPassate(con);

	return 1;
}

void printResults(MYSQL_STMT *statement, MYSQL *connessione){
	MYSQL *con = connessione;
	MYSQL_RES *result;
	MYSQL_ROW row;
	MYSQL_FIELD *field;
	MYSQL_RES *rs_metadata;
	MYSQL_STMT *stmt = statement;
	my_bool is_null[3];		// output value nullability
	MYSQL_FIELD *fields;
	int i, num_fields, status;
	MYSQL_BIND *rs_bind; // for output buffers

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

				if (status == 1 || status == MYSQL_NO_DATA)
					break;

				for (i = 0; i < num_fields; ++i) {
					switch (rs_bind[i].buffer_type) {
						case MYSQL_TYPE_VAR_STRING: // Not used in this stored procedure
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								printf(" val[%d] = %s;", i, rs_bind[i].buffer);
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
			printf("End of procedure output\n");
		}

		status = mysql_stmt_next_result(stmt);
		if (status > 0)
			test_stmt_error(stmt, status);
	} while (status == 0);

	mysql_stmt_close(stmt);
	//printf("The returned token is: %s\n", token);
	mysql_close(con);
	return;
}

/*void getAssegnazioniPassate(MYSQL *connessione){	
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

	printResults(stmt, con);
}*/
