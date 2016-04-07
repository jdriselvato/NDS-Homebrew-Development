/*---------------------------------------------------------------------------------
Generating a multiple sprites

This project demos the ability to dynamically add sprites to the screen.
Pressing the key up adds another sprite to the screen
-- John Riselvato ( March 26th, 2016 )

What I listened to while developing:
- https://www.youtube.com/watch?v=qB4agGGyZFg
- https://www.youtube.com/watch?v=RhOS3OQs3Pg
Animal Crossing New Leaf music is the kind of music I hope is available in the after life.
Every single song is a master peice of child-like innocence. As if everything is going to be
okay, no worries, just a small town, with friends and relaxation. That's why I love the DS/GBA/3DS
so much, it was my buddy growing up. Thanks Nintendo.

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>

/*---------------------------------------------------------------------------------
Things to know:
- OAM is the Object Attributed Memory, it's what manages all the sprites.
- BG_GFX_SUB comes from video.h and is the brief background graphics memory (sub engine)
- SCREEN_BASE_BLOCK_SUB comes from background.h and
	is a macro which returns a u16* pointer to background Map ram (Sub Engine)
---------------------------------------------------------------------------------*/

typedef struct {
	u16* gfx;
	SpriteSize size;
	SpriteColorFormat format;
	int color;
	int rotationIndex;
	int paletteAlpha;
	int x;
	int y;
} Sprite;

int main(int argc, char** argv) {
	Sprite sprites[100] = { // maximum amount of sprites allocated
		{0, SpriteSize_16x16, SpriteColorFormat_Bmp, ARGB16(1, 31, 0, 0), 0, 15, 20, 15},
		{0, SpriteSize_16x16, SpriteColorFormat_Bmp, ARGB16(1, 0, 10, 0), 0, 15, 20, 80},
	};

	int sprite_count = 2; // keep track of how many sprites on are the screen so we can append properly

	videoSetModeSub(MODE_0_2D);
	consoleDemoInit();

	//initialize the sub sprite engine with 1D mapping 128 byte boundary
	//and no external palette support
	oamInit(&oamSub, SpriteMapping_Bmp_1D_128, false);
	vramSetBankD(VRAM_D_SUB_SPRITE);

   int angle = 0;

   while(1) {
		iprintf("\x1b[1;1HNumber of sprites: %d", sprite_count);

		for(int i = 0; i < sprite_count; i++) {
			if (sprites[i].gfx == 0) { // we only need to allocate space the first time the sprite is created
				sprites[i].gfx = oamAllocateGfx(&oamSub, sprites[i].size, sprites[i].format); // allocate some space for the sprite graphics
			}
			dmaFillHalfWords(sprites[i].color, sprites[i].gfx, 16*16*2); // fill each square with correct color
			oamSet(
				&oamSub, //sub display
				i,       //oam entry to set
				sprites[i].x, sprites[i].y, //position
				0, //priority
				sprites[i].paletteAlpha, //palette for 16 color sprite or alpha for bmp sprite
				sprites[i].size,
				sprites[i].format,
				sprites[i].gfx,
				sprites[i].rotationIndex,
				true, //double the size of rotated sprites
				false, //don't hide the sprite
				false, false, //vflip, hflip
				false //apply mosaic
			);
		}
		oamRotateScale(&oamSub, 0, angle, (1 << 8), (1 << 8));
		angle += 45;

	   	scanKeys();
		int keys = keysDown();

		if(keys & KEY_UP) { // add a new square when up key is pressed
			if (sprite_count < 100) {
				int color = ARGB16(1, rand() % 31 + 1, rand() % 31 + 1, rand() % 31 + 1);

				int rand_x = rand() % SCREEN_WIDTH + 1; // get random x location to place square on
				int rand_y = rand() % SCREEN_HEIGHT + 1; // get random y location to place square on
				Sprite tmp = {0, SpriteSize_16x16, SpriteColorFormat_Bmp, color, 0, 15, rand_x, rand_y}; // create a sprite
				sprites[sprite_count + 1] = tmp; // add sprite to our sprites array
				sprite_count++; // increase sprite_count one
			}
		} else if (keys & KEY_DOWN) {
			if (sprite_count > 2) {
				sprite_count--;
			}
		}

		swiWaitForVBlank();

		//send the updates to the hardware
		oamUpdate(&oamSub);
   }
   return 0;
}