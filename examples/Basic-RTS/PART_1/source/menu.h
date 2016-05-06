typedef struct {
	int x, y; // location on screen
	u16* gfx;
	u8* gfx_frame;
	bool shouldDisplay;
} Menu;

Menu initMenu();
void displayMenu();