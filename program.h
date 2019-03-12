#pragma once

#include <stdbool.h>
#include <mysql.h> 

struct configuration {
	char *host;
	char *username;
	char *password;
	unsigned int port;
	char *database;
};

extern struct configuration conf;
extern char *config;

extern int parse_config();
extern size_t load_file(char **buffer, char *filename);
extern void dump_config(void);
extern char *getInput(unsigned int lung, char *stringa, bool hide);
extern bool yesOrNo(char *domanda, char yes, char no, bool predef, bool insensitive);
extern void getAssegnazioniPassate(MYSQL *connessione);
extern void editMansione(MYSQL *connessione);
extern void printResults(MYSQL_STMT *statement, MYSQL *connessione);
extern void test_error(MYSQL * con, int status);
extern void test_stmt_error(MYSQL_STMT * stmt, int status);