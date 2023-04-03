Learn how to include sound files to your MicroLua project.

[TOC]


Introduction
============

MicroLua's sound system is based on the [MaxMod library](http://www.maxmod.org/) which provides a great support for multiple MOD file types, with high quality and smart managing. Playing WAV as shorter sound effects (_SFX_) is also possible, while MOD files will be your main music source.

The main characteristic of this library is to use a _soundbank_ to be included into your project. Because this soundbank cannot be generated with the Nintendo DS, this leads to the main limitation: you cannot play music file that the user puts directly on its linker.


Supported music formats
=======================

As said before, there are two types of music playable with MicroLua: _modules_, which are complete musics, and _SFX_, which are small sounds such as shots, footsteps, etc.
Thus the following formats are supported:

* modules: MOD, XM, S3M, IT
* SFX: WAV


Using music in your homebrew
============================

Now you are aware of the first step to do: build a soundbank.

Creating the soundbank
----------------------

You need a small program called _Soundbank Maker Tool_ available in [this Utilities package](http://sourceforge.net/projects/microlua/files/Third-party/Utilities.zip/download).

After extracting it, you should see a folder 'in': it contains the files you wish to include into your project. So put some music files in it.

When it is done, run 'convert.bat'. The process will create two files: 'soundbank.bin' and 'soundbank.h'. Only the first one is to be put alongside your script, but the second will help you identify each sound as they will be referred to only with indexes:

    #define SFX_AMBULANCE                 0    // ID of SFX "ambulance"
    #define SFX_BOOM                      1    // ID of SFX "boom"
    #define MOD_KEYG_SUBTONAL             0    // ID of module "Keyg Subtonal"
    #define MOD_PURPLE_MOTION_INSPIRATION 1    // ID of module "Purple Motion"
    #define MOD_REZ_MONDAY                2    // ID of module "Rez monday"
    #define MSL_NSONGS                    3    // Number of songs (modules)
    #define MSL_NSAMPS                    67   // Number of samples (65 samples from the modules plus 2 WAV)
    #define MSL_BANKSIZE                  70   // Number of songs plus samples

Loading the soundbank in your script
------------------------------------

Let's say you have your soundbank, called 'soundbank.bin', just beside your script. Now you will want to load it, which is the first step in order to use it. This is as simple as calling `Sound.loadBank()`:

    :::lua
    Sound.loadBank("soundbank.bin")

Now you can use your modules and SFX as described in the next section.

Playing modules
---------------

Say we want to play the module "Purple Motion" (look at the 'soundbank.h' herebefore). As displayed, its index is `1`.

First we need to load the module, and then we can play it:

    :::lua
    Sound.loadMod(1)
    Sound.startMod(1, PLAY_ONCE)

`PLAY_ONCE` means we play the module only once, but you can make it loop using the constant `PLAY_LOOP`.

Some functions are available to manage the playing, get a look at the related part of the [API documentation](APIDocumentation) to learn more about this point.

When you no longer need this module, you may unload it:

    :::lua
    Sound.unloadMod(1)

You might have understood that you can load several modules as every function requires an ID. You can however only play one module at a time.

Playing SFX
-----------

Using sound effects is slightly different:

    :::lua
    Sound.loadSFX(1)    -- Load SFX "Boom"
    handle = Sound.startSFX(1)

As you can see, we get the return value of `Sound.startSFX()` because these effects can be manipulated individually while multiple sounds can be played at the same time. Using the variable `handle` you may change the effect's own volume, its pitch, etc. Again, the [documentation](APIDocumentation) will be more complete.

At the end you may unload the SFX using:

    :::lua
    Sound.unloadSFX(1)

Unloading the soundbank / Using another soundbank
-------------------------------------------------

If you have multiple environments in your huge game, you may prefer to build several soundbanks, one for each environment. Now, only one soundbank can be loaded, so in order to change it you first need to unload the current one:

    :::lua
    Sound.unloadBank()

After this line, you are able to load another bank with `Sound.loadBank()`.