THIS IS A WORKING DOCUMENT. NOT COMPLETED~

# Improved Simple

DevkitPro for the NDS comes with a nice collection of Graphics examples. One specifically under /Sprites/ is an example called `Simple`. I felt that for a simple project it wasn't very noob friendly. So I created an Improved Simple example, one that's straight forward and easy to understand.

What makes this stand out is the fact that we have two squares on the screen with ARGB() values to set the color. Using bitwise shifting and memory allocation was not easy to understanding without any prior low level experience. Thus, this one tries using the higher level calls that devkitpro provides.

This article will go over the basic concepts of simple example in depth.

#Understanding the Code

First off, ever NDS program you write will 99% of the time include `#include <nds.h>`. This header file incases everything you'll need from DevKitPro. So include it!

### Functions
This example will only have two functions; `main()` and `createSquare()`. If this is your first experience with C programming, `main()` is the core function that ever c program has, it's what initiates the rest of the functionality of the program. Then `createSquare()` is what will use to dynamically create our squares. We'll go over the variables in the future.

### Allocating Graphics
The first actions we do in `main()` is allocate the GFX (graphics) in the OAM (Object Attributed Memory):
````
	u16* mainGFX = oamAllocateGfx(&oamMain, SpriteSize_16x16, SpriteColorFormat_Bmp);
	u16* subGFX = oamAllocateGfx(&oamSub, SpriteSize_16x16, SpriteColorFormat_Bmp);
````
OAM is just a fancy way of saying an object attributes in memory. `oamAllocateGfx()` allows us to set gfx attributes for sprites for the specific screen; `&oamMain` being the top and `&oamSub` for the bottom.

`SpriteSize_16x16` is an enum that allows us to call shorthand Sprite Size of 16x16. [Here's a full list of SpriteSizes](http://libnds.devkitpro.org/sprite_8h.html#a1b3e231e628b18808e49a2f94c96b1ea). In this case we'll be making two 16 x 16 pixel sprites.

`SpriteColorFormat_Bmp` is an enum value for the Sprites Color format. `SpriteColorFormat_Bmp` specifically is used because it allows us to set in memory ARGB() values, which colors the sprite. More on that soon. Again, here's a full list of [Sprite Color Formats](http://libnds.devkitpro.org/sprite_8h.html#ada800fd4d653d0a31be9cce4e58c02b3)

`oamAllocateGfx` returns a `u16*` which the address in vram of the allocated sprite. We'll want to keep this around so we can apply more attributes to it in the future (like coloring).

### Setting up the screens

#### Top Screen
````
	videoSetMode(MODE_0_2D);
	vramSetBankA(VRAM_A_MAIN_SPRITE);
	oamInit(&oamMain, SpriteMapping_1D_32, false);
````
#### Bottom Screen
````
	videoSetModeSub(MODE_0_2D);
	vramSetBankD(VRAM_D_SUB_SPRITE);
	oamInit(&oamSub, SpriteMapping_1D_32, false);
````