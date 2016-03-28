/*---------------------------------------------------------------------------------
Generating a basic tile generator from array
-- John Riselvato ( March 26th, 2016 )
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
/*---------------------------------------------------------------------------------
Things to know:
- 
---------------------------------------------------------------------------------*/

typedef struct {
	u16* gfx;
	SpriteSize size;
	SpriteColorFormat format;
	int color;
	int paletteAlpha;
	int x;
	int y;
} Sprite;

int main(int argc, char** argv) {
	videoSetModeSub(MODE_0_2D);
	oamInit(&oamSub, SpriteMapping_Bmp_1D_128, false); //initialize the sub sprite engine with 1D mapping 128 byte boundary
	vramSetBankD(VRAM_D_SUB_SPRITE);

	Sprite tilesArray[] = { // create an array of the different tiles to be used
		{0, SpriteSize_16x16, SpriteColorFormat_Bmp, ARGB16(1, 0, 0, 31), 15, 20, 15}, // Blue Tile (water?)
		{0, SpriteSize_16x16, SpriteColorFormat_Bmp, ARGB16(1, 0, 31, 0), 15, 20, 80}, // Green Tile (grass?)
	}

	int mapArray[] = { // create a map layout
		0, 0, 0, 1, 0,
		0, 1, 1, 1, 0,
		0, 0, 0, 1, 0,
	};

	while(1) {
		for(int i = 0; i < 15; i++) {
			if (sprites[i].gfx == 0) { // we only need to allocate space the first time the sprite is created
				sprites[i].gfx = oamAllocateGfx(&oamSub, sprites[i].size, sprites[i].format); // allocate some space for the sprite graphics
			}

			oamSet(
				&oamSub, //sub display 
				i,       //oam entry to set
				sprites[i].x, sprites[i].y, //position 
				0, //priority
				sprites[i].paletteAlpha, //palette for 16 color sprite or alpha for bmp sprite
				sprites[i].size, 
				sprites[i].format, 
				sprites[i].gfx, 
				-1, 
				false, //double the size of rotated sprites
				false, //don't hide the sprite
				false, false, //vflip, hflip
				false //apply mosaic
			);

			dmaFillHalfWords(sprites[i].color, sprites[i].gfx, 16*16*2); // fill each as a Red Square
		}

		scanKeys();
		int keys = keysHeld();

		if(keys & KEY_UP) { // add a new square when up key is pressed
			if (sprite_count < 100) {
				int color = ARGB16(1, rand() % 31 + 1, rand() % 31 + 1, rand() % 31 + 1);
				int rand_x = rand() % SCREEN_WIDTH + 1; // get random x location to place square on
				int rand_y = rand() % SCREEN_HEIGHT + 1; // get random y location to place square on
				Sprite tmp = {0, SpriteSize_16x16, SpriteColorFormat_Bmp, color, 15, rand_x, rand_y}; // create a sprite
				sprites[sprite_count + 1] = tmp; // add sprite to our sprites array
				sprite_count++; // increase sprite_count one
			}
		}
		swiWaitForVBlank();
		oamUpdate(&oamSub); //send the updates to the hardware
	}
	//return 0;
}