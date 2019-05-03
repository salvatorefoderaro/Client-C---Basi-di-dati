#pragma once

#include <stdbool.h>
#include <mysql.h> 

#define flushTerminal printf("\nPremi invio per continuare..."); while(getchar() != '\n'); printf("\e[1;1H\e[2J");
#define flush_terminal_no_input printf("\e[1;1H\e[2J");

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
extern void checkPostazioniDisponibili(MYSQL *connessione);
extern void assignToPostazioneFree(MYSQL *connessione);
extern int getUserType(MYSQL *connessione);
extern int menuSettoreSpazi(MYSQL *connessione);
extern int menuSettoreAmministrativo(MYSQL *connessione);
extern int menuAltroDipendente(MYSQL *connessione);
extern void getUserNumeroInterno(MYSQL *connessione);
extern void assegnaPostazioneToUfficio(MYSQL *connessione);