typedef struct {
	int x, y;
	u16* gfx;
	u8* gfx_frame;
} House;

House initHouse();
void generateHouse(House * House_sprite);
bool hideHouseMenu(touchPosition touch, House * house);