/*---------------------------------------------------------------------------------
Generating The Matrix.

This project fakes that iconic matrix text effect. Really more of a gag but I needed something else to work on since the RTS project is giving me issues.

-- John Riselvato ( May 23rd, 2016 )
find me at: @jdriselvato

What I listened to while developing:
- Portugal. The Man - The Satanic Satanist - Full Album

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

Things to know:
- That this really just for fun as this really doesn't teach much
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>

int main(int argc, char** argv) {
	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);
	consoleDemoInit();

	while(1) {
		int x = 0;
		iprintf("\x1b[1;1H%d", x);
		swiWaitForVBlank(); // draw updates
		oamUpdate(&oamSub); //send the updates to the hardware
	}
	return 0;
}