#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include "list.h"
#include "program.h"

struct configuration conf;

char nome[64];
char cognome[64];
char matricola[64];
char email[64];
char email_confirm[64];
char token[129];
char titolo[64];
char *specifica;
long testLong;
long result;

int id_esame = 4;

static void test_error(MYSQL * con, int status)
{
	if (status) {
		fprintf(stderr, "Error: %s (errno: %d)\n", mysql_error(con),
			mysql_errno(con));
		exit(1);
	}
}

static void test_stmt_error(MYSQL_STMT * stmt, int status)
{
	if (status) {
		fprintf(stderr, "Error: %s (errno: %d)\n",
			mysql_stmt_error(stmt), mysql_stmt_errno(stmt));
		exit(1);
	}
}

int main(int argc, char **argv)
{
	MYSQL *con = mysql_init(NULL);
	MYSQL_RES *result;
	MYSQL_ROW row;
	MYSQL_FIELD *field;
	MYSQL_RES *rs_metadata;

	MYSQL_STMT *stmt;
	MYSQL_BIND ps_params[2];	// input parameter buffers
	unsigned long length[2];	// Can do like that because all IN parameters have the same length
	my_bool is_null[3];		// output value nullability
	int status;

	struct listaResult *lista = malloc(sizeof(listaResult));
	lista->memory = malloc(sizeof(char)*256);
	lista->next = NULL;


	int i;
	int num_fields;	// number of columns in result
	MYSQL_FIELD *fields; // for result set metadata		
	MYSQL_BIND *rs_bind; // for output buffers

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

	printf("**** Sistema di prenotazione progetti ****\n\n");

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}
	status = mysql_stmt_prepare(stmt, "call simpleProcedureCount(?, ?)", strlen("call simpleProcedureCount(?, ?)"));
	test_stmt_error(stmt, status);

	memset(ps_params, 0, sizeof(ps_params));

	char test1[150] = "HMK";

    length[0] = strlen(test1);

    ps_params[0].buffer_type = MYSQL_TYPE_VAR_STRING;
    ps_params[0].buffer = test1;
    ps_params[0].buffer_length = strlen(test1);
    ps_params[0].length = &length[0];
    ps_params[0].is_null = 0;

	length[1] = sizeof(long);

	ps_params[1].buffer_type = MYSQL_TYPE_VAR_STRING;
	ps_params[1].buffer = &testLong;
	ps_params[1].buffer_length = sizeof(long);
	ps_params[1].length = &length[0];
	ps_params[1].is_null = 0;

	// bind parameters
	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	// Run the stored procedure
	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	// This is a general piece of code, to show how to deal with
	// generic stored procedures. A lighter version tailored to
	// a single specific stored procedure is shown below, for
	// the second stored procedure used in the application
	// process results until there are no more
	do {
		/* the column count is > 0 if there is a result set */
		/* 0 if the result is only the final status packet */
		num_fields = mysql_stmt_field_count(stmt);

		if (num_fields > 0) {

			// what kind of result set is this?
			if (con->server_status & SERVER_PS_OUT_PARAMS)
				printf("The stored procedure has returned output in OUT/INOUT parameter(s)\n");

			// Get information about the outcome of the stored procedure
			rs_metadata = mysql_stmt_result_metadata(stmt);
			test_stmt_error(stmt, rs_metadata == NULL);

			// Retrieve the fields associated with OUT/INOUT parameters
			fields = mysql_fetch_fields(rs_metadata);
			rs_bind = (MYSQL_BIND *)malloc(sizeof(MYSQL_BIND) * num_fields);
			if (!rs_bind) {
				printf("Cannot allocate output buffers\n");
				exit(1);
			}
			memset(rs_bind, 0, sizeof(MYSQL_BIND) * num_fields);

			// set up and bind result set output buffers
			for (i = 0; i < num_fields; ++i) {
				while (lista->next != NULL){
					lista = lista->next;
				}

				struct listaResult *node = getNode();
					lista->next = node;

				rs_bind[i].buffer_type = fields[i].type;
				rs_bind[i].is_null = &is_null[i];
				

				switch (fields[i].type) {
					case MYSQL_TYPE_VAR_STRING:
							rs_bind[i].buffer = node->memory;
							rs_bind[i].buffer_length = 256;
							break;

						case MYSQL_TYPE_LONG:
							rs_bind[i].buffer = node->memory;
							rs_bind[i].buffer_length = 256;
							break;

					default:
						fprintf(stderr,	"ERROR: unexpected type: %d.\n", fields[i].type);
						exit(1);
				}
			}

			status = mysql_stmt_bind_result(stmt, rs_bind);
			test_stmt_error(stmt, status);

			// fetch and display result set rows
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
								printf(" val[%d] = %s;", i, (char*)rs_bind[i].buffer);
															printf("Faccio la free?");

							free(rs_bind[i].buffer);
							break;
						case MYSQL_TYPE_LONG: // Not used in this stored procedure
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								printf(" val[%d] = %d;", i, *(long*)rs_bind[i].buffer);
															printf("Faccio la free?");

							free(rs_bind[i].buffer);
							break;

						default:
							printf("ERROR: unexpected type (%d)\n", rs_bind[i].buffer_type);
							printf("Faccio la free?");
							free(rs_bind[i].buffer);
					}
				}
				printf("\n");
			}

			mysql_free_result(rs_metadata);	// free metadata
			free(rs_bind);	// free output buffers
		} else {
			// no columns = final status packet
			printf("End of procedure output\n");
		}

		// more results? -1 = no, >0 = error, 0 = yes (keep looking)
		status = mysql_stmt_next_result(stmt);
		if (status > 0)
			test_stmt_error(stmt, status);
	} while (status == 0);

	mysql_stmt_close(stmt);
	// printf("Numero di count è: %d", freeList(lista));

	printf("The returned token is: %s\n", token);

	if(!yesOrNo("Would you like to confirm the assignment?", 'y', 'n', true, false))
		goto out;



    out:
	mysql_close(con);
	return 0;
}