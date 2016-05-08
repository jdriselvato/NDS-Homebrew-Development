/*---------------------------------------------------------------------------------
# What  I listened to:
-- We Lost The Sea - Departure Songs (April 30th, 2016)
-- Animal Crossing Rainy Day Theme (May 7th, 2016) - https://www.youtube.com/watch?v=5ehnZNaNow4

# Basic RTS
In this example we learn how to use the stylus to select a house and have a menu pop up. In Part 2, we will use this menu to select units to create.
-- John Riselvato ( April 28th, 2016 )
find me at: @jdriselvato

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

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

	// Initialize the top screen engine
	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);

	oamInit(&oamSub, SpriteMapping_1D_128, false);
	dmaCopy(spritesheetPal, SPRITE_PALETTE_SUB, 512);

	Character character = addNewUnit();
	Menu menu = initMenu();
	House house = initHouse();

	while(1) {
		if(keysHeld() & KEY_TOUCH) touchRead(&touch); // assign touch variable

		characterMovement(&character);

		generateHouse(&house);
		displayMenu(&menu, true);

		swiWaitForVBlank();
		oamUpdate(&oamSub);
	}
	return 0;
}