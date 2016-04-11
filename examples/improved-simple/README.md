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
This is a pretty simple set up for the top and bottom screen. In this case we need to set up the `videoSetMode()`, `vramSetBankA()` and `oamInit()`.

The `videoSetMode()` sets up the 2D processors for each engine. In both cases we are interested in `MODE_0_2D` because it's the most simplistic and gives us 4 2D backgounds. In this case we are not using any of the `BG` but without this we wouldn't see anything on the respective screen.

The `vramSetBankA()` is the VRAM we'll be using for the top and `vramSetBankD()` for the bottom screen. VRAM is the Video Ram Bank, which the NDS has 9 of. This is what holds the graphics for the sprites, textures for 3D objects and tiles on 2D maps. Since we are programming to show sprites on the screen we'll be using `VRAM_A_MAIN_SPRITE` & `VRAM_D_SUB_SPRITE` respectively.
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
After we set up the video mode and vrams we can now initialize the 2D sprite engine. We do this with `oamInit()`. `oamInit(OamState *oam, SpriteMapping mapping, bool extPalette)` comes with three variables. OamState holds the state for the 2D sprite engine. For the top screen it's `oamMain` and the bottom `oamSub`. Both of these objects are important as it'll help us distiguish were sprites should go on the hardware (top or bottom).

### While loop
The while loop might be one of the most important part of your game. Without it the game will load and then close it self. A cheap and quick way to ensure that your while look runs forever (like a game should) is like we have in this example, `while(1) {}`. Good news is you don't have to be limited to one while loop so you could have boolean variable in the while which when it is satisfied, another while loop cna run. For now we'll stick with this easy loop.

### Scanning for Keys
What would a game be without user interaction. On the NDS there's actually two different ways the user can interact with your game, buttons and touch screen. In this examples we'll go straight to what make the NDS so unique, the touch.
````
		scanKeys();
		int key = keysHeld();
		if(key & KEY_TOUCH) touchRead(&touch); // set touch variable
````
To initial the game looking for touch, we need to ensure the touch code is in the while loop. We can do this with `scanKeys()` after which `keysHeld()` is available to call and that returns the current button pressed (Keys = buttons and touch). To check what `key` actually is we do a bitwise AND (&) to the [KEYPAD_BIT](http://libnds.devkitpro.org/input_8h.html#aa27cad8fa018a58930b6622783a83072) predefined by DevKitPro's input. If the `key` and the `KEYPAD_BITS` (AKA KEY_TOUCH) return true after bitwise AND then the if statment is true and does whatever the code tells it to do. In this example `if (key & KEY_TOUCH)` is true then call the `touchRead(&touch)` function.

What `touchRead(&touch)` does is grabs the current touch state, specifically the `x` and `y` location of the touch stylus and assigns that information to the variable `&touch`. `touch` in this example is the [`touchPosition`](http://libnds.devkitpro.org/structtouchPosition.html) and allows us to call `touch.px` or `touch.py` to get the stylus location on screen.

### using touchPosition to create a Square
In the section `Scanning for Keys` I explained how we get touchPosition, now lets explore how to use it.

