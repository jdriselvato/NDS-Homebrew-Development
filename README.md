# NDS-Development
The Nintendo DS has a special place in my heart and I thought it was about time to started developing on it. You'll find resources, examples I've developed and more as I learn more about the NDS and devkitpro.

This repo is designed to provide an easier way to learn how to develop on the NDS with devkitpro. The examples that come with devkitpro are excellent but in some cases are very one off. Here you'll find examples that are specific to game development. I'll also include as much commented as needed to understand and provide resources to further an understanding of the topic. Also, feel free to report issues!

# Repo Examples
#### *4. tile-generator-top*
In `tile-generator` we built the tile map on the bottom screen in this example, we do the same on the top screen using VRAM Bank A.

#### *3. tile-generator*
We take what we've learned from `multi-simple` and instead of randomly placing sprites down, we follow an array. Just like you would in a tile based game. This generates a simple 6 x 8 tiled map of 16x16 sized sprites. We used the VRAM Bank D which is specific to the bottom screen in this example.

<img align="right" width="150" src="http://i.imgur.com/zv62hWU.gif">
#### *2. multi-simple*
This project demos the ability to dynamically add sprites to the screen and simple rotation animation. Pressing the key up adds another sprite to the screen. This is also a good example to see how to apply different colors to the same sprite object.

#### *1. improved-simple*
I first started out here trying to understand OAM, Sprite management and other basic graphic concepts. The End result is two colored squares sperated by screens. It also includes the sprite falling once it's let go to simulate animation.

# Downloading and Installing
Devkitpro now starts you off with GC and Wii SDKs. To get the GBA/NDS version of devkitPro use the link below:
http://devkitpro.org/wiki/Getting_Started/devkitARM

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
2. https://patater.com/files/projects/manual/manual.html - Best guide to get you really familair with developing NDS
2. https://web.archive.org/web/20150814060137/http://www.tobw.net/dswiki/index.php?title=Graphic_modes - Graphic Modes
3. http://libnds.devkitpro.org/index.html - The libNDS documentation (the bible practically)
4. https://mtheall.com/vram.html#T0=1&NT0=32&MB0=0&TB0=0&S0=0 - Tool to check VRAM
