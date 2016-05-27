#include <nds.h>
#include "units.h"

/*---------------------------------------------------------------------------------
Check out this example code for timers: http://libnds.devkitpro.org/time_2stopwatch_2source_2main_8c-example.html#a8
We'll want to use timers to generate the units, not all at once.

What this source does or should do:
- When the menu item "0" is selected a new unit to be created will be added to a queue.
- The queue will count down 2 seconds before creating a queue.
- After 2 seconds the unit will be added to the screen near the house.
- up to 100 units can be created
- Units will also be assigned tasks in this source, for example:
   - gather resource
   - Cut trees
   - fight
   - build other building (undefined)
---------------------------------------------------------------------------------*/
extern const unsigned int spritesheetTiles[2880];
int queue = 0;

Character unitArray[100];
int unitCount = 0;

Character addNewUnit() {
	Character character;
	character.x = 20;
	character.y = 20;
	character.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	character.tileSheet = (u8*)spritesheetTiles; // makes a reference to character16x16Tiles from character16x16.h
	return character;
}

void createNewUnit() {
	Character newUnit = addNewUnit(); 	// create a new unit
	unitArray[unitCount] = newUnit;	// Save it to unit array
	unitCount++; // increase unit array count for next addition
}

void addToQueue() {
	// add to queue list as a new number
	queue = queue + 1;
	// start timer (2 seconds)
	// at the end of timer call "createNewUnit"
	createNewUnit();
}

void displayUnits() {
	for (int i = 0; i < unitCount; i++) {
		Character character = unitArray[i];
		characterMovement(&character, i);
	}
}

/*---------------------------------------------------------------------------------
Code for Character Movement
---------------------------------------------------------------------------------*/
void characterMovement(Character * character, int oam) {
	int frame = character->state;
	u8* offset = character->tileSheet + frame * 16*16;
	dmaCopy(offset, character->gfx, 16*16);

	oamSet(&oamSub,
		1000 + oam, // oam entry id
		character->x, character->y, // x, y location
		0, 15, // priority, palette
		SpriteSize_16x16,
		SpriteColorFormat_256Color,
		character->gfx, // the oam gfx
		-1, false, false, false, false, false);
}