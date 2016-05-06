#include <nds.h>
#include "menu.h"

Menu initMenu() {
	Menu menu_object = {SCREEN_WIDTH / 2 - 16, SCREEN_HEIGHT - 16};

	oamInit(&oamSub, SpriteMapping_1D_128, false);
	dmaCopy(spritesheetPal, SPRITE_PALETTE_SUB, 512);

	menu_object.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	menu_object.gfx_frame = (u8*)spritesheetTiles;

	return menu_object;
}

void displayMenu(Menu * menu) {
	u8* offset = menu->gfx_frame + 5 * 16*16;
	dmaCopy(offset, menu->gfx, 16*16);

	oamSet(&oamSub,
		2, // oam entry id
		menu->x, menu->y, // x, y location
		0, 15, // priority, palette
		SpriteSize_16x16,
		SpriteColorFormat_256Color,
		menu->gfx, // the oam gfx
		-1, false,
		false, // hide me?
		false, false, false);
}