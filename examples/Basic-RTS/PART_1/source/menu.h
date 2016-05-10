typedef struct {
	int x, y; // location on screen
	u16* gfx[5];
	u8* gfx_frame[5];
	bool shouldDisplay;
} Menu;

Menu initMenu();
void displayMenu(Menu * menu, bool hideMenu);