# Basic First Game
Everything we've learned from the first few examples has given us enough knowledge to create our first game. We'll be starting off with the `bitmap-sprite-movement` code and expanding it. If you are having a hard time understanding this code I suggest reading the README.md of `bitmap-sprite-movement`.

Specifically, we'll be using what we learned from `bitmap-sprite-movement` and `basic-sprite-collision` to create collection game. So the character will be able to collect coins and a scoreboard will update. It's endless and no real goal but challange yourself to improve it to a full game (maybe like snake?).

### Preview
![collection.gif](./preview/collection.gif)
For some reason the gif creator makes things x2 slower looking. 

### Sprites
[![spritesheet.png](./gfx/spritesheet.png)]
Interestingly enough, the DS has an easier time loading a simple SPRITE_PALLETE. At first I tried generating two different sprite sheets (one for the character and one for the gem) and which ever Pallete was allocated last was used for all sprites. So this made one of the sprites use the others color pallete.

To fix it theres more complicated ways use different palletes and allocated each one in memory but I didn't want to go down that complex rabbit hole. So instead I merged both spritesheets into one, creating `spritesheet.png`. Ideally your game would probably only used one spritesheet anyway so mine as well start doing best practices.

### Parsing a spritesheet

Now with having only one spritesheet we have to know each location of the sprite. For example we know that the gem sprite is the last on the list. So we can easily get it like this:
````
	u8* offset = gem_sprite.gfx_frame + 4 * 16*16;
	dmaCopy(offset, gem_sprite.gfx, 16*16);
````
Where 4 is the frame at which the gem sprite starts. 0-3 is the character frames. This was used in this example in the `generateGem()` function.
