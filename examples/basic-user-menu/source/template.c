/*---------------------------------------------------------------------------------
Listening to: I'm sick today, I usually get a sick like this once a year so it's normal but having a hard time messing around with scrolling-background. I can't think straight so I'm going to learn something different, menu navigation. 
In any case I'm listening to more Polish Hip-hop, current this: 
MAŁPA - Nie byłem nigdy (teledysk): https://youtu.be/HCHvGI0-ypA 
Sitek - Chodź Ze Mną: https://www.youtube.com/watch?v=38kk_HtN06s
Sulin - Jedna minuta: https://youtu.be/-PJ10-qwvcc

Info: Basic User Menu (basic-user-menu.c)

Here the user can use the up and down key to navigate a menu and view new data when selecting menu item with the A button

What to know:
- How to call a function c and pass variable

What's new:
- keysDown() lets you hold down a key and it only registers as one press. Great for menus
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

// functions
int keysDownHandler(int keys, int cursorLocation);

int main(void) {
	videoSetModeSub(MODE_0_2D);
	consoleDemoInit();

	int keys; // handles user button presses
	int itemCount = 4; // number of item[]
	int cursorLocation = 0; //cursor location determines where the > is on the list

	while(1) {
		swiWaitForVBlank();
		consoleClear();
		
		scanKeys(); // scan for button presses
		keys = keysDown();
		cursorLocation = keysDownHandler(keys, cursorLocation);

		//if(keys & KEY_A);

		for(int x = 0; x < itemCount; x++) {
			char cursor = (x == cursorLocation) ? '>' : ' '; // check if cursor is at the 'x' location in the list
			iprintf("\t%c%d: %s\n", cursor, x+1, items[x].name); // print the item
		}
	}
}

// function to handle all button presses
int keysDownHandler(int keys, int cursorLocation) {
	int newCursorLocation = cursorLocation;
	if (keys & KEY_UP) newCursorLocation--;
	if (keys & KEY_DOWN) newCursorLocation++;
	if (newCursorLocation < 0 || newCursorLocation > 3) return cursorLocation; // set boundries so the '> doesn't go off screen
	// TODO: set these globally I suppose

	return newCursorLocation;
}