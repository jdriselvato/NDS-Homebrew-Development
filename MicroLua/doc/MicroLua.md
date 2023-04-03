This page gives you and overall description of MicroLua.


[TOC]


Introduction
============

Developing homebrews for the Nintendo DS is no exactly easy. Knowledge in C/C++ is a prerequisite, and you have to struggle with the hardware to get your project working. Some libraries have been created to help, just like the well-known [libnds](http://en.wikipedia.org/wiki/Libnds) or the - now dead - [PALib](https://sourceforge.net/projects/pands/). Anyway, the global [devkitPro toolchain](http://devkitpro.org/wiki/Main_Page) is leading the sector. But this is not always convenient and hard to put in place.

So here comes MicroLua. In its name stands 'Lua', because MicroLua is a ___Lua interpreter___ for the Nintendo DS. You may or may not know the programming language [Lua], but what you must understand here is that Lua is far easier to handle than C. Add to this simplified language an API that avoids any headache with the hardware of the NDS and you obtain __MicroLua__.

As for the 'micro' part, it comes from the [µLibrary](http://www.playeradvance.org/forum/showthread.php?t=6239) designed by Brunni, which particularity is to use the 3D GPU of the Nintendo DS to draw a great amount of objects with a good efficiency. However, due to the lib handling both screens, each one only gives 30FPS.

Since its creation, MicroLua has evolved a lot and its development was once compromised. Now it is standing steadier than ever!


History
=======

The first ever version of MicroLua was released in September of 2008, and it was coded by Risike. In the beginning MicroLua was a private project which was not open source. It featured the fast drawing provided by the µLibrary and complete modules to handle Sprites and Maps designed for 2D gaming among all. Actually the main feature was to bring Lua (in its version 5.1.3) on the NDS by adapting some parts of the language.

Risike managed his project until July 2009, when he stated he didn't wish to continue this project and left us with its sources and a version 3.0 release candidate, we the community, the people gathered on the official forum. We had the choice to leave MicroLua in the depths of the Internet or to take care of it and to bring it up. I guess you know what happened next...

Today we are proud to show the world MicroLua is not dead, stands still and follows its evolution.