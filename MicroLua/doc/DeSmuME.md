Here you can learn how to use DeSmuME to test your scripts on your computer.

[TOC]


Introduction
============

Testing MicroLua's homebrews is actually very simple. It can also give results closer to the hardware than [MicroLua Simulator](MicroLuaSimulator).

DeSmuME will run MicroLua and emulate the file system of your linker, so you obviously need [to download it](https://sourceforge.net/projects/microlua/files/Releases/).


Setting up the emulator
=======================

1. [download DeSmuME](http://desmume.org/download/) and install it wherever you want
* start it and open the menu _Emulation/GBA Slot_
* be sure you have prepared a folder, representing the root of your SD card, containing the folder _lua_ (which a lot of people often forget to copy there); the homebrews go in the folder _scripts_
* choose _Compact Flash_. Select _folder_ and choose the folder you have prepared in the previous step
* in DeSmuME, start the ROM 'MicroLua X.nds' ('X' being the version) that you get in the release package
* profit


Limitations
===========

As DeSmuME is _emulating_ the console, it is very close to the real behavior of MicroLua, however when you seem to be experiencing a bug caused by MicroLua itself, please confirm it on your Nintendo DS. Despite all the work the team maintaining DeSmuME achieve, an emulator __is not__ the true hardware.

Excepted the point hereabove, there is no known limitation about using MicroLua with DeSmuME.

If compared to [MicroLua Simulator](MicroLuaSimulator), we can say it is far more reliable and complete, but with less debugging tools related to µLua.


Emulating µLua on Nintendo Wii
==============================

DeSmuME also exists as a [Wii homebrew](http://wiibrew.org/wiki/DeSmuME_Wii) which allows you to play .nds executables on your Wii, including MiroLua of course.

However, the steps are longer to perform:

1. start your Wii
* launch the Homebrew Channel (a special channel which is not from the Wii Shop)
* start DesmumeWII
* start MicroLua
* start a MicroLua homebrew


Credits
=======

This page is translated and revised from [Ghuntar's original tutorial](http://microlua.xooit.fr/t781-DeSmuME.htm) and the comments that were made there.