/*---------------------------------------------------------------------------------
bitmap-sprite-movement
It's about time we actual use images we'd use in a video game, bitmap sprites. I've provided a sprite sheet that's free to use for any of your personal projects. We'll use this sprite sheet to move the character around the top screen and use different angles to show movement. Example, moving right shows the character looking right.
-- John Riselvato ( April 7th, 2016 )

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

Things to know:
- How to convert a png sprite sheet with grit to a header file
- What an enum is
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <character16x16.h>

typedef struct {
	int x, y; // x/y lcoation
	u16* gfx; // oam GFX
	int gfx_frame;

	int state; // sprite walk state
	int frame; // the sprite sheet frame
} Character;

enum SpriteState { WALK_DOWN = 0, WALK_UP = 1, WALK_LEFT = 2, WALK_RIGHT = 3 }; // states for walking

int main(int argc, char** argv) {
	Character character = {0, 0}; // set the initial location of the sprite

	// Initialize the top screen engine
	videoSetMode(MODE_0_2D);
	vramSetBankA(VRAM_A_MAIN_SPRITE);
	oamInit(&oamMain, SpriteMapping_1D_128, false);

	character.gfx = oamAllocateGfx(&oamMain, SpriteSize_16x16, SpriteColorFormat_256Color);
	character.gfx_frame = (u8*)character16x16Tiles;

	dmaCopy(character16x16Pal, SPRITE_PALETTE, 512);

	while(1) {
		character.state = WALK_DOWN;

		int frame = character.frame + character.state;
		u8* offset = character.gfx + frame * 16*16;

		dmaCopy(offset, character.gfx, 16*16);

		oamSet(&oamMain,
			0, // oam entry id
			character.x, character.y, // x, y location
			0, 0, // priority, palette
			SpriteSize_32x32,
			SpriteColorFormat_256Color,
			character.gfx, // the oam gfx
			-1, false, false, false, false, false);
		swiWaitForVBlank();
		oamUpdate(&oamMain);
	}
	return 0;
}