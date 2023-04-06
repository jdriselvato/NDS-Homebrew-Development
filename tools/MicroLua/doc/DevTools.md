This is a list of tools you may find useful in your development of MicroLua homebrews.


[TOC]


Computer
========

Text editors
------------

I am pretty sure I don't need to tell you which editor to use. [Notepad++](http://notepad-plus-plus.org/) is very good at doing this on Windows (you can even add MicroLua's API to its code highlighting). For Linux, any Gedit, Vim, Emacs etc. will do the job.

Image editors
-------------

[Photofiltre](http://www.photofiltre.com/), even in its free version can be quite efficient for this and produce low-res images that fit perfectly the Nintendo DS. I guess [Gimp](http://www.gimp.org/) or [Paint.NET](http://www.getpaint.net/) will do the job too.

Sound editor
------------

[Audiocity](http://audacity.sourceforge.net/?lang=fr) is probably the best software you can use for this. It can export your sounds in a MOD format so its perfect for MicroLua. Look at [the Sound tutorial](SoundTutorial) to learn more, including _how to make a sound database for MicroLua_.

Emulators
---------

If you are looking for a way of _testing the code on computer_, look at either [DeSmuME](DeSmuME) or [MicroLua Simulator](MicroLuaSimulator). Maybe [Dualis](http://dualis.1emu.net/index.html) can help you too.

Versioning
----------

We are currently using [Git](Git) to version the sources of MicroLua, but you can also use [SVN](http://subversion.tigris.org/) if you prefer.

There are many public repository services throughout the Internet, for instance [GitHub](https://github.com) which is especially designed for Git.

File transfer
-------------

For testing your scripts on the console without having to scratch your linker every time you need to update the files, try [MicroFileServer](MicroFileServer) which ease transfering MicroLua scripts between the computer and the console via Wifi connection.


Nintendo DS
===========

Text editors
------------

The best homebrew to make MicroLua scripts on your console is the Lua Editor reprise by geeker, known as [LED RGB](LEDRGB). It is about as effective as any computer editor and provides instant testing of course.

Image editors
-------------

There are a lot of them, all having cons.

* [PocketPixie](http://morukutsuland.free.fr/?page_id=19) may be the best. It supports different sizes: 8, 16, 32, 64, 128 pixels in width and height and can save in '.png'. However, filenames are not customizable nor are file locations. The restricted number of images can be avoided by saving different images as frames, which are saved under different names in the same location. The last release date may say that the homebrew is not longer maintained, but the sources are free to use. [DSOrganize](http://www.dragonminded.com/ndsdev/dsorganize/) may be used to move and rename files such as these images
* [Colors!](http://colorslive.com/announcement_ds1_10.php)
* [Phidia](http://dl.qj.net/nintendo-ds/homebrew-applications/phidias.html)
* [UAPaint](http://www.neoflash.com/forum/index.php?topic=5698.0)

Sound editors
-------------

It is quite complicated to both create music and make it so MicroLua can play it. µLua actually needs your MOD and WAV files to be included in a BIN file which acts as a sound database. This conversion can only be made on the computer so you will have to put back your creations on your big machine anyway.