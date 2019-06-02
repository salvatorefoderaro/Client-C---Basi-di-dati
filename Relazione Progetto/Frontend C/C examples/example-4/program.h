#pragma once

#include <stdbool.h>

struct configuration {
	char *host;
	char *username;
	char *password;
	unsigned int port;
	char *database;
};

struct assegnazione {
	int id;
	char nome[64];
	char cognome[64];
	char matricola[64];
	char titolo[128];
};

extern struct configuration conf;
extern char *config;

extern int parse_config();
extern size_t load_file(char **buffer, char *filename);
extern void dump_config(void);
extern void conn(void);
extern void disconn(void);
extern int barmenu(struct assegnazione *list, int arraylength, int selection);
extern size_t get_list(struct assegnazione **list);
extern char *get_entry(int id);

#define INITIAL_ROWS 8
