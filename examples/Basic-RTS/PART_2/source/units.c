#include <nds.h>
#include "units.h"

/*---------------------------------------------------------------------------------
Check out this example code for timers: http://libnds.devkitpro.org/time_2stopwatch_2source_2main_8c-example.html#a8
We'll want to use timers to generate the units, not all at once.

---------------------------------------------------------------------------------*/

extern const unsigned int spritesheetTiles[2880];
int queue = 0;

Character unitArray[100];
int unitCount = 0;

Character addNewUnit() {
	Character character = {20 + (unitCount + 5), 20};

	character.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	character.tileSheet = (u8*)spritesheetTiles; // makes a reference to character16x16Tiles from character16x16.h
	return character;
}

void createNewUnit() {
	unitArray[unitCount] = addNewUnit();
	unitCount++;
}

void addToQueue() {
	queue = queue + 1;
	createNewUnit();
}

void displayUnits() {
	if (unitCount == 0) return;
	for (int i = 0; i < unitCount; i++) {
		Character character = unitArray[i];
		characterMovement(&character);
	}
}

/*---------------------------------------------------------------------------------
Code for Character Movement
---------------------------------------------------------------------------------*/
void characterMovement(Character * character) {
	int frame = character->state;
	u8* offset = character->tileSheet + frame * 16*16;
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