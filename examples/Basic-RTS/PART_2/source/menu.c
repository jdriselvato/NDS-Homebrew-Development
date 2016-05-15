#include <nds.h>
#include "menu.h"

extern const unsigned int spritesheetTiles[2880];
typedef struct {
	int x, y; // location on screen
	u16* gfx[5];
	u8* tileSheet;
	bool shouldDisplay;
} Icon;

Menu initMenu() {
	Menu menu = {SCREEN_WIDTH / 2 - 16, SCREEN_HEIGHT - 16};
	for (u8 i = 0; i < 5; i++) {
		menu.gfx[i] = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	}
 	menu.tileSheet = (u8*)spritesheetTiles;
 	menu.stylus = &stylusTouch;
	return menu;
}

void displayMenu(Menu * menu, bool hideMenu) {
	for (u8 i = 0; i < 5; i++) {
		u8* offset = menu->tileSheet + (5 + i) * 16*16;
		dmaCopy(offset, menu->gfx[i], 16*16);

		oamSet(&oamSub,
			2 + i, // oam entry id
			menu->x + (16 * i), menu->y, // x, y location
			0, 15, // priority, palette
			SpriteSize_16x16,
			SpriteColorFormat_256Color,
			menu->gfx[i], // the oam gfx
			-1, false,
			hideMenu, // hide me? (hideMenu)
			false, false, false);
	}
}

void stylusTouch(touchPosition touch) {
	int x = 1;
	x++;
}

int selectingMenuItem() {
	// here we will take the x & y location
	// determine what menu item is selected
	// return the int value (0-4)
	return -1;
}