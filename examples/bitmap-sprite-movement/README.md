# Bitmap Sprite Movement

In this example, we explore how to use grit, parsing bitmap sprite sheets and displaying a sprite based on key pressed. Almost everything you'd need to get started on a top down RPG world (like Pokemon, Final Fantasy, etc.)

### Sprite
Here's the sprite we'll be using. It's simple and generic but if you want to use it in your own game, it's free to use.

[![character16x16](./gfx/character16x16.png)]
Simply a 64x16 spritesheet, with 16x16 sprites.

Also, here is a new one I just discovered after adding the background programatically. Aparently the default transparent color for a sprite is black `#000`. This led to seeing the sprite but without the black outline. To fix it we have a new argument, `-gT <color>` where color in this case is `FF00FF`, megenta. So after you create your sprites fill the background with `FF00FF` and compile grit again!

# Grit setup
In this project, we'll be using grit to convert the sprite I've provide into a format the NDS understands. The grit file must be in the same folder as the sprite and named the same. In most case, these files should be place in `gfx` or `data` depending on the MakeFile. In this case we'll use the `gfx` folder.

Below is the grit file for the character16x16.png:
````
-m! # Exclude map from output (default).
-gB8 # Bit depth of the output
-gT FF00FF # Set the transparency color to Magenta

#metatile
-Mh2 # Metatile height
-Mw2 # Metatile width
````

The most important command to note here is the `-Mh<n>` and the `-Mw<n>` where `n = 2`. The NDS hardware requires tiles to be 8*8 pixels. Since the sprites we'll use are 16x16 `n` needs to be 2 (`8*2=16`). If your sprite was 32x32, `n = 4`. [More on metatiles here](https://devkitpro.org/viewtopic.php?f=6&t=621).

Running the `MakeFile` provide will result in the build folder including a `character16x16.h` header file and a `character16x16.s`. We'll be using this in our code to reference this sprite sheet now. It should look pretty much like this:
````
#ifndef GRIT_CHARACTER16X16_H
#define GRIT_CHARACTER16X16_H

#define character16x16TilesLen 1024
extern const unsigned int character16x16Tiles[256];

#define character16x16PalLen 512
extern const unsigned short character16x16Pal[256];

#endif // GRIT_CHARACTER16X16_H
````
NOTE the `character16x16Pal` and `character16x16Tiles` arrays. Those are important, if grit didn't generate those for you ensure that your grit command in the `MakeFile` looks something like this:
````
	grit $< -fts -o$*

````

The header file referances the basic variables that are needed from the `character16x16.s` file. The `character16x16.s` contains information about your png file that the NDS understands. A more advance understanding is coming soon... (as soon as I understand it better).

NOTE: some MakeFiles might have .bmp defined in it. If you are using `.png` images, change all `.bmp` to `.png` to compile the header files.
NOTE: you might need to run `make` twice to get the `.s` file.

# Understanding the Code

### character16x16.h
So if you haven't set up grit yet, do that and run the `MakeFile` to get the sprite header. In the `/build/` folder, `character16x16.h` should exist now. Lets import it in our `template.c`:
````
#include <character16x16.h>
````
Note: grit should additionally create a `character16x16.s` file. This file contains all the information about your spritesheet in a format the NDS can read. It's important that his is generated else we wont have all the data we need to show a sprite.

### Character Struct
It's good to get into the habit of create structs for complex objects like a character. In this example we have a Character Struct with the following properties, It's pretty self explanatory:
````
typedef struct {
	int x, y; // x/y lcoation
	u16* gfx; // oam GFX
	u8* gfx_frame; // the frame on the spritesheet we want
	int state; // sprite walk state
} Character;
````
### SpriteState
````
enum SpriteState { WALK_DOWN = 0, WALK_UP = 1, WALK_LEFT = 2, WALK_RIGHT = 3 }; // states for walking
````
The sprite sheet provided has 4 specific states for walking to portray direction when the arrow keys are pressed. This is be helpful with `gfx_frame` as we get to displaying different sprites

### Setting up the Main Screen (top)
````
	videoSetMode(MODE_0_2D);
	vramSetBankA(VRAM_A_MAIN_SPRITE | VRAM_A_MAIN_BG);
	oamInit(&oamMain, SpriteMapping_1D_128, false);
````
The only things new this time is the fact that `vramSetBankA` has two arguments this time. By default the background of screen once you start adding sprites to it is black. So in order to fully see our sprite I used the code from `tile-generator-top` to simply add a background. `VRAM_A_MAIN_BG` allows us to add that background.


