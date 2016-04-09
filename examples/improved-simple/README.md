# Improved Simple

Devkitpro for the NDS comes with a nice collection of Graphics examples. One specifically under /Sprites/ is an example called `Simple`. I felt that for a simple project it wasn't very noob friendly nor able to get one started developing from it right away. So I created an Improved Simple example.

What makes this stand out is the fact that we have two squares on the screen with ARGB() values to set the color. Using bitwise shifting and memory allocation was not easy to understanding without any prior lowlevel experience. Thus, this one tries using the higher level calls that devkitpro provides.

This article go over the basic concepts to better help teach this simple example.

#The Code!

First off, ever NDS program you write will 99% of the time include `#include <nds.h>`. This header file incases everything you'll need from DevKitpro. So include it!

So this example will only have two functions; `main()` and `createSquare()`. If this is your first experience with C programming, `main()` is the core function that ever c program has, it's what initiates the rest of the functionality of the program. Then `createSquare()` is what will use to dynamically create our squares. We'll go over the varialbes in the future.