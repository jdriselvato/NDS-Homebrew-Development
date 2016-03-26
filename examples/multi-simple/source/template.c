/*---------------------------------------------------------------------------------

Muliple Sprites Dynamically generated Demo
-- John Riselvato ( March 26th, 2016 )

What I listened to while developing this: https://www.youtube.com/watch?v=qB4agGGyZFg
Animal Crossing New Leaf music is the kind of music I hope is available in the after life. 
Every single song is a master peice of child-like innocence. As if everything is going to be
okay, no worries, just a small town, with friends and relaxation. That's why I love the DS/GBA/3DS
so much, it was my buddy growing up. Thank Nintendo.

---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define NUM_SPRITES 128 // Max number of sprites

/*---------------------------------------------------------------------------------

OAM is the Object Attributed Memory, it's what manages all the sprites. 

---------------------------------------------------------------------------------*/

SpriteEntry OAMCopySub[NUM_SPRITES]; 

//simple sprite struct
typedef struct {
	int x, y;			// screen co-ordinates 
	int dx, dy;			// velocity
	SpriteEntry* oam;	// pointer to the sprite attributes in OAM
	int gfxID; 			// graphics lovation
}Sprite;


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

		swiWaitForVBlank();
		
		oamUpdate(&oamMain);
		oamUpdate(&oamSub);
	}

	return 0;
}