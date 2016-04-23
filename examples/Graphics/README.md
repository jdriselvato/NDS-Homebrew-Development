# Graphic
Here you will learn the basics of graphics for DevKitPro. Below are the examples developed so far. Most examples will have it's own README.md with detailed tutorial information so you can learn from the questions I've asked as I've learned DevKitPro.

#### *1. improved-simple* (Novice)
This gives an excellent example of sprite management and other basic graphic concepts. The End result is two colored squares sperated by screens. It also includes the sprite falling once it's let go to simulate animation.

#### *2. multi-simple* (Novice)
This project demos the ability to dynamically add sprites to the screen and simple rotation animation. Pressing the `A Key` adds another sprite to the screen. This is also a good example to see how to apply different colors to the same sprite object.

#### *3. tile-generator* (Novice)
We take what we've learned from `multi-simple` and instead of randomly placing sprites down, we follow an array. Just like you would in a tile based game. This generates a simple 6 x 8 tiled map of 16x16 sized sprites. We used the VRAM Bank D which is specific to the bottom screen and Sprites.

#### *4. tile-generator-top* (Novice)
In `tile-generator` we built the tile map on the bottom screen in this example, we do the same on the top screen using VRAM Bank A.

#### *5. scrolling-background* (Novice) incomplete
Since I found out about the 128 sprite limit, I needed to figure out a better way to display backgrounds. I'm guessing some where I'm missing a critical peice, probably the understanding of VRAM. So because devkitpro does come with a couple of background examples. This has turned out more complex then I thought. I'll come back to this.

#### *6. basic-user-menu* (Novice)
Here we will explore how to make a simple user menu with various fields and allow the user to select items and go to new screens.

#### *7. basic-sprite-collision* (Novice)
This source code explores the understanding of Sprite Collision detection. Obviously one of the more important parts of developing a game is allowing a reaction based on two sprites touching. In this example, we'll have a center object (wall) that will notify the user it's entering boundries.
This is considered basic and does not contain any physics or any dynamic hit detection.

#### *8. bitmap-sprite-movement* (Novice)
It's about time we actual use images we'd use in a video game, bitmap sprites. I've provided a sprite sheet that's free to use for any of your personal projects. We'll use this sprite sheet to move the character around the top screen and use different angles to show movement. Example, moving right shows the character looking right.

#### *9. basic-first-game* (Moderate)
Everything we've learned from the first few examples has given us enough knowledge to create our first game. We'll be starting off with the `bitmap-sprite-movement` code and expanding it. Specifically, we'll be using what we learned from `bitmap-sprite-movement` and `basic-sprite-collision` to create collection game. So the character will be able to collect coins and a scoreboard will update. It's endless and no real goal but challange yourself to improve it into a full game (maybe like snake?).