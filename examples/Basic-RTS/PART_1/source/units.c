#include <nds.h>
#include "units.h"

Character addNewUnit() {
	Character character = {20, 20};

	oamInit(&oamSub, SpriteMapping_1D_128, false);
	dmaCopy(spritesheetPal, SPRITE_PALETTE_SUB, 512);

	character.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	character.gfx_frame = (u8*)spritesheetTiles; // makes a reference to character16x16Tiles from character16x16.h
	return character;
}

/*---------------------------------------------------------------------------------
Code for Character Movement
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