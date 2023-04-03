Archive from: https://code.google.com/archive/p/microlua-sim/

# Micro Lua DS Simulator (MLS)

MLS allows you to run Lua scripts targeted at µLua DS (i.e. using the stylus, screens, timers...), directly on your computer (Linux, Windows, and Mac OS X).

Its goal is to speed up development of µLua scripts, since you don't need to re-send your scripts to the DS or to reset a DS emulator each time you change your script.

Official topic on µLua forums (english): http://microlua.xooit.fr/t180-Micro-Lua-Simulator.htm
Official topic on µLua forums (french): http://microlua.xooit.fr/t179-Micro-Lua-Simulator.htm
Please note that I'm not the author of Micro Lua DS! Risike is. I only created the simulator. Here are the links to the DS project: * Forums: http://microlua.xooit.fr/ * Google Code: http://code.google.com/p/microlua/ * ~~Site (old): http://microlua.risike.com/~~~~


-----

Introduction

MicroLuaSimulator (or abbreviate MLS) is a very useful utility for MicroLua developers created by a member of our community, Ced-le-pingouin. It allows you to test your Lua scripts for NDS directly on your computer. MicroLuaSimulator also has a debug console!

Download

A good point is that you can use MicroLuaSimulator on several platforms: * Windows (http://www.cedlepingouin.com/mls/files/mls-0.4-win.zip) * Linux (http://www.cedlepingouin.com/mls/files/mls-0.4-linux.zip) * Mac OS X (http://www.cedlepingouin.com/mls/files/mls-0.4-mac.zip) * Source (http://www.cedlepingouin.com/mls/files/mls-0.4-src.zip)

The current version is 0.4 Final.

Usage

Launch a script

With file > open, you can browse your files and open Lua scripts. You can also pass the script to test as an arg on the command line.

Commands

Buttons

Here is a comparative list between the controls of the DS and those of your computer:

| DS | Keyboard | |:-------|:-------------| | Up | I or 8 | | Down | K or 5 or 2 | | Left | J or 4 | | Right | L or 6 | | A | D | | B | X | | X | E | | Y | S | | L | A or R | | R | Z or T | | START | Q or F | | SELECT | W or V | | Stylus | Mouse |

Shortcuts

You can use some shortcuts in MLS:

| Shortcut | Effect | |:-------------|:-----------| | Ctrl+O | Open a script | | P | Pause the script | | B | Restart the script | | C | Show/Display the console | | DEL | Clear the console | | F1 | Reduce FPS | | F2 | increase FPS | | F3 | Reduce UPS | | F4 | increase UPS | | F5 | increase the log level | | Ctrl+Q | Quit MLS |

Ctrl key is Command key ("Apple") on Mac OS X.

Know limitations

Paths

The .ini and .txt files are load from the folder of the mls executable, but the images are loaded from the script folder. So, be careful to place the files in the right place.

Sound

Due to the lack of sound libraries, there is currently no sound in MLS.

Links

Google Code page: http://code.google.com/p/microlua-sim/

Changelogs: * In English: http://microlua.xooit.fr/t180-Micro-Lua-Simulator.htm * In French: http://microlua.xooit.fr/t179-Micro-Lua-Simulator.htm
