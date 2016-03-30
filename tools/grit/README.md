# GRIT

The GBA Image Transmogrifier (“grit” for short) is a bitmap conversion tool for GBA/NDS development. It accepts a multitude of file types (bmp, pcx, png, gif, etc) at any bitdepth and can convert them to palette, graphics and/or map data that can be used directly in GBA code. The output formats are C/asm arrays, raw binary files GBFS files, and a RIFF-format I call GRF. The data can be compressed to fit the BIOS decompression routines.

# Intro to terminal Grit
On Linux or OSX we don't have the luxury of the Windows GUI (wingrit) to play with. 

Instead we have an extremely powerful command line tool. The command line functionally has like 100 different options. So this page will contain a list of commands I find useful and what I actually used.

If you are interested in the official manual you can view that here: http://www.coranac.com/man/grit/html/index.htm

# Set up Terminal Grit
To make things easier I suggest making a unix alias in your `~/.bash_profile`. This is what mine looks like, just change `jdriselvato` to your username:
````
alias grit="/Users/jdriselvato/devkitpro/grit-osx/grit"
````
Then reset your terminal and try typing `grit`, you should see something along the lines of this:
````
---grit v0.8.6 ---
GRIT: GBA Raster Image Transmogrifier. (grit v0.8.6, 20100317)
  Converts bitmap files into something the GBA can use.
usage: grit srcfile(s) [args]...
````