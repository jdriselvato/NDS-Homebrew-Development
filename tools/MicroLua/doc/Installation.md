This page explains how to install MicroLua and its scripts.


[TOC]


Get the latest version
======================

You can grab the latest version on this very site [here](https://sourceforge.net/projects/microlua/files/Releases/).

This gives you an archive containing:

* _Documentation_: a static version of some documentation that you can also find always up to date in this Wiki
* _lua_: the folder you will have to copy on your cartridge; it contains the main content of MicroLua
* 'MicroLua X.nds': the executable to run MicroLua, where 'X' is the version (usually something like 4.6.1)
* 'CHANGELOG X': the changes that were made to produce this new version; there may be multiple files, one for each "version layer"
* 'README': a file to learn some things about MicroLua that may or may not be on this Wiki

If you are looking for the sources, please read [How to get the sources](GetSources).


Put MicroLua on your linker
===========================

First, simply extract the content of the archive somewhere on your computer.

Then, copy both the folder called _lua_ and the NDS executable __on the root of your cartridge__. That is to say, in its "first folder", the one that contains the system your linker uses.

The executable can actually be put anywhere in your linker as soon as the _lua_ folder is at the root.

If you intend to run MicroLua on a 3DS, look at the page [3DSTimeWorkaround], and more specifically the chapter ["How MicroLua does it"](https://sourceforge.net/p/microlua/wiki/3DSTimeWorkaround/#how-microlua-does-it) to get the time working correctly. Otherwise, you're done with installing MicroLua!


Feed MicroLua with some scripts
===============================

In the folder called _lua_, you will find another one called _scripts_. This is the preferred directory to place your scripts, as the shell will look into it on startup. However you can copy the Lua scripts wherever you wish, you will just have to navigate through your filesystem.

The biggest homebrews come as a folder containing all the scripts and the resources they use, so you can simply copy it into _scripts_ and avoid a terrible mess. If the programmer was kind, he/she called the main script of its project 'index.lua', thus enabling the feature of the shell that allow you to run it just by pressing "A" on the folder.