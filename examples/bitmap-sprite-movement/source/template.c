/*---------------------------------------------------------------------------------
bitmap-sprite-movement
It's about time we actual use images we'd use in a video game, bitmap sprites. I've provided a sprite sheet that's free to use for any of your personal projects. We'll use this sprite sheet to move the character around the top screen and use different angles to show movement. Example, moving right shows the character looking right.
-- John Riselvato ( April 7th, 2016 )

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

Things to know:
- How to convert a png sprite sheet with grit to a header file
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <character16x16.h>

typedef struct {
	u16* gfx;
	int x, y;
} Sprite;

int main(int argc, char** argv) {
	while(1) {
		swiWaitForVBlank();
	}
	return 0;
}