The libnds encounters a bug on 3DS that prevent the time from being updated. This page describes what MicroLua provides to avoid this problem.


[TOC]


Description of the bug
======================

Some information has been given on the issue [#23] which was dedicated to this bug.

First of all, devkitPro's team is aware of this bug mainly through [this forum thread](http://devkitpro.org/viewtopic.php?f=2&t=3087) and [this issue](https://sourceforge.net/p/devkitpro/bugs/129/) (which got a reply from WinterMute). There is also [this one post](http://devkitpro.org/viewtopic.php?f=6&t=6982). The older report is from April 2012, saying:

> At first, I thought it was a problem with DeSmuME, but then when I tested it on my 3DS in DS mode it was not working either. it seems to work fine with No$GBA and on a DS Lite. When on DeSmuME or 3DS it seems to get set with the current time at the time it boots but it never is updated as the program is running.

We also learn that this bug is present on DeSmuME by the way.

The general hypothesis is that an interrupt from the ARM7 code is not correctly handled, on the second thread it is said to be IRQ7 and on the issue it would be IRQ_NETWORK. This interrupt is meant to make the ARM7 update the time provided by the libnds, but on 3DS it looks like the interruption never occurs.
With DeSmuME the answer is that the very emulator doesn't emulate this trigger.

In both cases, this problem results in the C system function `time()` always giving the time on when the homebrew was run, without updating it (i.e the return value of `time()` stays the same).


Workaround
==========

As said above, the function `time()` still returns an interesting value: the time when the homebrew was launched.
The solution is then to use a timer to update this value when necessary. This timer would be started when the homebrew is run, and everytime a call to `time()` is needed the duration recorded by this timer is added to the return value (in second of course).


How MicroLua does it
====================

We assume there is two functions the user may call to get any form of the date : `os.time()` and `os.date()`. The purpose is thus to fix the call to `time()` in these two functions.
The workaround gives two functions : `os.time3DS()` and `os.date3DS()`. They are exact copies of Lua's versions of them, but with small changes around the calls of `time()`. Because they needed a global timer, they are coded in the file 'ds_timer.c' which provides such timer.
However, leaving things as this is rather uncomfortable as the user would have to replace every occurrence of theses two functions in the homebrews he wants to run with their "3DS" versions. The handy thing comes from [MicroLua's bootstrap](BootSequence) which can run a file called 'myboot.lua' on the startup after Lua's libraries have been loaded.
Since [375841], 'myboot_example.lua' include instructions on how to apply this workaround by simply replacing `os.time()` and `os.date()` with `os.time3DS()` and `os.date3DS()` like this:

    :::lua
    --[[ If you are running MicroLua on a 3DS, you are victim of a libnds's bug that prevent
    time of being updated. If this is the case, activate "myboot.lua" as explained above
    so the following lines are used; they replace Lua's built-in functions by corrected
    versions. More information can be found on https://sourceforge.net/p/microlua/wiki/3DSTimeWorkaround/
    You will probably have to comment the other ones for they are not useful and may
    lead to unexpected behaviours. ]]
    os.time = os.time3DS
    os.date = os.date3DS


Other ways
==========

As there is no other way to bypass this bug, MicroLua could have do this otherwise, for instance by always replacing `os.time()` and `os.date()` with fixed versions. However it feels cleaner to use Lua's versions of these two in as most cases as possible, if only for the sake of easing updates. Moreover, using a workaround when it's not necessary isn't a good idea. As a counterpart, 3DS users have to change a small file once.