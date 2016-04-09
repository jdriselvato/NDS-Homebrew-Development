# Bitmap Sprite Movement

In this example, we explore how to use grit, parsing bitmap sprite sheets and displaying a sprite based on key pressed. Almost everything you'd need to get started on a top down RPG world (like Pokemon, Final Fantasy, etc.)

### Sprite
Here's the sprite we'll be using. It's simple and generic but if you want to use it in your own game, it's free to use.

/// SPRITE IMAGE HERE

# Grit setup
In this project, we'll be using grit to convert the sprite I've provide into a format the NDS understands. The grit file must be in the same folder as the sprite and named the same. In most case, these files should be place in `gfx` or `data` depending on the MakeFile. In this case we'll use the `gfx` folder.

Below is the grit file for the character16x16.png:
````
-m! # Exclude map from output (default).
-gB8 # Bit depth of the output
#metatile
-Mh2 # Metatile height
-Mw2 # Metatile width
````

The most important command to note here is the `-Mh<n>` and the `-Mw<n>` where `n = 2`. The NDS hardware requires tiles to be 8*8 pixels. Since the sprites we'll use are 16x16 `n` needs to be 2 (`8*2=16`). If your sprite was 32x32, `n = 4`.

Running the `MakeFile` provide will result in the build folder including a `character16x16.h` header file. We'll be using this in our code to reference this sprite sheet now.

NOTE: some MakeFiles might have .bmp defined in it. If you are using `.png` images, change all `.bmp` to `.png` to compile the header files.

# Understanding the Code

### character16x16.h
So if you haven't set up grit yet, do that and run the `MakeFile` to get the sprite header. In the `/build/` folder, `character16x16.h` should exist now. Lets import it in our `template.c`:
````
#include <character16x16.h>
````

