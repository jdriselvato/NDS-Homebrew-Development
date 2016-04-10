/*---------------------------------------------------------------------------------
basic-first-game
Everything we've learned from the first few examples has given us enough knowledge to create our first game. We'll be starting off with the `bitmap-sprite-movement` code and expanding it. Specifically, we'll be using what we learned from `bitmap-sprite-movement` and `basic-sprite-collision` to create collection game. So the character will be able to collect coins and a scoreboard will update. It's endless and no real goal but challange yourself to improve it to a full game (maybe like snake?).

-- John Riselvato ( April 10th, 2016 )

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

Things to know:
- Everything from the first example code to bitmap-sprite-movement
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>

#include <spritesheet.h>

typedef struct {
	int x, y; // x/y lcoation
	u16* gfx; // oam GFX
	u8* gfx_frame;

	int state; // sprite walk state
} Character;

enum SpriteState { WALK_DOWN = 0, WALK_UP = 1, WALK_LEFT = 2, WALK_RIGHT = 3 }; // states for walking

typedef struct {
	u16* gfx;
	u8* gfx_frame;
	int x, y;
} Gem;

Character characterMovement(Character character);
void generateGem(Gem gem_sprite);
void addBackground();

int score = 0;

int main(int argc, char** argv) {
	Character character = {20, 20}; // set the initial x, y location of the sprite
	Gem gem_sprite = {0, 0}; // add the gem to the screen

	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);
	consoleDemoInit();

	// Initialize the top screen engine
	videoSetMode(MODE_0_2D);
	vramSetBankA(VRAM_A_MAIN_SPRITE | VRAM_A_MAIN_BG);
	oamInit(&oamMain, SpriteMapping_1D_128, false);

	// Set up the Character sprite
	character.gfx = oamAllocateGfx(&oamMain, SpriteSize_16x16, SpriteColorFormat_256Color);
	character.gfx_frame = (u8*)spritesheetTiles; // makes a reference to character16x16Tiles from character16x16.h
	dmaCopy(spritesheetPal, SPRITE_PALETTE, 512);

	// Set up the Gem sprite
	gem_sprite.gfx = oamAllocateGfx(&oamMain, SpriteSize_16x16, SpriteColorFormat_256Color);
	gem_sprite.gfx_frame = (u8*)spritesheetTiles;
	while(1) {
		printf("\x1b[1;1HScore: %d", score);
		character = characterMovement(character);
		generateGem(gem_sprite);
		addBackground();

		swiWaitForVBlank();
		oamUpdate(&oamMain);
	}
	return 0;
}

/*---------------------------------------------------------------------------------
Code for Character
---------------------------------------------------------------------------------*/
Character characterMovement(Character character) {
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

	return character;
}

/*---------------------------------------------------------------------------------
Code for generating the gem
---------------------------------------------------------------------------------*/
void generateGem(Gem gem_sprite) {
	u8* offset = gem_sprite.gfx_frame + 4 * 16*16;
	dmaCopy(offset, gem_sprite.gfx, 16*16);

	oamSet(&oamMain,
		1, // oam entry id
		gem_sprite.x, gem_sprite.y, // x, y location
		0, 15, // priority, palette
		SpriteSize_16x16,
		SpriteColorFormat_256Color,
		gem_sprite.gfx, // the oam gfx
		-1, false, false, false, false, false);
}

/*---------------------------------------------------------------------------------
Code for the background
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
	ARGB16(1, 12, 12, 12), // gray (stone wall?)
	ARGB16(1, 0, 31, 0), // green (grass?)
	ARGB16(1, 31, 31, 0) // yellow (sand?)
};

int tile_array[6][8] = { // create a map layout
	{0, 0, 0, 2, 0, 0, 0, 0},
	{1, 1, 1, 2, 1, 1, 1, 1},
	{1, 1, 1, 2, 1, 1, 1, 1},
	{1, 1, 1, 2, 2, 2, 2, 1},
	{1, 1, 1, 1, 1, 1, 2, 1},
	{1, 1, 1, 1, 1, 1, 2, 1},
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