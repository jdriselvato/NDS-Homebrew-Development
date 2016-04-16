/*---------------------------------------------------------------------------------
Listening to: Małpa. Thanks to connections at my day time job I've had the oppertunity to meet some awesome people in Poland. Specifical this guy Przemek who is really into worldly hip-hop. Every once in a while we go back and forth on whats popular in our country. I've never been a huge fan of anerican rap but I really dig Polish hip-hop. https://www.youtube.com/watch?v=FpNSVRPRLhw

Scrolling background based on backgrounds example from Devkitpro, scrolling.cpp
-- John Riselvato ( March 26th, 2016 )
find me at: @jdriselvato

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>
#include <dinner_room.h>
/*---------------------------------------------------------------------------------
Things to know:
- How VRAM works and the differences between the A-D Banks
---------------------------------------------------------------------------------*/
int main(void) {
	videoSetMode(MODE_5_2D);
	vramSetBankA(VRAM_A_MAIN_BG);

	consoleDemoInit();
	iprintf("\n\n\tShould show tiles\n");

	int bg = bgInit(3, BgType_Bmp16, BgSize_B16_256x256, 0,0);
	dmaCopy(dinner_roomBitmap, bgGetGfxPtr(bg), dinner_roomBitmapLen);
	while(1) {
		swiWaitForVBlank();
	}
	return 0;
}