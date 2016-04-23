/*---------------------------------------------------------------------------------
Generating a basic tile generator from array

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

-- John Riselvato ( March 26th, 2016 )
find me at: @jdriselvato

Things to know:
- NDS only supports 128 sprites on screen unfortunately, so 12 x 16 tiles wont work at 16x16 sprites.
---------------------------------------------------------------------------------*/
#include <nds.h>

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
	videoSetMode(MODE_0_2D);
	oamInit(&oamMain, SpriteMapping_Bmp_1D_128, false); //initialize the sub sprite engine with 1D mapping 128 byte boundary
	vramSetBankA(VRAM_A_MAIN_BG);

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
	int sprite_width = 32;
	int sprite_height = 32;

	while(1) {
		int count = 0;
		for(int x = 0; x < 6; x++) {
			for (int y = 0; y < 8; y++) {
				count++;
				int tile = tile_array[x][y]; // select the color for selected tile
				Sprite tmp = { 0, SpriteSize_32x32, SpriteColorFormat_Bmp, tile_colors[tile], 15, y * sprite_width, x * sprite_height };

				if (gfx_array[count] == 0) { // you can only allocate once
					gfx_array[count] = oamAllocateGfx(&oamMain, tmp.size, tmp.format); // allocate some space for the sprite graphics
				}

				dmaFillHalfWords(tmp.color, gfx_array[count], sprite_width*sprite_height*2); // fill each as a Red Square

				oamSet(
					&oamMain, //main display
					count, //oam entry to set
					tmp.x, tmp.y, //position
					0, //priority
					tmp.paletteAlpha, //palette for 16 color sprite or alpha for bmp sprite
					tmp.size, tmp.format, gfx_array[count], -1,
					false, //double the size of rotated sprites
					false, //don't hide the sprite
					false, false, //vflip, hflip
					false //apply mosaic
				);
			}
		}

		swiWaitForVBlank();
		oamUpdate(&oamMain); // send the updates to the hardware
	}
	//return 0;
}