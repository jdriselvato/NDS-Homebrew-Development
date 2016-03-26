/*---------------------------------------------------------------------------------

Generating a background 
(original multiple sprites but background seems like the better place to start learning before sprites)
-- John Riselvato ( March 26th, 2016 )

What I listened to while developing this: https://www.youtube.com/watch?v=qB4agGGyZFg
Animal Crossing New Leaf music is the kind of music I hope is available in the after life. 
Every single song is a master peice of child-like innocence. As if everything is going to be
okay, no worries, just a small town, with friends and relaxation. That's why I love the DS/GBA/3DS
so much, it was my buddy growing up. Thanks Nintendo.

---------------------------------------------------------------------------------*/
#include <nds.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/*---------------------------------------------------------------------------------
Things to know:
- OAM is the Object Attributed Memory, it's what manages all the sprites. 
- BG_GFX_SUB comes from video.h and is the brief background graphics memory (sub engine)
- SCREEN_BASE_BLOCK_SUB comes from background.h and 
	is a macro which returns a u16* pointer to background Map ram (Sub Engine)
- 
---------------------------------------------------------------------------------*/

//---------------------------------------------------------------------------------
int main(void) {
//---------------------------------------------------------------------------------

	int i, delta = 0;
	int ix = 0;
	int iy = 0;
	
    /*---------------------------------------------------------------------------------
		These maps are used to write to the map bottom screen sprites.
		SCREEN_BASE_BLOCK_SUB is apparently the location at which the memory is mapped to, specifically screen memory
		(http://greatflash.co.uk/index.php?topic=67.5;wap2).
	*/
	uint16* map0 = (uint16*)SCREEN_BASE_BLOCK_SUB(1); // why is this 1?
	uint16* map1 = (uint16*)SCREEN_BASE_BLOCK_SUB(2); // why is this 2?
	//---------------------------------------------------------------------------------

	//set main display to render directly from the frame buffer
	videoSetMode(MODE_FB1);
	
	//set up the sub display
	videoSetModeSub(MODE_0_2D |  
					DISPLAY_BG0_ACTIVE |
					DISPLAY_BG1_ACTIVE );
	
	//vram banks are somewhat complex
	vramSetPrimaryBanks(VRAM_A_LCD, VRAM_B_LCD, VRAM_C_SUB_BG, VRAM_D_SUB_SPRITE);	

	// Used to create the bottom screen
	REG_BG0CNT_SUB = BG_COLOR_256 | (0 << MAP_BASE_SHIFT);
	REG_BG1CNT_SUB = BG_COLOR_256 | (1 << MAP_BASE_SHIFT);
	// REG_BG1CNT_SUB = BG_COLOR_256 | (2 << MAP_BASE_SHIFT);

	// colors for the bottom screen
	BG_PALETTE_SUB[0] = RGB15(10,0,31); // blue color
	BG_PALETTE_SUB[1] = RGB15(31,31,0); // yellow color
	// BG_PALETTE_SUB[2] = RGB15(31,15,0); // orange color
	
	//load the maps with alternating tiles (0,1 for bg0 and 0,2 for bg1)
	// this is used to create the bottom pattern
	for(iy = 0; iy < 32; iy++) {
		for(ix = 0; ix < 32; ix++) {
			map0[iy * 32 + ix] = (ix ^ iy) & 1;
			map1[iy * 32 + ix] = ((ix ^ iy) & 1) <<1;
		}
	}    

	//fill 2 tiles with different colors (bottom screen)
	for(i = 0; i < 64 / 2; i++) {
		BG_GFX_SUB[i+32] = 0x0101;
		BG_GFX_SUB[i+32+32] = 0x0202;
	}	

	while (1) {
		swiWaitForVBlank();
	}    
	return 0;
}