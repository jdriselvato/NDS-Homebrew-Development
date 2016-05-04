/*---------------------------------------------------------------------------------
# What  I listened to:
-- We Lost The Sea - Departure Songs (April 30th, 2016)

# Basic RTS
In this example we learn how to use the stylus to select a house and have a menu pop up. In Part 2, we will use this menu to select units to create.
-- John Riselvato ( April 28th, 2016 )
find me at: @jdriselvato

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

Things to know:
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <spritesheet.h>
#include "units.h"

typedef struct {
	int x, y;
	u16* gfx;
	u8* gfx_frame;
} House;

typedef struct {
	int x, y; // location on screen
	u16* gfx;
	u8* gfx_frame;
	bool shouldDisplay;
} Menu;

/*---------------------------------------------------------------------------------
Functions in code
---------------------------------------------------------------------------------*/
void generateHouse(House * House_sprite);
void generateMenu();

Menu menu_object = {SCREEN_WIDTH / 2 - 16, SCREEN_HEIGHT - 16};

/*---------------------------------------------------------------------------------
Global Variables
---------------------------------------------------------------------------------*/
touchPosition touch; // Stylus location


int main(int argc, char** argv) {
	House House_sprite = {SCREEN_WIDTH / 2 - 8, SCREEN_HEIGHT / 2 - 8}; // Center House to Screen

	// Initialize the top screen engine
	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);

	Character character = addNewUnit();

	// Set up the House sprite
	House_sprite.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	House_sprite.gfx_frame = (u8*)spritesheetTiles;

	menu_object.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	menu_object.gfx_frame = (u8*)spritesheetTiles;

	while(1) {
		if(keysHeld() & KEY_TOUCH) touchRead(&touch); // assign touch variable

		if (menu_object.shouldDisplay == true) {
			generateMenu();
		}
		characterMovement(&character);
		generateHouse(&House_sprite);

		swiWaitForVBlank();
		oamUpdate(&oamSub);
	}
	return 0;
}

void generateMenu() {
	u8* offset = menu_object.gfx_frame + 5 * 16*16;
	dmaCopy(offset, menu_object.gfx, 16*16);

	oamSet(&oamSub,
		2, // oam entry id
		menu_object.x, menu_object.y, // x, y location
		0, 15, // priority, palette
		SpriteSize_16x16,
		SpriteColorFormat_256Color,
		menu_object.gfx, // the oam gfx
		-1, false, menu_object.shouldDisplay, false, false, false);
}

/*---------------------------------------------------------------------------------
Code for generating the House
---------------------------------------------------------------------------------*/
void generateHouse(House * House_sprite) {
	u8* offset = House_sprite->gfx_frame + 4 * 16*16;
	dmaCopy(offset, House_sprite->gfx, 16*16);

	menu_object.shouldDisplay = false;
	if (touch.px > House_sprite->x && touch.px < House_sprite->x + 16 // stylus inside x pos of house
		&& touch.py > House_sprite->y && touch.py < House_sprite->y + 16) { // inside y pos of house
		menu_object.shouldDisplay = true;
	}

	oamSet(&oamSub,
		1, // oam entry id
		House_sprite->x, House_sprite->y, // x, y location
		0, 15, // priority, palette
		SpriteSize_16x16,
		SpriteColorFormat_256Color,
		House_sprite->gfx, // the oam gfx
		-1, false, false, false, false, false);
}