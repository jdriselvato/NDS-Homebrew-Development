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
	int x, y;

//set the mode to allow for an extended rotation background
videoSetMode(MODE_5_2D);
videoSetModeSub(MODE_5_2D);

//allocate a vram bank for each display
vramSetBankA(VRAM_A_MAIN_BG);
vramSetBankC(VRAM_C_SUB_BG);

//create a background on each display
int bgMain = bgInit(3, BgType_Bmp16, BgSize_B16_256x256, 0,0);
int bgSub = bgInitSub(3, BgType_Bmp16, BgSize_B16_256x256, 0,0);

u16* videoMemoryMain = bgGetGfxPtr(bgMain);
u16* videoMemorySub = bgGetGfxPtr(bgSub);


//initialize it with a color
for(x = 0; x < 256; x++)
    for(y = 0; y < 256; y++)
    {
        videoMemoryMain[x + y * 256] = ARGB16(1, rand() % 31 + 1, rand() % 31 + 1, rand() % 31 + 1);
        videoMemorySub[x + y * 256] = ARGB16(1, 0, 0, 31);
    }

while(1) 
{
    swiWaitForVBlank();
}
}