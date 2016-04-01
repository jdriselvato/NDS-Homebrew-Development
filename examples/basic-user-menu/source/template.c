/*---------------------------------------------------------------------------------
Listening to: I'm sick today, I usually get a sick like this once a year so it's normal but having a hard time messing around with scrolling-background. I can't think straight so I'm going to learn something different, menu navigation. 
In any case I'm listening to more Polish Hip-hop, current this: 
MAŁPA - Nie byłem nigdy (teledysk): https://youtu.be/HCHvGI0-ypA 
Sitek - Chodź Ze Mną: https://www.youtube.com/watch?v=38kk_HtN06s
Sulin - Jedna minuta: https://youtu.be/-PJ10-qwvcc

Basic User Menu (basic-user-menu.c)

Here the user can use the up and down key to navigate a menu and view new data when selecting menu item with the A button
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>
// Menu item object
struct MenuItem { 
	const char* name;
	int count;
};

// list of menu items
struct MenuItem items[] = { 
	{"Play", 0},
	{"Load", 1},
	{"Settings", 2},
	{"Credits", 3}
};

int main(void) {
	videoSetModeSub(MODE_0_2D);
	consoleDemoInit();

	int itemCount = 4;

	while(1) {
		swiWaitForVBlank();
		consoleClear();
		for(int x = 0; x < itemCount; x++) {
			iprintf("\t%d: %s\n", x, items[x].name); 		
		}
	}
}