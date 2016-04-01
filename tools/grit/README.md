# GRIT

The GBA Image Transmogrifier (“grit” for short) is a bitmap conversion tool for GBA/NDS development. It accepts a multitude of file types (bmp, pcx, png, gif, etc) at any bitdepth and can convert them to palette, graphics and/or map data that can be used directly in GBA code. The output formats are C/asm arrays, raw binary files GBFS files, and a RIFF-format I call GRF. The data can be compressed to fit the BIOS decompression routines.

# Devkitpro to the rescue (no install required)
Turns out devkitpro actually supports Grit automatically. So you don't have to go through the process of getting Grit installed. Simply follow the below instructions to getting your image ready with grit.

1. make a folder called `data`
2. put image (png, bmp, jpeg, etc) in this folder (example: tile_sheet.png)
3. create a new file with the same name as the image you want to gritify (example tile_sheet.grit)
4. Then using the manual arguments added each argument on a line in the .grit file
````
#example .grit file for mapping
-m # output map
-mzl #Map data is LZ77 compressed.
````
5. Then when you run your Makefile, it will automatically take those two files and create the required output in the `./build` folder

# Intro to terminal Grit
On Linux or OSX we don't have the luxury of the Windows GUI (wingrit) to play with. 

Instead we have an extremely powerful command line tool. The command line functionally has like 100 different options. So this page will contain a list of commands I find useful and what I actually used.

If you are interested in the official manual you can view that here: http://www.coranac.com/man/grit/html/index.htm

# Set up Terminal Grit
So getting GRIT to compile on OSX was pretty messy. I've included the final output of what I compiled in the GRIT folder but just in case something breaks here's how I did it.
1. I found out that there's a github repo that makes compiling GRIT a lot easier on OSX. So clone that repo:
````
git clone https://github.com/alvasnaedis/grit
````
2. I had to download Freeimage which is a requirement to compile GRIT. You can find that here: http://freeimage.sourceforge.net/download.html but I had a hard time compiling it as well, so I found out brew has a version. So simply run:
````
brew install freeimage
````
4. Now we should be able to compile GRIT from the above repo by alvasnaedis. Which in my case was a success. We can use command line grit.

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

# Examples

### Grit Files for Maps
Still learning how to use these files, example code to come!
````
grit map_tiles.png -mLs -o$*
````
