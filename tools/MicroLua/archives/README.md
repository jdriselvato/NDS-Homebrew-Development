MICROLUA 4.7.2
==============


> By the MicroLua's forum members, from  the original project by Risike  
> README file by Reylak


******************************************************************
I-..... Package content  
II-.... Installation  
III-... User guide  
IV-.... Developer guide  
V-..... Features  
VI-.... Links  
VII-... Credits and other background informations  
******************************************************************


I- Package content
------------------

This package contains the following files and directories:

* 'doc': you can find in this folder all the documentation as it can be found on the SourceForge (link below) of the project. This is an offline version of the Wiki as it was when this package was released; the text setup is done with MarkDown (thus the '.md'), a simple lightweight markup language that is easily readable by a human
* 'lua': this folder is the essential part of uLua with its binary
 * 'libs': this directory contains some essential files of uLua; you usually have nothing to do with these ones
 * 'scripts': you will place here the uLua scripts you want to play (as it is the default folder uLua will look for the scripts, but you may use any other directory of your wish)
  * 'examples': here are some useful examples showing you the more important features of MicroLua
* 'MicroLua.nds': here is the binary file for uLua
* 'README': the file you're now reading. You have all my gratitude for reading it! ;)
* 'CHANGELOG': this file presents you the most recent improvements made on uLua
* 'COPYING': just a copyright notice from the GNU GPL v3 for MicroLua


II- Installation
----------------

It is quite easy: just _copy the 'lua' folder_ to the **'root'** (and this is really important, you have to put the 'lua' folder to the 'root', i.e. the '/' folder, the one which contains all the others); and then, _copy the binary file 'microlua.nds'_ wherever you wish on your card.

For more detailed instructions, please look at this page: <https://sourceforge.net/p/microlua/wiki/Installation/>

If you have troubles while launching uLua, like "Unable to load libs.lua", check that the 'lua' folder is at the right place, that is to say in the 'root' (and that the 'libs.lua' file is in '/lua/libs/').


III- User guide
---------------

When you find a good uLua script (they are actually all good... ;) ), you will have probably either a single file (little script) or a directory. Just _copy what you get into the 'scripts' folder_.

Then, boot your Nintendo DS, launch MicroLua. You can see on the bottom screen a file list: this is the content of your 'scripts'  folder. You can freely naviguate through your card using the D-pad Up and Down; use Right to open a folder, and eventually you can use the A button to launch a script. Note that if you use A on a folder which contains a file named 'index.lua', this file will be launched.

And that's all, so enjoy yourself with the greatest uLua scripts! ;)

For a complete manual of MicroLua, look at the page <https://sourceforge.net/p/microlua/wiki/Home/>.


IV- Developer guide
-------------------

If you intend to make your own uLua scripts, here are some tips. These advices are available on our Wiki, more up-to-date and complete (<https://sourceforge.net/p/microlua/wiki/Home/>).

### Utilitaries ###

Some **utilitaries** (Windows only) are available for download on the SourceForge; they include:

 * A Lua compiler, which precompiles your scripts for faster execution. However, this is not often useful, and other people will not be able to look at the code
 * A font converter, to use your own fonts in your scripts
 * A map converter, from GBA graphics to NDS
 * A soundbank maker, to make your scripts more vivid with some sound

### Testing code on the computer ###

It's so boring to put your script on your uSD card, then in your linker, then boot your DS, then launch MicroLua, then FINALLY test your program and see that it doesn't work because you forgot this little tiny bracket. So you may want to **test your scripts on your computer** (it would be so convenient!). And guess what... It's possible! You can use MicroLua Simulator (MLS), a really good homebrew made by Ced\_le\_pingouin. Or you can also test with DeSmuME, a NDS emulator which can make MicroLua run.

### Packaging your scripts ###

I hope you will make great projects, so you will distribute a folder containing your project files. The default uLua shell provides a useful feature: **it will launch the file named 'index.lua' if you open the folder with the A button**. This way you can make your project look better by "hiding" the several files in the directory: the user will only have to press A instead of searching the correct file among the twenty others.

### Good habits are good ###

Last but no least: please, **do NOT compile your scripts**. It is often useless (as a speed gain), and open source projects are far better (imagine that one day you loose your files). I know there are some bad people outside, who may stole your work, but as long as you publish your projects on the uLua forum, there will be no leeching.

A safe alternative may be to use the **Embedded File System (EFS)** that provides MicroLua through the EFSLib, which allows you to produce a NDS binary including all your files. I encourage you to read this page then: <https://sourceforge.net/p/microlua/wiki/EFS/>.


V- Features
-----------

Here are the main features of MicroLua:

* _Fast drawing_: as MicroLua is based on Brunni's library, the uLibrary, MicroLua provides fast 2D drawing using the 3D GPU. But that also means there will probably not be any 3D drawing with MicroLua. If you are not happy with that, just delete this package and go to see PALib. This also includes alpha transparency, and PNG/GIF transparency (as MicroLua can load PNG, JPEG and GIF image formats)
* _Even faster drawing_: MicroLua also features Canvas, an object-oriented drawing system with high performances while allowing you to dynamically change drawing attributes after their creation
* _Full Sprites and Maps systems_: with automated animations, and dynamic maps (you can change the map constitution through your program)
* _Wifi_: Microlua provides full access to the Wifi connection of the Nintendo DS
* _Nifi_: MicroLua allows you to make your console communicate with other ones Ad-hoc
* _Sound system_: based on the Mixmod library, uLua can play MOD and WAV sounds based on a soundbank system
* _Fat access_: full access to the content of your card; uLua also implements a built-in library to manage INI config files
* _Embedded File System (EFS)_: you can make a special MicroLua version to embed your scripts inside the Lua interpreter
* _Rumble and motion_: if you have the required hardware, you can use uLua to make your NDS shake and detect its movements


VI- Links
---------

* <http://www.microlua.xooit.fr>: the main MicroLua's site (actually this is a forum). The active community will help you progress and share your scripts ;) Probably THE place you should check everyday
* <https://sourceforge.net/projects/microlua/>: MicroLua's project hosting on SourceForge. If you want to have the true latest MicroLua release, go check it! There is also a good Wiki with tons of informations
* <http://www.lua.org>: the official Lua website. You can find here all the informations relative to the language; this will probably be useful to you if you intend to make some homebrews with uLua unless you already know by heart the language


VII- Credits and other background informations
----------------------------------------------

All the thanks will first go to **Risike**, the true owner of the project, the Creator, our God (let's stop here), as the project originally comes from him. He released the first version of MicroLua in 2008, and maintained it until 2009 (v3.0). At this point, he stated that he didn't want to continue this project and released it open source.
But we, **the community**, took care of it, and continued the work. MicroLua sources are of course available.

People who must be thanked are _Papymouge_, at least for his great job on Wifi, Nifi, its shell... actually for too many things; _Ced-le-pingouin_, for working on the compilation process and for his great **MLS**, _Thomas99_ for its job about improving our Wifi system, _Grahack_ which have so many good (or not) ideas on how to drive uLua, _Ghuntar_, _thomh@ck_, _thermo_\__nono_, _geeker_ and myself _Reylak_, for this soooo beautiful README file ;) And last but not least, _all the community_ for creating such magnificent homebrews and supporting us!

One last thing about uLua: some people confuse MicroLua with Lua. _Lua is a language_, basically used on computers either as a stand-alone or as a plugin engine. uLua is meant to be **an adaptation of Lua for the Nintendo DS**. So please, MicroLua is NOT a language; LUA is the language; we have a detailed explanation here: <https://sourceforge.net/p/microlua/wiki/Lua/>. That's all, folks.

I now just have to thank also you for downloading the sources and maybe improving MicroLua! I hope this way you will enjoy much more MicroLua!



> Reylak

