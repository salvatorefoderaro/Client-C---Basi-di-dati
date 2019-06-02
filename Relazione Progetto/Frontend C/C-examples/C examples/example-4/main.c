#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include <ncurses.h>

#include "program.h"

struct configuration conf;

const char *title = "Sistema di Prenotazione Esami";

int main(int argc, char **argv)
{
	int selection = 0, count;
	struct assegnazione *list = NULL;
	char *text;
	
	load_file(&config, "config.json");
	parse_config();
	conn();

	initscr();
	noecho();
	keypad(stdscr, TRUE);

	mvprintw(0, (COLS-strlen(title))/2, title, 0);
	
	while(1) {
		count = get_list(&list);
		
		selection = barmenu(list, count, 0);

		free(list);

		if(selection > 0) {
			text = get_entry(selection);
			mvprintw(LINES/2+1, 0, "%s", text);
			free(text);
		}

		refresh();
		getch();
	}

	disconn();
	endwin();
	return 0;
}
