=================================
Welcome to DSLua
=================================
I was surfing the web one day and found Lua Player on the PSP (http://www.luaplayer.org).  It prompted me to look into LUA and how it works.  I was a bit surprised at how easy it is to incorporate LUA into my own code and how simple it is to write scripts in Lua.  This is the reason I started writing a Nintendo DS version of Lua.

=================================
About version 0.6 Release
=================================
Waruwaru is still missing, but after 7 months of no updates, the admin of DSLua.com has given the source code to us, Jeremysr, Sypherce, and Daltonlaffs, who will keep updating DSLua with new releases!

One of the main additions is the Wifi and Socket functions.

There is also an auto-start option, to run a certain script as soon as the DSLua binary is run. See autostart.bat for instructions how to use it.

Stylus.Newpress() and Stylus.Released() were added (just like the stylus functions in PAlib).

There were some new system functions added which can control the power LED, detect when the lid is closed, turn on and off the screen backlights, and switch the screens.

DSLua programs now run faster, probably because of PAlib and devkitPro updates.

Function documentations have been written, it is found on DSLua.com.

Microphone is supported now.

Functions were added to let you get the pixel or tile from an 8-bit or tile background.

Same as the previous releases, version 0.6 comes in CF and GBFS flavor.

=================================
Supported Hardware
=================================
DSLua can run on Dualis emulators.  Get the GBFS flavor if you want to run on the emulator.

If you want to run your program on hardware, you need a Nintendo DS first.

If you don't know how to run home brew softwares on your Nintendo DS, then check out GBADev's Flash Equipment forum (www.gbadev.org).  DSLinux (www.dslinux.org/) forum also have some instructions.

DSLua depends on the ability to execute a script that is external to the engine.  For that matter, DSLua can read from GBFS or media accessible by Chishm's FAT driver (compact flash card using the GBA Movie Player or M3 devices only).  Adding more media support on my To Do List.

The new group has a Supercard CF, GBAMP v2 CF, and an EZ3 flash cart.  So, those will be the platforms that get the most testing. ;)

=================================
Files/Instructions
=================================
To start DSLua, simply select from one of the binaries that suits your hardware.  You can choose between 2 flavors:
1. DSLua 0.6 default with CF support on and GBFS support off.  GBFS will not function with CF driver on.
2. DSLua 0.6 default with GBFS support on and CF support off.  CF support can be toggled on/off.  Once CF is on, GBFS will not work.
Flavor #2 (GBFS support) can be run on the emulators. :)

To run DSLua with your scripts, choose from the following instructions depending on which flavor you are using:

Flavor 1 - DSLua with CF support:
* Unzip the binary to your computer and copy it to your media
* copy the lua scripts and data files that you want to run to the same media (you can try the the scripts in the scripts directory)
* Execute the DSLua binary.  On the M3 for example, you can press START button to run DSLUA.NDS or press A button to run DSLUA.SC.NDS
* Once the program is running, you should see a directory listing of what is on your media.  Press up and down on dpad to select the script you want to run, and press A to start the script.  When the script is finished, will be returned to the directory listing menu.

Flavor 2 - DSLua with GBFS support:
* Unzip the binary to your computer
* copy the lua scripts and data files that you want to run to the scripts directory (all examples are already in scripts directory)
* From a DOS prompt, CD to the directory where PACK.BAT and DSLUA.NDS is located, and run the batch file PACK.BAT.  This will pack all files in the scripts directory into a GBFS file and append it to your binary.
* After PACK.BAT runs successfully, you should see DSLUA-PACK.* files in the bundle directory
* You can execute DSLUA-PACK binary on Dualis emulator or your flashcard
* Execute the DSLua binary.  On the M3 for example, you can press START button to run DSLUA.NDS or press A button to run DSLUA.SC.NDS
* Once the program is running, you should see a directory listing of what is on your media.  Press up and down on dpad to select the script you want to run, and press A to start the script.  When the script is finished, will be returned to the directory listing menu.

It is simple to write a script for Lua.  Just use your favorite editor (Notepad for example.  My favorite is SlickEdit).  And then copy your scripts to your media card.  Run DSLua binary on your NDS and select your script to run it.

Please have a way to exit your lua script, that way the users can exit your program and be returned to DSLua's menu to run other programs/games.  If you need a way to pause after your script executes, you can use the DSLua.WaitForAnyKey() function.  See "01 - Hello.lua" in scripts directory for an example.

If DSLua can't execute or understand your script, a red error message will be display.  You can press START to return to DSLua menu after you read the error message.

=================================
Functions Available
=================================
See documentation at dslua.com for descriptions of how to use these functions.  Please be aware that the functions are not finalized, so they may be changed in future versions.

Control Pad functions:
- Pads.A()
- Pads.B()
- Pads.X()
- Pads.Y()
- Pads.L()
- Pads.R()
- Pads.Up()
- Pads.Down()
- Pads.Left()
- Pads.Right()
- Pads.Select()
- Pads.Start()
- Pads.AnyKey()

System functions:
- DSLua.WaitForAnyKey()
- DSLua.VBlankCount()
- DSLua.Year()
- DSLua.Month()
- DSLua.Day()
- DSLua.Hour()
- DSLua.Min()
- DSLua.AlarmHour()
- DSLua.AlarmMin()
- DSLua.Sec()
- DSLua.UserName()
- DSLua.UserMessage()
- DSLua.BirthMonth()
- DSLua.BirthDay()
- DSLua.Color()
- DSLua.Language()
- DSLua.Version()
- DSLua.SetScreenLight()
- DSLua.SetLedBlink()
- DSLua.SwitchScreens()
- DSLua.LidClosed()
- DSLua.SetDSLBrightness

Stylus functions:
- Stylus.Down()
- Stylus.X()
- Stylus.Y()
- Stylus.Newpress()
- Stylus.Released()

Tile Background functions:
- TileBackGround:LoadPalette()
- TileBackGround:LoadTiles()
- TileBackGround:LoadMap()
- TileBackGround:ScrollXY()
- TileBackGround:SetMapTile()
- TileBackGround:GetTile()

Text Background functions:
- TextBackGroung:SetColor()
- TextBackGroung:PrintXY()
- TextBackGroung:FillRectWithChar()
- TextBackGroung:Clear()

8 Bit Background functions:
- 8BitBackGround:SetPaletteColor()
- 8BitBackGround:Plot()
- 8BitBackGround:Line()
- 8BitBackGround:Clear()
- 8BitBackGround:GetPixel()

Screen functions:
- Screen.LoadTileBG
- Screen.LoadTextBG()
- Screen.Load8BitBG()
- Screen.Initialize()
- Screen.WaitForVBL()

FrameStrip functions:
- FrameStrip.Create()
- FrameStrip:LoadBin()
- FrameStrip:FreeAll()

Sprite functions:
- Sprite.LoadPalette()
- Sprite.Create()
- Sprite:SetFrame()
- Sprite:MoveTo()
- Sprite:Free()

Sound functions:
- Sound.LoadRaw()
- Sound:Play()
- Sound:Free()

Music functions:
- Music.LoadMod()
- Music:Play()
- Music:Pause()
- Music:Stop()
- Music:Free()

Wifi functions:
- Wifi.ConnectWFC()
- Wifi.GetHTTP()
- Wifi.InitUDP()
- Wifi.InitTCP()
- Wifi.Disconnect()

Socket functions:
- Socket:Send()
- Socket:SendTo()
- Socket:Recv()
- Socket:RecvFrom()
- Socket:Close()
- Socket:GetRemoteIP()
- Socket:GetLocalIP()

Mic functions:
- Mic.StartRecording()
- Mic.GetVol()
- Mic.Replay()

=================================
To Do List
=================================
- add more sprite/background/graphics support
- add sound support (done)
- add music support (done)
- file read/write support (done)
- add GBFS support (done)
- add network (TCP/IP & UDP) support (done)
- better error reporting (done)
- transfer scripts wirelessly and execute them
- support for other storage devices
- documentation (done)
- more examples
- update Lua to latest version
- update libraries to the latest versions
- debugger/emulator to make it easier to develop/test (now runable on Dualis)
- allow edit and run scripts on DS

=================================
Library Versions
=================================
Lua: 5.0.2
Devkitpro: 1.4.1
LibNDS: 20060719
PALib: 060917
FAT Driver: LibFATDragon 9/20/2006

=================================
Credits/Links
=================================
Nintendo - http://www.nintendo.com/
M3 Adapter - http://www.m3adapter.com
Lua - http://www.lua.org/
Lua Player for the PSP - http://www.luaplayer.org/
DevkitPro/LibNDS - http://www.devkitpro.org
PALib - http://www.palib.com/
Chishm - http://chishm.drunkencoders.com/
SanOS - http://www.jbox.dk/sanos/
DSLinux - http://www.dslinux.org/
GBADev - http://www.gbadev.org/
SlickEdit - http://www.slickedit.com/
Dualis - http://dualis.1emulation.com/
GBFS - http://www.pineight.com/gba/
gfx2gba Converter v0.15 by TRiNiTY
Graphics examples from PALib Examples, which is from
- http://www.reinerstileset.4players.de:1059/englisch.htm
Map example contains map/tiles from
- http://anthologie.emu-france.com/tuto_tile_map.html
Sound example contains sound samples from devkitPro's example directory
Mod dk2.mod (-starship commander 2- by koOty) downloaded from 
- http://www.modarchive.com/D/index14.shtml
Thanks to the entire home brew community!

=================================
Contact Info
=================================
- Get the latest DSLua from http://www.dslua.com
- send email to us at dslua.com

=================================
Known Issues
=================================
- Occasionally, sprite/graphics will be corrupted.  Re-running the script usually will fix the issue
- When you turn on CF, GBFS no longer works
- Even after turning on the M3/SD support, still can't init properly on an M3/SD
- When you print more than 24 lines to the console, print clears the screen instead of scroll
- DSLua crashes when you try something like print( "Test" .. Pads.A() ).  Need to wrap the function result in a tostring() function
- In some error cases, DSLua does not show the proper stacktrace() error messages
- The API is not finalized yet, so there is a risk of incompatibility between this build and future builds
- Source currently not released.  It will be released after I clean up the code a bit and finalize the APIs

=================================
Change History
=================================
Version 0.6
- New group: Sypherce, Daltonlaffs, Jeremysr
- Added wifi and socket functions
- Added new stylus functions
- Added new system functions
- Added microphone functions
- Added new 8-bit/tile background function (GetPixel and GetTile)
- Wrote documentation
- Added auto-start (see autostart.bat)
- Made it faster
- Upgraded PAlib, devkitPro, and FAT library

Version 0.5
- Added support for lua's io library
- Added functions to retrieve system information

Version 0.4
- Added tiled map background functions
- Added sound functions

Version 0.3
- Removed the delay after scripts complete.  If you need DSLua to wait before returning to menu, use the DSLua.WaitForAnyKey() function.
- Fixed some memory leaks in the file systems and graphics routines
- Added the FrameStrip object and Sprite object!
- Included additional utilities (GBFS/GFX2GBA)

Version 0.2
- Removed the need to press START after each script executes (replaced with a short delay)
- Integrated with Chishm's FAT driver (2006-03-03), better SD read support
- By turning off CF, DSLua now runs on DeSmuME 0.3.3
- GBFS is now accessible from the script
- Better error reporting when a script encounter an error
- Fixed text positions when user alternates between top and bottom screen using print()
- Second public preview release

Version 0.1
- First public release of version 0.1 (preview)