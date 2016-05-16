/*---------------------------------------------------------------------------------
# What  I listened to:

# Basic RTS Part 2
In this example we use our new menu to select a menu item, specifically create a unit. Using timers we'll create a queue for creating new units and once each timer is complete a unit will be added to the screen, next to the house.

-- John Riselvato ( May 12th, 2016 )
find me at: @jdriselvato

built with: "Nintendo DS rom tool 1.50.3 - Dec 12 2015"

Things to know:
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <spritesheet.h>

#include "menu.h"
#include "units.h"
#include "house.h"

/*---------------------------------------------------------------------------------
Global Variables
---------------------------------------------------------------------------------*/
touchPosition touch; // Stylus location

int main(int argc, char** argv) {
	videoSetModeSub(MODE_0_2D); // Initialize the top screen engine
	vramSetBankD(VRAM_D_SUB_SPRITE);

	oamInit(&oamSub, SpriteMapping_1D_128, false);
	dmaCopy(spritesheetPal, SPRITE_PALETTE_SUB, 512);

	Character character = addNewUnit();
	Menu menu = initMenu();
	House house = initHouse();

	while(1) {
		if(keysHeld() & KEY_TOUCH) {
			touchRead(&touch); // assign touch variable
			menu.stylus(&menu, &touch);
		}

		characterMovement(&character);
		generateHouse(&house);
		bool selected = hideHouseMenu(touch, &house);
		displayMenu(&menu, selected);

		swiWaitForVBlank();
		oamUpdate(&oamSub);
	}
	return 0;
}