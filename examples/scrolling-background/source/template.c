/*---------------------------------------------------------------------------------
Scrolling background based on backgrounds example from Devkitpro, scrolling.cpp
-- John Riselvato ( March 26th, 2016 )
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
/*---------------------------------------------------------------------------------
Things to know:

---------------------------------------------------------------------------------*/
typedef struct {
	u16* gfx;
	SpriteSize size;
	SpriteColorFormat format;
	int color;
	int paletteAlpha;
	int x;
	int y;
} Sprite;

int main(int argc, char** argv) {
}