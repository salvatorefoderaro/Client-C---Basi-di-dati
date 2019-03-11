#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include "program.h"

struct configuration conf;

static void test_error(MYSQL * con, int status){
	if (status) {
		fprintf(stderr, "Errore: %s\n", mysql_error(con),
			mysql_errno(con));
		exit(1);
	}
}

static void test_stmt_error(MYSQL_STMT * stmt, int status){
	if (status) {
		fprintf(stderr, "Errore: %s\n",
			mysql_stmt_error(stmt), mysql_stmt_errno(stmt));
		exit(1);
	}
}

MYSQL *getConnection(){

	MYSQL *con = mysql_init(NULL);

	load_file(&config, "config.json");
	parse_config();

	if (con == NULL) {
		fprintf(stderr, "Initilization error: %s\n", mysql_error(con));
		exit(1);
	}

	if (mysql_real_connect(con, conf.host, conf.username, conf.password, conf.database, conf.port, NULL, 0) == NULL) {
		fprintf(stderr, "Connection error: %s\n", mysql_error(con));
		exit(1);
	}

	return con;
}

void getAssegnazioniPassate(){
	MYSQL *con = getConnection();
	MYSQL_STMT *stmt; // = mysql_init(NULL);

	MYSQL_BIND ps_params[1];	
	unsigned long length[1];	
	int status;
	int i;
	int num_fields;	

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL getAssegnazioniPassate(?)", strlen("CALL getAssegnazioniPassate(?)"));
	test_stmt_error(stmt, status);
	memset(ps_params, 0, sizeof(ps_params));
	
	char idDipendente[10];
	printf("ID Dipendente: ");
	getInput(10, idDipendente, false);
	int matricola = atoi(idDipendente);

	length[0] = sizeof(int);
	ps_params[0].buffer_type = MYSQL_TYPE_LONG;
	ps_params[0].buffer = &matricola;
	ps_params[0].buffer_length = sizeof(int);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	printStatementResult(con, stmt);
}

void checkPostazioniDisponibili(){
	MYSQL *con = getConnection();
	MYSQL_STMT *stmt; // = mysql_init(NULL);

	MYSQL_BIND ps_params[1];	
	unsigned long length[1];	
	int status;
	int i;
	int num_fields;	

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL checkPostazioniDisponibili(?)", strlen("CALL checkPostazioniDisponibili(?)"));
	test_stmt_error(stmt, status);
	memset(ps_params, 0, sizeof(ps_params));
	
	char idDipendente[10];
	printf("ID Dipendente: ");
	getInput(10, idDipendente, false);
	int matricola = atoi(idDipendente);

	length[0] = sizeof(int);
	ps_params[0].buffer_type = MYSQL_TYPE_LONG;
	ps_params[0].buffer = &matricola;
	ps_params[0].buffer_length = sizeof(int);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	printStatementResult(con, stmt);
}

void modificaMansioneDipendente(){
	MYSQL *con = getConnection();
	MYSQL_STMT *stmt; // = mysql_init(NULL);

	MYSQL_BIND ps_params[2];	
	unsigned long length[2];	
	int status;
	int i;
	int num_fields;	

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}

	status = mysql_stmt_prepare(stmt, "CALL editMansione(?, ?)", strlen("CALL editMansione(?, ?)"));
	test_stmt_error(stmt, status);
	memset(ps_params, 0, sizeof(ps_params));
	
	char idDipendente[10];
	printf("\nID Dipendente: ");
	getInput(10, idDipendente, false);
	int matricola = atoi(idDipendente);

	char idMansione[10];
	printf("\nID Mansione: ");
	getInput(10, idMansione, false);
	int mansione = atoi(idMansione);

	length[0] = sizeof(int);
	ps_params[0].buffer_type = MYSQL_TYPE_LONG;
	ps_params[0].buffer = &matricola;
	ps_params[0].buffer_length = sizeof(int);
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	length[1] = sizeof(int);
	ps_params[1].buffer_type = MYSQL_TYPE_LONG;
	ps_params[1].buffer = &mansione;
	ps_params[1].buffer_length = sizeof(int);
	ps_params[1].length = &length[1];
	ps_params[1].is_null = 0;

	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	printStatementResult(con, stmt);
}

int printStatementResult(MYSQL *connection, MYSQL_STMT *statement){

	MYSQL *con = connection;
	MYSQL_STMT *stmt = statement;
	MYSQL_RES *rs_metadata;
	MYSQL_FIELD *fields; 
	MYSQL_BIND *rs_bind;
	MYSQL_TIME *testTime;
	int num_fields;
	int status;
	my_bool is_null[3];		
	int i;

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
					printf("\nNessun risultato disponibile!\n");
					break;
				
				for (i = 0; i < num_fields; ++i) {
					switch (rs_bind[i].buffer_type) {

						case MYSQL_TYPE_VAR_STRING:
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								printf("  --> %s;", rs_bind[i].buffer);
							break;

						case MYSQL_TYPE_LONG:
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								printf("  --> %d;", *(int*)rs_bind[i].buffer);
							break;

						case MYSQL_TYPE_DATE:
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								testTime = (MYSQL_TIME*)rs_bind[i].buffer;
								printf("  --> %d/%d/%d;", testTime->day, testTime->month, testTime->year);
							break;

						default:
							printf("ERROR: unexpected type (%d)\n", rs_bind[i].buffer_type);
					}
				}
				printf("\n");
			}

			mysql_free_result(rs_metadata);
			free(rs_bind);
		} else {
			//printf("\nEnd of procedure output\n");
		}

		status = mysql_stmt_next_result(stmt);
		if (status > 0)
			test_stmt_error(stmt, status);
	} while (status == 0);

	mysql_stmt_close(stmt);
	mysql_close(con);
	return 0;
}