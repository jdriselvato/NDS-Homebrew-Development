#include <nds.h>
#include <stdio.h>
#include "menu.h"

extern const unsigned int spritesheetTiles[2880];
int selectingMenuItem(Menu * menu, touchPosition * touch);

Menu initMenu() {
	Menu menu = {SCREEN_WIDTH / 2 - 16, SCREEN_HEIGHT - 16};
	for (u8 i = 0; i < 5; i++) {
		menu.gfx[i] = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	}
 	menu.tileSheet = (u8*)spritesheetTiles;
 	menu.stylus = &stylusTouch;
 	menu.selectedIcon = -1;
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

void stylusTouch(Menu * menu, touchPosition * touch) {
	int icon = selectingMenuItem(menu, touch);
	menu->selectedIcon = icon;
}

int selectingMenuItem(Menu * menu, touchPosition * touch) {
	for (u8 i = 0; i < 5; i++) {
		if (touch->px > (menu->x)
			&& touch->px < (menu->x + (16 * (i + 1)))
			&& touch->py > menu->y
			&& touch->py < menu->y + 16) {
			return i; // return the int value (0-4) which is the select items index
		}
	}
	return -1; // null
}