# NDS-Development Intro
My research and projects for developing on the NDS will be placed in this read me.
This repo will also include the default SDK folder and various projects I build.
All development will be done on OSX and unfortunately I don't know how this effect those trying the code out on windows.
Windows users this might help you out: http://www.coranac.com/tonc/text/setup.htm

# Downloading the Correct SDK (devkitPro)
So since the NDS is getting a little old devkitPro is now starting you off with Wii and GC. Which we don't want we want GBA/NDS devkitPro. So the correct download link is here:
http://devkitpro.org/wiki/Getting_Started/devkitARM

After installing (at least with the OSX perl install) it requires you to set up environment variables.
This is what my *~/.bash_profile* looks like:
```
  export DEVKITPRO=/Users/jdriselvato/devkitPro
  export DEVKITARM=${DEVKITPRO}/devkitARM
```

#Emulator
I'm using DESMUME as the emulator to test out the code on OSX. I do have an R4 that I'll be using to test on device
