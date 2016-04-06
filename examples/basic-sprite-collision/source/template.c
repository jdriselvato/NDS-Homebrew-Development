/*---------------------------------------------------------------------------------
This source code explores the understanding of Sprite Collision detection. Obviously one of the more important parts of developing a game is allowing a reaction based on two sprites touching. In this example, we'll have a center object (wall) that will prevent the sprite from entering it's boundries.
-- John Riselvato (April 4th, 2016)
---------------------------------------------------------------------------------*/

#include <nds.h>
#include <stdio.h>

/*---------------------------------------------------------------------------------
What's new?
- First time we've messed with the bottom screen touch!
- Collision. Checkout these resources for more details:
	- http://www.gamedev.net/page/resources/_/technical/game-programming/collision-detection-r735
	- http://buildnewgames.com/gamephysics/
---------------------------------------------------------------------------------*/
typedef struct {
	u16* gfx;
	SpriteSize size;
	int x, y; // location on screen
} Sprite;

touchPosition touch;

Sprite mainSprite = {0, SpriteSize_16x16, 31, 31};
Sprite wallSprite = {0, SpriteSize_32x32, 256/2 - 32, 192/2 - 32};

bool collision();

int main(void) {
	mainSprite.gfx = oamAllocateGfx(&oamSub, mainSprite.size, SpriteColorFormat_Bmp);
	wallSprite.gfx = oamAllocateGfx(&oamSub, wallSprite.size, SpriteColorFormat_Bmp);

	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);
	oamInit(&oamSub, SpriteMapping_Bmp_1D_128, false);

	u16 color = ARGB16(1, 31, 0, 31);

	while(1) {
		scanKeys();
		if(keysHeld() & KEY_TOUCH) {
			touchRead(&touch);
			if (!collision()) {
				color = ARGB16(1, 31, 0, 31);
			} else {
				color = ARGB16(1, 31, 31, 0);
			}
			mainSprite.x = touch.px - 16;
			mainSprite.y = touch.py - 16;
		}

		dmaFillHalfWords(color, mainSprite.gfx, 16*16*2);
		oamSet(
			&oamSub, //sub display
			0,       //oam entry to set
			mainSprite.x, mainSprite.y,
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

		dmaFillHalfWords(color, wallSprite.gfx, 32*32*2);
		oamSet(
			&oamSub, //sub display
			1,       //oam entry to set
			wallSprite.x, wallSprite.y,
			0, //priority
			15, //palette for 16 color sprite or alpha for bmp sprite
			wallSprite.size,
			SpriteColorFormat_Bmp,
			wallSprite.gfx,
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

bool collision() { // not working yes
	int mainLeft = mainSprite.x;
	int wallLeft = wallSprite.x;
	int mainRight = mainSprite.x + 16; // 16 because its a 16x16 square
	int wallRight = wallSprite.x + 32; //32x32 square
	int mainTop = mainSprite.y;
	int wallTop = wallSprite.y;
	int mainBottom = mainSprite.y + 16;
	int wallBottom = wallSprite.y + 32;

	if (mainLeft < wallRight &&
		mainRight > wallLeft &&
		mainTop < wallBottom &&
		mainBottom > wallTop) {
    	return true;
	}
	return false;
}