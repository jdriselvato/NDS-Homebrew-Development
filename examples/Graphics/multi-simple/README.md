# Generating a multiple sprites

This project demos the ability to dynamically add sprites to the screen.


### Things to know
* OAM is the Object Attributed Memory, it's what manages all the sprites in memory.
* BG_GFX_SUB comes from video.h and is the brief background graphics memory (sub engine)
* oamAllocateGfx should be called only once per sprite

# Understanding the code

The biggest problem I ran into when trying to get this to work was that if the variable `oam entry` in `oamSet()` doesn't have a unique number (`count` in the code)
the random colors assign to each square will retain the first square added. So in the future remember to make oam entry unique.

Also the `oam entry` value should corrolate to the same count number of the square you store in memory like in this example. 
So theoretical `square_1` should have `oam entry` 1 to load it's properties correctly.

### Controls
Pressing the `A Button` adds another sprite to the screen
