# Why this is important

At some point in history, some of the NDS tools that were available today wont be in a few years. Through my period of learning more about developing on the NDS, i've found an unfortunate amount of broken links and dead downloads. So to preserve history and provide anyone with an interest in developing with them, this section will include tools I find useful.

Because 99% of these tools are released for public homebrew use, I'll try to ensure that I'm not condoning piracy. If I do step on someones feet, please notify me and I'll remove it asap.

# NDS Development Tools

### GRIT - GBA Raster Image Transmogrifier
Grit is this nice software that has a bunch of image/map handling abilites. Looks like the last time this was updated was in 2010 but fortunately the project developer still provides links to different versions: http://www.coranac.com/projects/#grit

Please notice, GRIT is actually pre-installed and ready to go with DevKitPro. Read the grit [README.md](grit/README.md) for more

You can learn how to use GRIT with the [official manual](http://www.coranac.com/man/grit/html/index.htm) but I've also put together a list of commands in the [/grit](grit/README.md) folder.

# Flash Carts
## R4 SDHC
This is the prime cart I used for development since. Nothing to write about but it works.

## EZ Flash IV
If you have an EZ Flash IV, you can run both GBA and NDS homebrew on it. So it makes it great cart if your using an NDS and NDSLite. Below I'll outline a few annoying things to get it up and running.

#### SAVING
How difficult can it be to save? Well annoyingly so if you don't know a few things.

1. All save files are saved in the root under the folder `/SAVER/`.
2. You need to create dummy save files for each game. So If you have `game.nds` you'll need `game.sav` in `/SAVER/`. You can easily create this file in terminal with `touch game.sav` and call it a day.

Now saving should work.

#### Formating (OSX)
This device requires your MiniSD (who uses MiniSD? China I guess) to be formated on FAT16. If you are not using Windows it can be really annoying to get it up formated in this old format. Below will outline now I did it.

WARNING! Do at your own risk! I am not responsible if you wipe your own hard drive. Pay attention.

1. run this command to find exactly where your MiniSD is mounted on the computer: `diskutil list`
This will output something along the lines of:

````
/dev/disk2 (internal, virtual):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:                  FAT32 EZFLASHSD           +2.0 GB   disk2
                                 Logical Volume on disk0s2
````
We'll need to know what is after `/dev/` for ouf formating and the drives name.

NOTE: Mine says `/dev/disk2` you're MIGHT say something different.

NOTE: My Drive name is `EZFLASHSD`, you're will probably say something different

2. Now that we know both the drive location and name we will run this function. Replace the values with your own:

````
diskutil partitiondisk /dev/disk2 1 MBRFormat "MS-DOS-FAT16" "EZFLASHSD" 2G
````

If it worked the terminal will output the same outline seen in step 1 but now `TYPE` will say `FAT16`.
