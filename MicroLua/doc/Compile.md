This page will guide you through the compilation process of MicroLua.


[TOC]


Introduction
============

This page concerns both Windows and Linux users. In each part, there will be explanations for the two OS.

This is currently working with devkitPro 1.5.3 (libnds 1.5.7, devkitARM 41) and MicroLua 4.7.1. There is no clue that it won't work with any later version but in the same time I cannot guarantee it will work without modification.


Setup
=====

Download the files
------------------

The first thing to do is to download everything you need. Some are archives so a good archive manager such as 7zip is recommended.

1. [devkitPro](https://sourceforge.net/projects/devkitpro/files/Automated%20Installer/): this is the toolchain for compiling on many consoles, including NDS of course
    * Windows: download 'devkitProUpdater-X.exe'
    * Linux: download 'devkitARMupdate.pl'; this is a Perl script so you will need a Perl interpreter (that is already available on most flavors) to run this
* [Microlua sources](Get sources): both methods lead to having a folder containing all the good stuff in the same organization on both OS
* [modified libnds for MicroLua's Nifi](http://sourceforge.net/projects/microlua/files/Miscellaneous/libnds%20modified%20for%20Nifi%20uLua%204.6.1.zip/download): this will replace some low-level files to enable the Nifi (console-to-console connectivity) in MicroLua
* [custom updated µLibrary](http://sourceforge.net/projects/microlua/files/Miscellaneous/uLibrary%5BReylak%5D-09.jan.2013.zip/download): the µLibrary's website is down as the project is dead anyway, so just take our own sources


Install devkitPro
-----------------

Now you have everything needed, we can start with installing the devkitPro toolchain. This is the "compilation machine" which brings all the tools needed to build a `.nds`.

### Windows ###

The automated installer 'devkitProUpdater-X.exe' will guide you through the download and installation of the complete toolchain.

The only part needed is _msys_ and _devkitARM_ so you can uncheck everything else for a minimal setup. These parts concern PSP, NGC and Wii, besides some tools that may or may not be useful.

#### Checking the environment variables ####

There should be no issue with this but you may check that some environment variables have been created. They will lead the compilation process to devkitPro's binaries (otherwise the compilation fail as it will not find the `make` commands.  
Run a command interpreter (Windows+R then type in `cmd`) and type:

    echo %DEVKITPRO%
    echo %DEVKITARM%

If set properly, you should see the paths leading to your devkitPro installation, and to a folder called 'devkitARM' in the same path than above. If you haven't changed anything, they should be respectively 'c:\devkitpro' and 'c:\devkitpro\devkitARM'.  
The variable `PATH` also should have been changed by adding 'c:\devkitpro\msys\bin' (default path) to it. You check it out likewise with `echo %PATH%`.

If there any problem with these, check the following chapter; otherwise, you may jump to 'Install the µLibrary'.

#### Setting the environment variables ####

Let's say the variables weren't set properly; we have to make them anyway. Here is how to do this:

1. Go to 'Start/Control Panel/System'
* Open the 'Advanced' window
* Click the button 'Environment variables' at the bottom of the frame
* Add the two `DEVKITXXX` variables in the lower list
* Complete the pre-existant `PATH` variable by adding the path followed by a semi-column ";" (without any space)

I invite you to check what you did by following the step in the chapter hereabove.

### Linux ###

Running 'devkitARMupdate.pl' will install devkitPro in your 'home' folder, however this can be customized by editing the first line of real instructions in the script.

Then you need to add the environment variables similarly to Windows, as the script cannot do this.  
You should probably edit the file called either '.profile' or '.bash_profile' following the one already existing. This way they will be available in every shell you open.

Put somewhere in (at the end of) the file:

    DEVKITPRO=/home/YOUR_NAME/devkitpro
    DEVKITARM=$DEVKITPRO/devkitARM

Restarting the shell (or doing `source .profile` or `source .bash_profile` if you are lazy) is mandatory for this to have an effect. You can check it worked by typing:

    echo $DEVKITPRO
    echo $DEVKITARM


At this point you may be able to compile a generic source code for the NDS, however MicroLua needs two more things before the compilation can be made.


Install the µLibrary
--------------------

The next step is to install the µLibrary. This is a lib which (mainly) ease drawings so you do not have to mess with the low-level libnds for this.

Helpfully the precompiled files in 'libnds' may work, so you only have to merge this folder into the one in the devkitPro root. However there are not updated (and _this_ may cause them not to work) so I advised to follow the compilation steps hereby in order to properly setup the µLibrary.

### Windows ###

Some Batch scripts are present to ease the process, but you have to set the paths within the scripts.

1. 'Install.bat': on the 4th line, set `ROOTPATH` to the devkitpro's folder (usually 'c:\devkitpro')
* 'Source\Install.bat': 3rd line, set `ROOTPATH` to the libnds's folder inside the devkitPro's one (usually 'c:\devkitpro\libnds')

Now you are done, go back to the µLibrary folder and run 'Install.bat'. It is advised to run it from a CMD. Then, `cd` to 'Source' and run its 'Install.bat'.

You're done! You can test that the compilation process is working fine by running a 'Build.bat' in any example from the µLibrary folder. If you manage to get a working .nds in the end, it means you are almost done.

### Linux ###

Running `make` and / or `make install` in the 'Source' will do the job: building the lib, and copying the includes and the '.a' in the devkitPro folder according to the set environment variables.

Install the custom libwifi
--------------------------

One of the archives you downloaded earlier is a custom libnds lib which enables support for Nifi from MicroLua.

The only thing you need to do is to merge the 'libnds' folder into the one already present inside 'devkitpro' by replacing the asked files.

Set up MicroLua's sources
-------------------------

Whether you got the sources from the static package or the repository, you get a folder containing among others 'lua' (the Lua sources modified for MicroLua), 'sources' (the 'main.c' for µLua), etc.

If you need to include some files in the EFS, make a directory called 'efsroot' and put them in.


Compilation
===========

Finally we can compile MicroLua!

Windows
-------

You have two batch scripts, 'Compile_All.bat' and 'Compile_DS.bat':

* the latter will only compile the content of 'sources', thus producing the executable of MicroLua.  
* the first one compiles first the lualib (that is to say a version of Lua modified for µLua) and then makes MicroLua just like the second script

The first time, you obviously need to compile the lualib so run 'Compile_All.bat'. If an error occurs, run it a second time and it should be okay. Thus you also get your executable, meaning... You made it!

The next time, 'Compile_DS.bat' will be sufficient unless you change something inside the 'lua' folder.

Linux
-----

It is very close to what you did with the µLib and in the end you need to do the same things than the Windows users:

1. `cd lua`
* `make` and then `make install`
* `make clean` if you wish (important if you want to commit something to our Git repository afterwards)
* `cd ..`

Now you have built the lualib. So just do a `make` in the µLua's folder and you get your .nds binary! `make clean` may be done here too.  
The other times, a `make` in the µLua's folder is enough unless you modify something inside 'lua'.

Since 4.7, the Makefile provides two more targets:

* `make all` will always compile both lualib and 'MicroLua.nds'
* `make cleanall` will clean both the 'lua' folder and the current folder


EFS
===

You can get more informations about this feature [here](EFS).

Since [1c5823] there is no need to make the folder if you do not wish to use the EFS; the compilation process will include the folder and patch the binary to enable the EFS only if the folder is found.

By putting the 'lua' folder inside it, MicroLua will use this one if none is present on the linker. Replace the file 'shell.lua' inside 'lua/libs' by your 'index.lua' (the main file of your script) and you get your standalone MicroLua homebrew!




Many thanks to thomh@ck for his [tutorial (French)](http://microlua.xooit.fr/t1098-Compiler-MicroLua-avec-L-EFS-sous-Windows.htm).