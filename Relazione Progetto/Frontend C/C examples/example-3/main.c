#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>

#include "program.h"

struct configuration conf;

char nome[64];
char cognome[64];
char matricola[64];
char email[64];
char email_confirm[64];
char token[129];
long test;
char titolo[64];
char *specifica;

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
	MYSQL_BIND ps_params[6];	// input parameter buffers
	unsigned long length[6];	// Can do like that because all IN parameters have the same length
	my_bool is_null[3];		// output value nullability
	int status;

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

	printf("Nome: ");
	getInput(64, nome, false);
	length[1] = strlen(nome);
	printf("Cognome: ");
	getInput(64, cognome, false);
	length[2] = strlen(cognome);
	printf("Matricola: ");
	getInput(64, matricola, false);
	length[0] = strlen(matricola);
	printf("email: ");
	getInput(64, email, false);
	length[3] = strlen(email);

	stmt = mysql_stmt_init(con);
	if (!stmt) {
		printf("Could not initialize statement\n");
		exit(1);
	}
	status = mysql_stmt_prepare(stmt, "CALL test(?)", strlen("CALL test(?)"));
	test_stmt_error(stmt, status);

	// initialize parameters
	memset(ps_params, 0, sizeof(ps_params));
	// `assegnazione`(in var_matricola varchar(45), in var_nome varchar(45), in var_cognome varchar(45), in var_email varchar(45), in var_id_esame int, out var_token varchar(128))

	char test1[256] = "HMK";
	ps_params[0].buffer_type = MYSQL_TYPE_VAR_STRING;
	ps_params[0].buffer = test1;
	ps_params[0].buffer_length = 256;
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	ps_params[1].buffer_type = MYSQL_TYPE_VAR_STRING;
	ps_params[1].buffer = nome;
	ps_params[1].length = &length[1];
	ps_params[1].is_null = 0;

	ps_params[2].buffer_type = MYSQL_TYPE_VAR_STRING;
	ps_params[2].buffer = cognome;
	ps_params[2].length = &length[2];
	ps_params[2].is_null = 0;

	ps_params[3].buffer_type = MYSQL_TYPE_VAR_STRING;
	ps_params[3].buffer = email;
	ps_params[3].length = &length[3];
	ps_params[3].is_null = 0;

	ps_params[4].buffer_type = MYSQL_TYPE_LONG;
	ps_params[4].buffer = &id_esame;
	ps_params[4].length = 0;
	ps_params[4].is_null = 0;

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
				printf("Qqqq %d", fields[i].type);
				rs_bind[i].buffer_type = fields[i].type;
				rs_bind[i].is_null = &is_null[i];

				switch (fields[i].type) {
					case MYSQL_TYPE_VAR_STRING:
						rs_bind[i].buffer = token;
						rs_bind[i].buffer_length = sizeof(token);
						break;

					case MYSQL_TYPE_LONG:
						rs_bind[i].buffer = &test;
						rs_bind[i].buffer_length = sizeof(token);
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
				printf("entro nel while?");
				status = mysql_stmt_fetch(stmt);

				if (status == 1 || status == MYSQL_NO_DATA)
					printf("Break?");
					break;

				for (i = 0; i < num_fields; ++i) {
					printf("\nTipo è: %d\n", rs_bind[i].buffer_type);
					printf("\nDimensione è: %d\n", rs_bind[i].buffer_length);
					switch (rs_bind[i].buffer_type) {
						case MYSQL_TYPE_VAR_STRING: // Not used in this stored procedure
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								printf(" val[%d] = %s;", i, rs_bind[i].buffer);
							break;

						case MYSQL_TYPE_LONG: // Not used in this stored procedure
							if (*rs_bind[i].is_null)
								printf(" val[%d] = NULL;", i);
							else
								printf(" val[%d] = %ld;", i, *(long*)rs_bind[i].buffer);
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
			// no columns = final status packet
			printf("End of procedure output\n");
		}

		// more results? -1 = no, >0 = error, 0 = yes (keep looking)
		status = mysql_stmt_next_result(stmt);
		if (status > 0)
			test_stmt_error(stmt, status);
	} while (status == 0);

	mysql_stmt_close(stmt);

	printf("The returned token is: %s\n", token);

	if(!yesOrNo("Would you like to confirm the assignment?", 'y', 'n', true, false))
		goto out;

	// Here we confirm the assignment, with a much more compact code base.
	// `conferma`(in var_token varchar(128), out var_titolo varchar(128), out var_specifica longtext, out var_email varchar(128))
	stmt = mysql_stmt_init(con);
	status = mysql_stmt_prepare(stmt, "CALL conferma(?, ?, ?, ?)", 26);
	memset(ps_params, 0, sizeof(ps_params));

	length[0] = strlen(token);

	ps_params[0].buffer_type = MYSQL_TYPE_VAR_STRING;
	ps_params[0].buffer = token;
	ps_params[0].buffer_length = 64;
	ps_params[0].length = &length[0];
	ps_params[0].is_null = 0;

	// bind parameters
	status = mysql_stmt_bind_param(stmt, ps_params);
	test_stmt_error(stmt, status);

	// Run the stored procedure
	status = mysql_stmt_execute(stmt);
	test_stmt_error(stmt, status);

	// Retrieve the output
	if(mysql_stmt_field_count(stmt) == 0) {
		fprintf(stderr, "Error while retrieving the stored procedure output\n");
		exit(1);
	}
			
	rs_metadata = mysql_stmt_result_metadata(stmt);
	fields = mysql_fetch_fields(rs_metadata);
	rs_bind = (MYSQL_BIND *) malloc(sizeof(MYSQL_BIND) * 3); // We know the number of parameters beforehand
	memset(rs_bind, 0, sizeof(MYSQL_BIND) * 3);

	// We know the types of the parameters
	rs_bind[0].buffer_type = MYSQL_TYPE_VAR_STRING;
	rs_bind[0].is_null = &is_null[0];
	rs_bind[0].buffer = titolo;
	rs_bind[0].buffer_length = sizeof(titolo);

	specifica = malloc(4096);
	bzero(specifica, 4096);

	rs_bind[1].buffer_type = MYSQL_TYPE_BLOB;
	rs_bind[1].is_null = &is_null[1];
	rs_bind[1].buffer = specifica;
	rs_bind[1].buffer_length = 4096;

	rs_bind[2].buffer_type = MYSQL_TYPE_VAR_STRING;
	rs_bind[2].is_null = &is_null[2];
	rs_bind[2].buffer = email_confirm;
	rs_bind[2].buffer_length = sizeof(email_confirm);

	status = mysql_stmt_bind_result(stmt, rs_bind);
	test_stmt_error(stmt, status);

	status = mysql_stmt_fetch(stmt);
	if (status == 1 || status == MYSQL_NO_DATA) {
		printf("Unable to retrieve the information\n");
		goto out;
	}

	printf("Specification to be sent to %s\n\n%s\n%s\n", email_confirm, titolo, specifica);

	mysql_free_result(rs_metadata);	// free metadata
	free(rs_bind);	// free output buffers
	free(specifica);
	mysql_stmt_close(stmt);

    out:
	mysql_close(con);
	return 0;
}
