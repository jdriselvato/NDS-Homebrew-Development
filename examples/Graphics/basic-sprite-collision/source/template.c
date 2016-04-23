/*---------------------------------------------------------------------------------
This source code explores the understanding of Sprite Collision detection. Obviously one of the more important parts of developing a game is allowing a reaction based on two sprites touching. In this example, we'll have a center object (wall) that will prevent the sprite from entering it's boundries.
-- John Riselvato (April 4th, 2016)
find me at: @jdriselvato

What's new?
- First time we've messed with the bottom screen touch!
- Collision. Checkout these resources for more details:
	- http://www.gamedev.net/page/resources/_/technical/game-programming/collision-detection-r735
	- http://buildnewgames.com/gamephysics/

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>

typedef struct {
	u16* gfx;
	SpriteSize size;
	int x, y; // location on screen
} Sprite;

touchPosition touch;

Sprite mainSprite = {0, SpriteSize_16x16, 8, 8};
Sprite wallSprite = {0, SpriteSize_32x32, 256/2 - 32, 192/2 - 32};

bool collision();

int main(void) {
	mainSprite.gfx = oamAllocateGfx(&oamSub, mainSprite.size, SpriteColorFormat_Bmp);
	wallSprite.gfx = oamAllocateGfx(&oamSub, wallSprite.size, SpriteColorFormat_Bmp);

	videoSetModeSub(MODE_0_2D);

	consoleDemoInit();

	vramSetBankD(VRAM_D_SUB_SPRITE);
	oamInit(&oamSub, SpriteMapping_Bmp_1D_128, false);

	while(1) {

		scanKeys();
		if(keysHeld() & KEY_TOUCH) {
			touchRead(&touch);
			mainSprite.x = touch.px - 16; //16 to center the square to the pen
			mainSprite.y = touch.py - 16; //16 to center the square to the pen
		}

		// Arrow Key movement
		if (keysHeld() & KEY_UP) {
			mainSprite.y--;
		} else if (keysHeld() & KEY_DOWN) {
			mainSprite.y++;
		} else if (keysHeld() & KEY_LEFT) {
			mainSprite.x--;
		} else if (keysHeld() & KEY_RIGHT) {
			mainSprite.x++;
		}

		u16 color = !collision() ? ARGB16(1, 31, 0, 31) : ARGB16(1, 31, 31, 0); // the color of the squares

		iprintf("\x1b[1;1HWall{%d, %d}\n Main{%d, %d}", wallSprite.x, wallSprite.y, mainSprite.x, mainSprite.y);

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
		consoleClear();
	}
	return 0;
}

bool collision() {
	// not sure yet why these are 8 and 40...
	int mainWidth = 8;
	int mainHeight = 8;
	int wallWidth = 40;
	int wallHeight = 40;

	int mainLeft = mainSprite.x;
	int wallLeft = wallSprite.x;
	int mainRight = mainSprite.x + mainWidth;
	int wallRight = wallSprite.x + wallWidth;
	int mainTop = mainSprite.y;
	int wallTop = wallSprite.y;
	int mainBottom = mainSprite.y + mainHeight;
	int wallBottom = wallSprite.y + wallHeight;

	if (mainLeft < wallRight && // left main will detect right wall
		mainRight > wallLeft && // right main will detect left wall
		mainTop < wallBottom && // top main will detect wall bottom
		mainBottom > wallTop) { // bottom main will detect wall top
    	return true;
	}
	return false;
}