#include <spritesheet.h>

typedef struct {
	int x, y, state; // x/y lcoation and sprite walk state
	u16* gfx; // oam GFX
	u8* gfx_frame;
} Character;

enum SpriteState { WALK_DOWN = 0, WALK_UP = 1, WALK_LEFT = 2, WALK_RIGHT = 3 }; // states for walking

Character addNewUnit();
void characterMovement(Character * character);