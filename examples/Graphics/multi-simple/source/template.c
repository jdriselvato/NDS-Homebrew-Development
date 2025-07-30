/*---------------------------------------------------------------------------------
Generating a multiple sprites

This project demos the ability to dynamically add sprites to the screen.
Pressing the key A adds another sprite to the screen
-- John Riselvato ( March 26th, 2016 )
find me at: @jdriselvato

What I listened to while developing:
- https://www.youtube.com/watch?v=qB4agGGyZFg
- https://www.youtube.com/watch?v=RhOS3OQs3Pg
Animal Crossing New Leaf music is the kind of music I hope is available in the after life.
Every single song is a master peice of child-like innocence. As if everything is going to be
okay, no worries, just a small town, with friends and relaxation. That's why I love the DS/GBA/3DS
so much, it was my buddy growing up. Thanks Nintendo.

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

Things to know:
- OAM is the Object Attributed Memory, it's what manages all the sprites in memory.
- BG_GFX_SUB comes from video.h and is the brief background graphics memory (sub engine)
- oamAllocateGfx should be called only once per sprite
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>

typedef struct {
	u16* gfx;
	int color;
	int x, y;
} Sprite;

Sprite sprites[100] = { // maximum amount of sprites allocated 100
	{0, ARGB16(1, 31, 12, 12), 20, 15},
};
int sprite_count = 1; // keep track of how many sprites on are the screen so we can append properly

void createSquare(Sprite tmp_sprite, int count); // sets up oam details
void addNewSquare(); // adds square to memory both gfx and Sprites array

int main(int argc, char** argv) {
	// constants
	int angle = 0;

	// Initialize bottom screen
	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);
	consoleDemoInit(); // this has to be before oamInit else text and sprites don't show on screen
	oamInit(&oamSub, SpriteMapping_Bmp_1D_128, false);

	sprites[0].gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_Bmp);

	while(1) {
		iprintf("\x1b[1;1HNumber of sprites: %d", sprite_count);

		// display sprites
		for(int i = 0; i < sprite_count; i++) {
			createSquare(sprites[i], i);
		}

		// react to key A and add new square
		scanKeys();
		if(keysHeld() & KEY_A && sprite_count < 100)
			addNewSquare();

		// rotate squares
		oamRotateScale(&oamSub, 0, angle, (1 << 8), (1 << 8));
		angle += 90;

		swiWaitForVBlank(); // draw updates
		oamUpdate(&oamSub); //send the updates to the hardware
	}
	return 0;
}

// adds new square to memory
void addNewSquare() {
	int color = ARGB16(1, rand() % 31 + 1, rand() % 31 + 1, rand() % 31 + 1);
	int rand_x = rand() % SCREEN_WIDTH + 1; // get random x location to place square on
	int rand_y = rand() % SCREEN_HEIGHT + 1; // get random y location to place square on

	Sprite tmp = {0, color, rand_x, rand_y}; // create a sprite
	tmp.gfx = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_Bmp);

	sprites[sprite_count] = tmp; // add sprite to our sprites array
	sprite_count++; // increase sprite_count one
}

// createSquare is a function that easily allows us to add a sprite on the screen with various properties.
void createSquare(Sprite tmp_sprite, int count) {
	dmaFillHalfWords(tmp_sprite.color, tmp_sprite.gfx, 16*16*2); // fill each square with correct color

	oamSet(
		&oamSub, // sub display
		count, // oam entry to set
		tmp_sprite.x, tmp_sprite.y, //position
		0, // priority
		15, // palette for 16 color sprite or alpha for bmp sprite
		SpriteSize_16x16,
		SpriteColorFormat_Bmp,
		tmp_sprite.gfx,
		0, // rotation
		true, // double the size of rotated sprites
		false, // don't hide the sprite
		false, false, // vflip, hflip
		false // apply mosaic
	);
}