# NDS Homebew Development
Welcome to NDS [Homebrew](https://en.wikipedia.org/wiki/Nintendo_DS_homebrew) Development!

The Nintendo DS has a special place in my heart and I thought it was about time to started developing on it. You'll find resources, examples and more as I learn how to program on the NDS.

This repo is designed to provide an easier understanding of how to develop on the NDS with devkitpro (C & C++). The examples that come with devkitpro are excellent but in some cases are very one off. Here you'll find examples that are specific to game development. I'll also include as much commented as I see and provide resources to further the understanding of the topic.

Come join us at [/r/NDSHacks](https://www.reddit.com/r/NDSHacks/) to learn more about NDS Homebrew.

# Repo Examples
#### *10. Ray Casting* (Advance) :octocat: Dev-ing :octocat:
Something I've always found interested was the idea of Ray Casting. I think the first time I saw it was in GISH. Until today, I thought it might be one of those impossible tasks to understand, I'm not so much of a Math guy. In any case, I found an awesome resource on how to do it: http://ncase.me/sight-and-light/
I'm going to try porting the majority of the Sight and Light examples. Fortunately for us, Ncase released all the source code (HTML/JS) on [github](https://github.com/ncase/sight-and-light). I'm going to try making this as easy as possible to understand, including the equations

#### *9. basic-first-game* (Moderate)
Everything we've learned from the first few examples has given us enough knowledge to create our first game. We'll be starting off with the `bitmap-sprite-movement` code and expanding it. Specifically, we'll be using what we learned from `bitmap-sprite-movement` and `basic-sprite-collision` to create collection game. So the character will be able to collect coins and a scoreboard will update. It's endless and no real goal but challange yourself to improve it into a full game (maybe like snake?).

#### *8. bitmap-sprite-movement* (Novice)
It's about time we actual use images we'd use in a video game, bitmap sprites. I've provided a sprite sheet that's free to use for any of your personal projects. We'll use this sprite sheet to move the character around the top screen and use different angles to show movement. Example, moving right shows the character looking right.

#### *7. basic-sprite-collision* (Novice)
This source code explores the understanding of Sprite Collision detection. Obviously one of the more important parts of developing a game is allowing a reaction based on two sprites touching. In this example, we'll have a center object (wall) that will notify the user it's entering boundries.
This is considered basic and does not contain any physics or any dynamic hit detection.

#### *6. basic-user-menu* (Novice)
Here we will explore how to make a simple user menu with various fields and allow the user to select items and go to new screens.

#### *5. scrolling-background* (Novice) incomplete
Since I found out about the 128 sprite limit, I needed to figure out a better way to display backgrounds. I'm guessing some where I'm missing a critical peice, probably the understanding of VRAM. So because devkitpro does come with a couple of background examples. This has turned out more complex then I thought. I'll come back to this.

#### *4. tile-generator-top* (Novice)
In `tile-generator` we built the tile map on the bottom screen in this example, we do the same on the top screen using VRAM Bank A.

#### *3. tile-generator* (Novice)
We take what we've learned from `multi-simple` and instead of randomly placing sprites down, we follow an array. Just like you would in a tile based game. This generates a simple 6 x 8 tiled map of 16x16 sized sprites. We used the VRAM Bank D which is specific to the bottom screen and Sprites.

<img align="right" width="150" src="http://i.imgur.com/zv62hWU.gif">
#### *2. multi-simple* (Novice)
This project demos the ability to dynamically add sprites to the screen and simple rotation animation. Pressing the `A Key` adds another sprite to the screen. This is also a good example to see how to apply different colors to the same sprite object.

#### *1. improved-simple* (Novice)
This gives an excellent example of sprite management and other basic graphic concepts. The End result is two colored squares sperated by screens. It also includes the sprite falling once it's let go to simulate animation.

# Downloading and Installing
Devkitpro now starts you off with GC and Wii SDKs. To get the GBA/NDS version of devkitPro use the link below:
http://devkitpro.org/wiki/Getting_Started/devkitARM

All projects are currently compiled with 1.50.3 NDS rom tool and devkitARM r45 (latest).

After installing (OSX perl install) it requires you to set up environment variables.
This is what my *~/.bash_profile* looks like:
```
  export DEVKITPRO=/Users/jdriselvato/devkitPro
  export DEVKITARM=${DEVKITPRO}/devkitARM
```

Then literally after that go to *~/devkitPro/examples* and type *make* in any of the example folders and it will compile the source to NDS file. It couldn't be easier.

#Emulator
I'm using DESMUME as the emulator to test out the code on OSX. I do have an R4 that I'll be using to test on device
Download here: http://desmume.org

#Resources to read
1. http://devkitpro.org/wiki/Getting_Started/devkitARM - Getting Started
2. http://libnds.devkitpro.org/index.html - The libNDS documentation (the bible practically)
3. https://patater.com/files/projects/manual/manual.html - Best guide to get you really familair with developing NDS
4. https://web.archive.org/web/20150814060137/http://www.tobw.net/dswiki/index.php?title=Graphic_modes - Graphic Modes
5. https://mtheall.com/vram.html#T0=1&NT0=32&MB0=0&TB0=0&S0=0 - Tool to check VRAM
6. http://www.coranac.com/2009/02/some-interesting-numbers-on-nds-code-size/ - Some interesting numbers on NDS code size
7. http://answers.drunkencoders.com - Different segments to beginner questions
8. http://www.cc.gatech.edu/~hyesoon/spr11/lec_arm_prog1.pdf - really awesome intro to the technical size of NDS development from GA Tech!

# Other Developers Examples
1. https://github.com/Thunderbolt26/nintendo_ds_game - 3 Mini Games in one full source
