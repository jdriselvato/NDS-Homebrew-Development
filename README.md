# NDS-Development
The Nintendo DS has a special place in my heart and I thought it was about time to started developing on it. You'll find resources, examples I've developed and more as I learn more about the NDS and devkitpro.

# Repo Examples
#### *improved-simple*
I first started out here trying to understand OAM, Sprite management and other basic graphic concepts. The End result is two colored squares sperated by screens. It also includes the sprite falling once it's let go to simulate animation.

<img align="right" width="250" src="http://i.imgur.com/zv62hWU.gif">
#### *Multi-simple*
This project demos the ability to dynamically add sprites to the screen and simple rotation animation. Pressing the key up adds another sprite to the screen. 
- March 26th, 2016 - supports dynamic sprite generation
- March 27th, 2016 - now supports different colors per sprite

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
