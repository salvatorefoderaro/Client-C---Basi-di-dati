#include <mysql.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "program.h"

static MYSQL *my_connection = NULL;

#define query(Q) do { \
			if (mysql_query(my_connection, Q)) { \
				finish_with_error(my_connection, Q); \
			} \
		 } while(0)

static void finish_with_error(MYSQL *my_connection, char *err)
{
	fprintf(stderr, "%s error: %s\n", err, mysql_error(my_connection));
	mysql_close(my_connection);
	exit(1);        
}

static char *concat_str(char *str, char *s2)
{
        int len;
        char *s;
        if (str != NULL)
                len = strlen(str);
        len += strlen(s2) + 1 * sizeof(*s2);
        s = realloc(str, len);
        strcat(s, s2);
        return s;
}

void conn(void) {
	my_connection = mysql_init(NULL);
	if (my_connection == NULL) {
		fprintf(stderr, "Initilization error: %s\n", mysql_error(my_connection));
		exit(1);
	}
	if (mysql_real_connect(my_connection, conf.host, conf.username, conf.password, conf.database, conf.port, NULL, 0) == NULL) {
		fprintf(stderr, "Connection error: %s\n", mysql_error(my_connection));
		exit(1);
	}
}

void disconn(void) {
	mysql_close(my_connection);
}

size_t get_list(struct assegnazione **list) {
	size_t cur_elem = 0;
	MYSQL_RES *query_result;
	MYSQL_ROW row;
    
	*list = malloc(sizeof(struct assegnazione) * INITIAL_ROWS);
	size_t cur_count = INITIAL_ROWS;

	bzero(*list, sizeof(struct assegnazione) * INITIAL_ROWS);
	
	query("SELECT"
		"`A`.`id` AS `id`,"
		"`A`.`matricola` AS `matricola`,"
		"`A`.`cognome` AS `cognome`,"
		"`A`.`nome` AS `nome`,"
		"`P`.`titolo` AS `titolo`"
		"FROM"
		"(`assegnazione` `A`"
			"LEFT JOIN `progetti` `P` ON ((`A`.`progetto` = `P`.`id`)))"
		"WHERE"
			"(`A`.`confermato_il` IS NOT NULL)");
			
	query_result = mysql_store_result (my_connection);

	// construct the buffer containing each row as a struct
	while ((row = mysql_fetch_row(query_result))) {
		if(cur_elem + 1 == cur_count) {
			cur_count *= 2;
			*list = realloc(*list, sizeof(struct assegnazione) * cur_count);
		}

		(*list)[cur_elem].id = atoi(row[0]);
		strncpy((*list)[cur_elem].matricola, row[1], sizeof((*list)[cur_elem].matricola));
		strncpy((*list)[cur_elem].cognome, row[2], sizeof((*list)[cur_elem].matricola));
		strncpy((*list)[cur_elem].nome, row[3], sizeof((*list)[cur_elem].matricola));
		strncpy((*list)[cur_elem].titolo, row[4], sizeof((*list)[cur_elem].matricola));

		cur_elem++;
	}
	
	return cur_elem;
}

char *get_entry(int id) {
	MYSQL_RES *query_result;
	MYSQL_ROW row;
	char *text = NULL;

	char q[1024];
	snprintf(q, 1024, "SELECT cognome, nome, matricola, email, richiesto_il, confermato_il, token FROM assegnazione WHERE id = '%d'", id);
	query(q);
			
	query_result = mysql_store_result (my_connection);
	row = mysql_fetch_row(query_result);

	text = concat_str(text, "Studente: ");
	text = concat_str(text, row[0]);
	text = concat_str(text, " ");
	text = concat_str(text, row[1]);
	text = concat_str(text, "\n  Matricola: ");
	text = concat_str(text, row[2]);
	text = concat_str(text, "\n  Email: ");
	text = concat_str(text, row[3]);
	text = concat_str(text, "\n  Progetto richiesto il: ");
	text = concat_str(text, row[4]);
	text = concat_str(text, "\n  Progetto confermato il: ");
	text = concat_str(text, row[5]);
	text = concat_str(text, "\n  Token di conferma: ");
	text = concat_str(text, row[6]);

	return text;
}
