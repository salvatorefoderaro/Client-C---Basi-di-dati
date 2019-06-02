#include <ncurses.h>

#include "program.h"

int barmenu(struct assegnazione *list, int arraylength, int selection)
{
	int counter, offset = 0, ky = 0;
	int menulength = LINES/2;
	int col = 0, row = 1;
	int width = COLS;
	char formatstring[7];
	curs_set(0);
	char cur_element[COLS];

	if (arraylength < menulength)
		menulength = arraylength;

	if (selection > menulength)
		offset = selection - menulength + 1;

	sprintf(formatstring, "%%-%ds", width);

	while (ky != 27) {
		for (counter = 0; counter < menulength; counter++) {
			if (counter + offset == selection)
				attron(A_REVERSE);
			snprintf(cur_element, COLS, "%s %s (%s): %s", list[counter].nome, list[counter].cognome, list[counter].matricola, list[counter].titolo);
			mvprintw(row + counter, col, formatstring, cur_element);
			attroff(A_REVERSE);
		}

		ky = getch();

		switch (ky) {
		case KEY_UP:
			if (selection) {
				selection--;
				if (selection < offset)
					offset--;
			}
			break;
		case KEY_DOWN:
			if (selection < arraylength - 1) {
				selection++;
				if (selection > offset + menulength - 1)
					offset++;
			}
			break;
		case KEY_HOME:
			selection = 0;
			offset = 0;
			break;
		case KEY_END:
			selection = arraylength - 1;
			offset = arraylength - menulength;
			break;
		case KEY_PPAGE:
			selection -= menulength;
			if (selection < 0)
				selection = 0;
			offset -= menulength;
			if (offset < 0)
				offset = 0;
			break;
		case KEY_NPAGE:
			selection += menulength;
			if (selection > arraylength - 1)
				selection = arraylength - 1;
			offset += menulength;
			if (offset > arraylength - menulength)
				offset = arraylength - menulength;
			break;
		case 10:	//enter
			return list[selection].id;
			break;
		case KEY_F(1):	// function key 1
			return -1;
		case 27:	//esc
			// esc twice to get out, otherwise eat the chars that don't work
			//from home or end on the keypad
			ky = getch();
			if (ky == 27) {
				curs_set(0);
				mvaddstr(9, 77, "   ");
				return -1;
			} else if (ky == '[') {
				getch();
				getch();
			} else
				ungetch(ky);
		}
	}
	return -1;
}
