#include <nds.h>
#include "house.h"

extern const unsigned int spritesheetTiles[2880];

House initHouse() {
	House house = {SCREEN_WIDTH / 2 - 8, SCREEN_HEIGHT / 2 - 8};
	house.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	house.tileSheet = (u8*)spritesheetTiles;
	return house;
}

void generateHouse(House * house) {
	u8* offset = house->tileSheet + 4 * 16*16;
	dmaCopy(offset, house->gfx, 16*16);

	oamSet(&oamSub,
		1, // oam entry id
		house->x, house->y, // x, y location
		0, 15, // priority, palette
		SpriteSize_16x16,
		SpriteColorFormat_256Color,
		house->gfx, // the oam gfx
		-1, false, false, false, false, false);
}

bool hideHouseMenu(touchPosition touch, House * house) {
	if (touch.px > house->x && touch.px < house->x + 16 // stylus inside x pos of house
		&& touch.py > house->y && touch.py < house->y + 16) { // inside y pos of house
		return false;
	}
	return true;
}

