/*---------------------------------------------------------------------------------
# Basic RTS
In this example we learn how to use the stylus to select a house and have a menu pop up. In Part 2, we will use this menu to select units to create.
-- John Riselvato ( April 28th, 2016 )
find me at: @jdriselvato

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

Things to know:
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <spritesheet.h>

typedef struct {
	int x, y, state; // x/y lcoation and sprite walk state
	u16* gfx; // oam GFX
	u8* gfx_frame;
} Character;

enum SpriteState { WALK_DOWN = 0, WALK_UP = 1, WALK_LEFT = 2, WALK_RIGHT = 3 }; // states for walking

typedef struct {
	u16* gfx;
	u8* gfx_frame;
	int x, y;
} Gem;

void characterMovement(Character * character);
void generateGem(Gem * gem_sprite);
bool collisionDetected(Gem gem_sprite, Character character);
void addBackground();

int score = 0;

int main(int argc, char** argv) {
	Character character = {20, 20}; // set the initial x, y location of the sprite
	Gem gem_sprite = {0, 0}; // add the gem to the screen

	// Initialize the top screen engine
	videoSetModeSub(MODE_0_2D);
	vramSetBankC(VRAM_C_SUB_BG);
	vramSetBankD(VRAM_D_SUB_SPRITE);
	oamInit(&oamSub, SpriteMapping_1D_128, false);

	// Set up the Character sprite
	character.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	character.gfx_frame = (u8*)spritesheetTiles; // makes a reference to character16x16Tiles from character16x16.h
	dmaCopy(spritesheetPal, SPRITE_PALETTE, 512);

	// Set up the Gem sprite
	gem_sprite.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);
	gem_sprite.gfx_frame = (u8*)spritesheetTiles;

	while(1) {

		if (collisionDetected(gem_sprite, character)) {
			score++;
			// move the sprite some where else on the screen
			gem_sprite.x = rand() % (256-16) + 1; // random x. 256 = width of screen minus 16 = sprite weidth. This prevents the gem from going off screen.
			gem_sprite.y = rand() % (192-16) + 1; // random y. 192 = height of screen minus 16 = sprite height. This prevents the gem from going off screen.
		}

		characterMovement(&character);
		generateGem(&gem_sprite);
		addBackground();

		swiWaitForVBlank();
		oamUpdate(&oamSub);
	}
	return 0;
}

/*---------------------------------------------------------------------------------
Code for Character
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
/*---------------------------------------------------------------------------------
Code for collision detection
---------------------------------------------------------------------------------*/
bool collisionDetected(Gem gem_sprite, Character character) {
	int characterWidth = 16;
	int characterHeight = 16;
	int gemWidth = 16;
	int gemHeight = 16;

	int characterLeft = character.x;
	int gemLeft = gem_sprite.x;
	int characterRight = character.x + characterWidth;
	int gemRight = gem_sprite.x + gemWidth;
	int characterTop = character.y;
	int gemTop = gem_sprite.y;
	int characterBottom = character.y + characterHeight;
	int gemBottom = gem_sprite.y + gemHeight;

	if (characterLeft < gemRight && // left character will detect right gem
		characterRight > gemLeft && // right character will detect left gem
		characterTop < gemBottom && // top character will detect gem bottom
		characterBottom > gemTop) { // bottom character will detect gem top
    	return true;
	}

	return false;
}

/*---------------------------------------------------------------------------------
Code for generating the gem
---------------------------------------------------------------------------------*/
void generateGem(Gem * gem_sprite) {
	u8* offset = gem_sprite->gfx_frame + 4 * 16*16;
	dmaCopy(offset, gem_sprite->gfx, 16*16);

	oamSet(&oamSub,
		1, // oam entry id
		gem_sprite->x, gem_sprite->y, // x, y location
		0, 15, // priority, palette
		SpriteSize_16x16,
		SpriteColorFormat_256Color,
		gem_sprite->gfx, // the oam gfx
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
	ARGB16(1, 12, 12, 12), // gray (stone gem?)
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
				gfx_array[count] = oamAllocateGfx(&oamSub, tmp.size, tmp.format); // allocate some space for the sprite graphics
			}

			dmaFillHalfWords(tmp.color, gfx_array[count], BGTileW*BGTileH*2); // fill each as a Red Square

			oamSet(
				&oamSub,
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