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

typedef struct {
	int x, y, state; // x/y lcoation and sprite walk state
	u16* gfx; // oam GFX
	u8* gfx_frame;
} Character;

enum SpriteState { WALK_DOWN = 0, WALK_UP = 1, WALK_LEFT = 2, WALK_RIGHT = 3 }; // states for walking

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
void characterMovement(Character * character);
void generateHouse(House * House_sprite);
void generateMenu();

Menu menu_object = {SCREEN_WIDTH / 2 - 16, SCREEN_HEIGHT - 16};

/*---------------------------------------------------------------------------------
Global Variables
---------------------------------------------------------------------------------*/
touchPosition touch; // Stylus location


int main(int argc, char** argv) {
	Character character = {20, 20}; // set the initial x, y location of the sprite
	House House_sprite = {SCREEN_WIDTH / 2 - 8, SCREEN_HEIGHT / 2 - 8}; // Center House to Screen

	// Initialize the top screen engine
	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);

	oamInit(&oamSub, SpriteMapping_1D_128, false);
	dmaCopy(spritesheetPal, SPRITE_PALETTE_SUB, 512); // <---  ah there is a sub sprite palette

	// Set up the Character sprite
	character.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	character.gfx_frame = (u8*)spritesheetTiles; // makes a reference to character16x16Tiles from character16x16.h

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
		-1, false, false, false, false, false);
}

/*---------------------------------------------------------------------------------
Code for generating the House
---------------------------------------------------------------------------------*/
void generateHouse(House * House_sprite) {
	u8* offset = House_sprite->gfx_frame + 4 * 16*16;
	dmaCopy(offset, House_sprite->gfx, 16*16);

	if (touch.px > House_sprite->x && touch.px < House_sprite->x + 16 // stylus inside x pos
		&& touch.py > House_sprite->y && touch.py < House_sprite->y + 16) { // inside y pos
		menu_object.shouldDisplay = true;
	} else {
		menu_object.shouldDisplay = false;
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

/*---------------------------------------------------------------------------------
Code for Character
---------------------------------------------------------------------------------*/
void characterMovement(Character * character) {
	scanKeys();
	int keys = keysHeld();

	if (keys & KEY_RIGHT) {
		character->state = WALK_RIGHT;
		character->x++;
	} else if (keys & KEY_LEFT) {
		character->state = WALK_LEFT;
		character->x--;
	} else if (keys & KEY_DOWN) {
		character->state = WALK_DOWN;
		character->y++;
	} else if (keys & KEY_UP) {
		character->state = WALK_UP;
		character->y--;
	}

	int frame = character->state;
	u8* offset = character->gfx_frame + frame * 16*16;
	dmaCopy(offset, character->gfx, 16*16);

	oamSet(&oamSub,
		0, // oam entry id
		character->x, character->y, // x, y location
		0, 15, // priority, palette
		SpriteSize_16x16,
		SpriteColorFormat_256Color,
		character->gfx, // the oam gfx
		-1, false, false, false, false, false);
}