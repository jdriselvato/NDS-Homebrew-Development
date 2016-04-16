/*---------------------------------------------------------------------------------
I first started out here trying to understand OAM, Sprite management and other basic graphic concepts. The End result is two colored squares sperated by screens. It also includes the sprite falling once it's let go to simulate animation.

What I listened to while refactoring this: https://www.youtube.com/watch?v=ob_nQpBFpL0
- John Riselvato
find me at: @jdriselvato

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015
---------------------------------------------------------------------------------*/
#include <nds.h>

touchPosition touch; // used to move square
void createSquare(int xLoc, int yLoc, OamState* screen, u16* gfx, u16 color);

int main(void) {
	u16* mainGFX = oamAllocateGfx(&oamMain, SpriteSize_16x16, SpriteColorFormat_Bmp);
	u16* subGFX = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_Bmp);

	// Set up the top screen
	videoSetMode(MODE_0_2D);
	vramSetBankA(VRAM_A_MAIN_SPRITE);
	oamInit(&oamMain, SpriteMapping_1D_32, false);

	// set up the bottom screen
	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);
	oamInit(&oamSub, SpriteMapping_1D_32, false);

	int SCREEN_BOTTOM = 192 - 16;

	while(1) {
		// scan for touch
		scanKeys();
		int key = keysHeld();

		// react to touch
		if(key & KEY_TOUCH) touchRead(&touch); // set touch variable
		if(!key && touch.py < SCREEN_BOTTOM) touch.py += 1.0; // let the square fall but not go off the screen

		// draw based on touch
		createSquare(touch.px, touch.py, &oamMain, mainGFX, ARGB16(1, 31, 12, 12));
		createSquare(touch.px, touch.py, &oamSub, subGFX, ARGB16(1, 12, 31, 12));

		// draw screen
		swiWaitForVBlank(); // prints the screen
		// update oam
		oamUpdate(&oamSub); // (sub) updates the oam before so VBlank can update the graphics on screen
		oamUpdate(&oamMain); // (sub) updates the oam before so VBlank can update the graphics on screen
	}
	return 0;
}

// createSquare is a function that easily allows us to add a sprite on the screen with various properties.
void createSquare(int xLoc, int yLoc, OamState* screen, u16* gfx, u16 color) {
	dmaFillHalfWords(color, gfx, 16*16*2); // this is how to assign the color fill to the oam gfx
	oamSet(screen, // which display
		1, // the oam entry to set
		xLoc, yLoc, // x & y location
		0, // priority
		15, // palette for 16 color sprite or alpha for bmp sprite
		SpriteSize_16x16, // size
		SpriteColorFormat_Bmp, // color type
		gfx, // the oam gfx
		0, //affine index
		true, //double the size of rotated sprites
		false, //don't hide the sprite
		false, false, //vflip, hflip
		false //apply mosaic
		);
}