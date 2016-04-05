/*---------------------------------------------------------------------------------
This source code explores the understanding of Sprite Collision detection. Obviously one of the more important parts of developing a game is allowing a reaction based on two sprites touching. In this example, we'll have a center object (wall) that will prevent the sprite from entering it's boundries.
-- John Riselvato (April 4th, 2016)
---------------------------------------------------------------------------------*/

#include <nds.h>
/*---------------------------------------------------------------------------------
What's new?
- First time we've messed with the bottom screen touch!
- Collision. I've adapted the examples from this posting  (from 1999 actually) which has beena great resource:http://www.gamedev.net/page/resources/_/technical/game-programming/collision-detection-r735
---------------------------------------------------------------------------------*/
typedef struct {
	u16* gfx;
	SpriteSize size;
	int color;
	int x, y; // location on screen
} Sprite;

touchPosition touch;

Sprite mainSprite = {0, SpriteSize_16x16, ARGB16(1, 31, 0, 0), 31, 31};
Sprite wallSprite = {0, SpriteSize_32x32, ARGB16(1, 31, 0, 21), 256/2 - 32, 192/2 - 32`};

bool collision();

int main(void) {
	mainSprite.gfx = oamAllocateGfx(&oamSub, mainSprite.size, SpriteColorFormat_Bmp);
	wallSprite.gfx = oamAllocateGfx(&oamSub, wallSprite.size, SpriteColorFormat_Bmp);

	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);
	oamInit(&oamSub, SpriteMapping_Bmp_1D_128, false);

	int xLoc = mainSprite.x;
	int yLoc = mainSprite.y;

	while(1) {
		scanKeys();
		if(keysHeld() & KEY_TOUCH) {
			touchRead(&touch);
			if (!collision()) {
				xLoc = touch.px - 16;
				yLoc = touch.py - 16;
			}
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

		dmaFillHalfWords(wallSprite.color, wallSprite.gfx, 32*32*2);
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

bool collision() {
	int left1, left2;
	int right1, right2;
	int top1, top2;
	int bottom1, bottom2;

	left1 = object1->x;
	left2 = object2->x;
	right1 = object1->x + object1->width;
	right2 = object2->x + object2->width;
	top1 = object1->y;
	top2 = object2->y;
	bottom1 = object1->y + object1->height;
	bottom2 = object2->y + object2->height;

	if (bottom1 < top2) return(0);
	if (top1 > bottom2) return(0);

	if (right1 < left2) return(0);
	if (left1 > right2) return(0);
	return false;
}