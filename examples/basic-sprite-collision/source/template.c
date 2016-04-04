/*---------------------------------------------------------------------------------
This source code explores the understanding of Sprite Collision detection. Obviously one of the more important parts of developing a game is allowing a reaction based on two sprites touching. In this example, we'll have a center object (wall) that will prevent the sprite from entering it's boundries.
-- John Riselvato (April 4th, 2016)
---------------------------------------------------------------------------------*/

#include <nds.h>

/*---------------------------------------------------------------------------------
What's new?
- First time we've messed with the bottom screen touch!
---------------------------------------------------------------------------------*/

typedef struct {
	u16* gfx;
	SpriteSize size;
	int color;
	int x;
	int y;
} Sprite;

touchPosition touch;
Sprite wallSprite;

int main(void) {
	Sprite mainSprite = {0, SpriteSize_16x16, ARGB16(1, 31, 0, 0), 31, 31};
	mainSprite.gfx = oamAllocateGfx(&oamSub, mainSprite.size, SpriteColorFormat_Bmp);

	videoSetModeSub(MODE_0_2D);

	oamInit(&oamSub, SpriteMapping_Bmp_1D_128, false);
	vramSetBankD(VRAM_D_SUB_SPRITE);

	// get the main sprites location
	int xLoc = mainSprite.x;
	int yLoc = mainSprite.y;

	while(1) {
		scanKeys();
		if(keysHeld() & KEY_TOUCH) {
			touchRead(&touch);
			xLoc = touch.px - 16;
			yLoc = touch.py - 16;
		}

		dmaFillHalfWords(mainSprite.color, mainSprite.gfx, 16*16*2);
		oamSet(
			&oamSub, //sub display
			0,       //oam entry to set
			xLoc, yLoc,
			0, //priority
			15, //palette for 16 color sprite or alpha for bmp sprite
			mainSprite.size,
			SpriteColorFormat_Bmp,
			mainSprite.gfx,
			0,
			true, //double the size of rotated sprites
			false, //don't hide the sprite
			false, false, //vflip, hflip
			false //apply mosaic
		);
		swiWaitForVBlank();
		oamUpdate(&oamSub);
	}
	return 0;
}