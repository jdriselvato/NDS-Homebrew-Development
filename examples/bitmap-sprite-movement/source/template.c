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
	u8* gfx_frame;

	int state; // sprite walk state
} Character;

enum SpriteState { WALK_DOWN = 0, WALK_UP = 1, WALK_LEFT = 2, WALK_RIGHT = 3 }; // states for walking

void addBackground();

int main(int argc, char** argv) {
	Character character = {0, 0}; // set the initial x, y location of the sprite

	// Initialize the top screen engine
	videoSetMode(MODE_0_2D);
	vramSetBankA(VRAM_A_MAIN_SPRITE | VRAM_A_MAIN_BG);
	oamInit(&oamMain, SpriteMapping_1D_128, false);

	character.gfx = oamAllocateGfx(&oamMain, SpriteSize_16x16, SpriteColorFormat_256Color);
	character.gfx_frame = (u8*)character16x16Tiles; // makes a reference to character16x16Tiles from character16x16.h
	dmaCopy(character16x16Pal, SPRITE_PALETTE, 512); // 512 because character16x16Pal

	while(1) {
		scanKeys();
		int keys = keysHeld();

		if (keys & KEY_RIGHT) {
			character.state = WALK_RIGHT;
			character.x++;
		} else if (keys & KEY_LEFT) {
			character.state = WALK_LEFT;
			character.x--;
		} else if (keys & KEY_DOWN) {
			character.state = WALK_DOWN;
			character.y++;
		} else if (keys & KEY_UP) {
			character.state = WALK_UP;
			character.y--;
		}


		int frame = character.state;
		u8* offset = character.gfx_frame + frame * 16*16;
		dmaCopy(offset, character.gfx, 16*16);

		oamSet(&oamMain,
			0, // oam entry id
			character.x, character.y, // x, y location
			0, 15, // priority, palette
			SpriteSize_16x16,
			SpriteColorFormat_256Color,
			character.gfx, // the oam gfx
			-1, false, false, false, false, false);

		addBackground();

		swiWaitForVBlank();
		oamUpdate(&oamMain);
	}
	return 0;
}


/*---------------------------------------------------------------------------------
BELOW IS NOT PART OF THE TUTORIAL BUT IS A GOOD EXAMPLE OF HOW TO MIX SPRITES WITH BACKGROUNDS
I'm really adding this code because without a background, you can't see the black parts of the sprite.
---------------------------------------------------------------------------------*/
typedef struct {
	u16* gfx;
	SpriteSize size;
	SpriteColorFormat format;
	int color;
	int paletteAlpha;
	int x;
	int y;
} BGTile;

int tile_colors[] = {
	ARGB16(1, 0, 0, 31), // blue (water?)
	ARGB16(1, 0, 31, 0), // green (grass?)
	ARGB16(1, 31, 31, 0) // yellow (sand?)
};

int tile_array[6][8] = { // create a map layout
	{0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 2, 2, 1, 1, 0, 0},
	{0, 1, 1, 2, 1, 1, 1, 0},
	{0, 1, 1, 2, 2, 2, 2, 0},
	{0, 0, 1, 1, 1, 1, 2, 0},
	{0, 0, 0, 0, 0, 0, 0, 0},
};

u16* gfx_array[6*8] = {0}; // unfortunately using this is the easiest way to keep track of gfx for oamSet.

void addBackground() {
	int BGTileW = 32; // Width
	int BGTileH = 32; // Height

	int count = 0;
	for(int x = 0; x < 6; x++) {
		for (int y = 0; y < 8; y++) {
			int tile = tile_array[x][y]; // select the color for selected tile
			BGTile tmp = { 0, SpriteSize_32x32, SpriteColorFormat_Bmp, tile_colors[tile], 15, y * BGTileW, x * BGTileH };

			if (gfx_array[count] == 0) { // you can only allocate once
				gfx_array[count] = oamAllocateGfx(&oamMain, tmp.size, tmp.format); // allocate some space for the sprite graphics
			}

			dmaFillHalfWords(tmp.color, gfx_array[count], BGTileW*BGTileH*2); // fill each as a Red Square

			oamSet(
				&oamMain, //main display
				count + 50, //oam entry to set (lazy way to ensure no memory is over written)
				tmp.x, tmp.y, //position
				0, //priority
				tmp.paletteAlpha, //palette for 16 color sprite or alpha for bmp sprite
				tmp.size, tmp.format, gfx_array[count], 0,
				false, //double the size of rotated sprites
				false, //don't hide the sprite
				false, false, //vflip, hflip
				false //apply mosaic
			);

			count++;
		}
	}
}