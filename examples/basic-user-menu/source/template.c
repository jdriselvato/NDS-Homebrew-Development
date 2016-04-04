/*---------------------------------------------------------------------------------
Listening to: I'm sick today, I usually get a sick like this once a year so it's normal but having a hard time messing around with scrolling-background. I can't think straight so I'm going to learn something different, menu navigation.
In any case I'm listening to more Polish Hip-hop, current this:
MAŁPA - Nie byłem nigdy (teledysk): https://youtu.be/HCHvGI0-ypA
Sitek - Chodź Ze Mną: https://www.youtube.com/watch?v=38kk_HtN06s
Sulin - Jedna minuta: https://youtu.be/-PJ10-qwvcc

Info: Basic User Menu (basic-user-menu.c)

Here the user can use the up and down key to navigate a menu and view new data when selecting menu item with the A button

What's new:
- keysDown() lets you hold down a key and it only registers as one press. Great for menus
- consoleSetWindow() lets you set the window of the console (x, y, width, height)
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>

// Menu item object
struct MenuItem {
	const char* name;
	int count;
};

PrintConsole consoleSub; //console object for bottom screen

// list of menu items
struct MenuItem items[] = {
	{"Play", 0},
	{"Load", 1},
	{"Settings", 2},
	{"Credits", 3}
};

// functions
int arrowKeysDownHandler(int keys, int cursorLocation);
int otherKeysDownHandler(int keys);

int main(void) {
	videoSetModeSub(MODE_0_2D);

//	bgInitSub(3, BgType_Bmp16, BgSize_B16_256x256, 0, 1);
	consoleInit(&consoleSub, 0, BgType_Text4bpp, BgSize_T_256x256, 16, 6, false, true);
    consoleSetWindow(&consoleSub, 5, 5, 32, 32); // makes things cleaner to set up a window
    // lets also set up the console font attributes to make things look more realistic to a games menu

	int keys; // handles user button presses
	int itemCount = 4; // number of item[]
	int cursorLocation = 0; //cursor location determines where the > is on the list
	bool selected = false;

	while(1) {
		swiWaitForVBlank();
		consoleClear();

		scanKeys(); // scan for button presses
		keys = keysDown();

		if (!selected) {
			for(int x = 0; x < itemCount; x++) {
				char cursor = (x == cursorLocation) ? '>' : ' '; // check if cursor is at the 'x' location in the list
				iprintf("%c %s\n\n\n\n", cursor, items[x].name); // print the item
			}
		}

		if (keys & KEY_A) { // A Key Selects current menu item
			otherKeysDownHandler(keys);
		} else if (keys & KEY_B) { // B Key goes back to menu screen

		} else { // handle any other key besides A
			cursorLocation = arrowKeysDownHandler(keys, cursorLocation);
		}
	}
}

// function to handel only A button (for now)
int otherKeysDownHandler(int keys) {
	return 0; // come back to this
}
// function to handle all button presses
int arrowKeysDownHandler(int keys, int cursorLocation) {
	int newCursorLocation = cursorLocation;
	if (keys & KEY_UP) newCursorLocation--;
	if (keys & KEY_DOWN) newCursorLocation++;
	if (newCursorLocation < 0 || newCursorLocation > 3) return cursorLocation; // set boundries so the '> doesn't go off screen
	return newCursorLocation;
}