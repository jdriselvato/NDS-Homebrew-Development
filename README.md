# NDS-Development Intro
This is my research and development for programming on the Nintendo DS.

# Repo details
#### *improved-simple*
I first started out here trying to understand OAM, Sprite management and other basic graphic concepts. The End result is two colored squares sperated by screens. It also includes the sprite falling once it's let go to simulate animation.

#### *Multi-simple*
`improved-simple` is basically a way to manage a single square. Multi-simple tries to understand how to create mutliple squares. I still don't know how to do this, atm.


# Downloading and Installing
So since the NDS is getting a little old devkitPro is now starting you off with Wii and GC. Which we don't want we want GBA/NDS devkitPro. So the correct download link is here:
http://devkitpro.org/wiki/Getting_Started/devkitARM

After installing (at least with the OSX perl install) it requires you to set up environment variables.
This is what my *~/.bash_profile* looks like:
```
  export DEVKITPRO=/Users/jdriselvato/devkitPro
  export DEVKITARM=${DEVKITPRO}/devkitARM
```

Then literally after that go to *~/devkitPro/examples* and type *make* in any of the example folders and it will run. It couldn't be easier.

#Emulator
I'm using DESMUME as the emulator to test out the code on OSX. I do have an R4 that I'll be using to test on device

#Resources to read
1. http://devkitpro.org/wiki/Getting_Started/devkitARM - Getting Started
2. https://patater.com/files/projects/manual/manual.html - Best guide to get you really familair with developing NDS
2. https://web.archive.org/web/20150814060137/http://www.tobw.net/dswiki/index.php?title=Graphic_modes - Graphic Modes
3. http://libnds.devkitpro.org/index.html - The libNDS documentation (the bible practically)
4. https://mtheall.com/vram.html#T0=1&NT0=32&MB0=0&TB0=0&S0=0 - Tool to check VRAM
