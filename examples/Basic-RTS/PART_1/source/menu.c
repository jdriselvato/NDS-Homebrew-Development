#include <nds.h>
#include "menu.h"

extern const unsigned int spritesheetTiles[2880];

Menu initMenu() {
	Menu menu = {SCREEN_WIDTH / 2 - 16, SCREEN_HEIGHT - 16};
	u16* gfx_array[5] = {
		oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color),
		oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color),
		oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color),
		oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color),
		oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color),
		};
	menu.gfx = gfx_array;
	menu.gfx_frame = (u8*)spritesheetTiles;

	return menu;
}

void displayMenu(Menu * menu, bool hideMenu) {
	for (int i = 0; i < 5; i++) {
		u8* offset = menu->gfx_frame + (5 + i) * 16*16;
		dmaCopy(offset, menu->gfx, 16*16);

		oamSet(&oamSub,
			2 + i, // oam entry id
			menu->x + (16 * i), menu->y, // x, y location
			0, 15, // priority, palette
			SpriteSize_16x16,
			SpriteColorFormat_256Color,
			menu->gfx[i], // the oam gfx
			-1, false,
			hideMenu, // hide me?
			false, false, false);
	}
}