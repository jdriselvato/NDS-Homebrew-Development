/*---------------------------------------------------------------------------------
bitmap-sprite-movement
It's about time we actual use images we'd use in a video game, bitmap sprites. I've provided a sprite sheet that's free to use for any of your personal projects. We'll use this sprite sheet to move the character around the top screen and use different angles to show movement. Example, moving right shows the character looking right.

-- John Riselvato ( April 7th, 2016 )
---------------------------------------------------------------------------------*/
#include <nds.h>
/*---------------------------------------------------------------------------------
Things to know:
---------------------------------------------------------------------------------*/

typedef struct {
	u16* gfx;
	int x;
	int y;
} Sprite;

int main(int argc, char** argv) {
	while(1) {
		swiWaitForVBlank();
	}
	return 0;
}