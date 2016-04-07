/*---------------------------------------------------------------------------------

I first started out here trying to understand OAM, Sprite management and other basic graphic concepts. The End result is two colored squares sperated by screens. It also includes the sprite falling once it's let go to simulate animation.
- John Riselvato

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void createSquare(int xLoc, int yLoc);

//---------------------------------------------------------------------------------
int main(void) {
	//---------------------------------------------------------------------------------
	int i = 0;
	touchPosition touch;

	videoSetMode(MODE_0_2D);
	videoSetModeSub(MODE_0_2D);

	vramSetBankA(VRAM_A_MAIN_SPRITE);
	vramSetBankD(VRAM_D_SUB_SPRITE);

	oamInit(&oamMain, SpriteMapping_1D_32, false); // setting up the top screen
	oamInit(&oamSub, SpriteMapping_1D_32, false); // setting up the bottom screen

	u16* gfx = oamAllocateGfx(&oamMain, SpriteSize_16x16, SpriteColorFormat_256Color);

	for(i = 0; i < 16 * 16 / 2; i++) {
		gfx[i] = 1 | (1 << 8); // oddly enough equal 257 what does it mean?!
		// gfxSub[i] = 1 | (1 << 8);
	}

	SPRITE_PALETTE[1] = RGB15(31,31,0); // square colors
	SPRITE_PALETTE_SUB[1] = RGB15(0,31,0); // square colors

	// Simple gravity constants
	int SCREEN_BOTTOM = 192 - 16;

	while(1) {

		scanKeys();
		int key = keysHeld();

		if(key & KEY_TOUCH)
			touchRead(&touch);

		if(!key) {
			if (touch.py < SCREEN_BOTTOM) {
				touch.py += 1.0;
			}
		}

		oamSet(&oamMain, //main graphics engine context
			0,           //oam index (0 to 127)
			touch.px, touch.py,   //x and y pixle location of the sprite
			0,                    //priority, lower renders last (on top)
			0,					  //this is the palette index if multiple palettes or the alpha value if bmp sprite
			SpriteSize_16x16,
			SpriteColorFormat_256Color,
			gfx,                  //pointer to the loaded graphics
			-1,                  //sprite rotation data
			false,               //double the size when rotating?
			false,			//hide the sprite?
			false, false, //vflip, hflip
			false	//apply mosaic
			);

		createSquare(touch.px, touch.py);

		swiWaitForVBlank();

		oamUpdate(&oamMain);
		oamUpdate(&oamSub);
	}

	return 0;
}

void createSquare(int xLoc, int yLoc) {
	u16* gfxSub = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_256Color);

	for(int i = 0; i < 16 * 16 / 2; i++) {
		gfxSub[i] = 1 | (1 << 8);
	}

	oamSet(&oamSub,
		0,
		xLoc,
		yLoc,
		0,
		0,
		SpriteSize_16x16,
		SpriteColorFormat_256Color,
		gfxSub,
		-1,
		false,
		false,
		false, false,
		false
		);
}