Here you can learn how to use MicroLua Simulator to test your scripts on your computer.

[TOC]


Introduction
============

[MicroLua Simulator](https://code.google.com/p/microlua-sim/) (also abbreviated as _MLS_) is a very useful utility for MicroLua developers created by a member of our community, _Ced-le-pingouin_. It allows you to test your Lua scripts for NDS directly on your computer.
MicroLuaSimulator also has a debug console, and some useful features that may make you prefer it rather than [DeSmuME](DeSmuME).


Usage
=====

Running a script
---------------

With _File/Open_, you can browse your files and open Lua scripts. You can also pass the script to test as an arg on the command line.

Controls
--------

### Buttons ###

Here is a comparative list between the controls of the NDS and those of your computer:

  **DS**  |  **Keyboard**
----------|------------
    Up    |    I or 8
   Down   | K or 5 or 2
   Left   |    J or 4
  Right   |    L or 6
    A     |      D
    B     |      X
    X     |      E
    Y     |      S
    L     |    A or R
    R     |    Z or T
  START   |    Q or F
  SELECT  |    W or V
  Stylus  |    Mouse

### Shortcuts ###

You can use some shortcuts in MLS:

**Shortcuts** | **Effect**
-------------|------------
Ctrl+O | Open a script
P | Pause the script
B | Restart the script
C | Show/Display the console
DEL | Clear the console
F1 | Reduce FPS
F2 | increase FPS
F3 | Reduce UPS
F4 | increase UPS
F5 | increase the log level
Ctrl+Q | Quit MLS

_Ctrl_ key is _Command_ key ("Apple") on Mac OS X.

Know limitations
----------------

### Sound ###

Due to the lack of sound libraries, there is currently no sound in MLS.

### Software emulation ###

What most differentiate MLS from DeSmuME is that it does not emulate the NDS executable but instead recode the functions provided by µLua to be used on the computer in a NDS-like interface. Thus it cannot be as reliable as DeSmuME or as a real test on hardware.

Links
=====

* GoogleCode page: http://code.google.com/p/microlua-sim/
* changelogs:
    * in English: http://microlua.xooit.fr/t180-Micro-Lua-Simulator.htm
    * in French: http://microlua.xooit.fr/t179-Micro-Lua-Simulator.htm