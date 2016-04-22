# Ray Casting Example 3.5
Everything in this example is the same as Example_3 except I break the format we've been following. This example does not match anything the ncase example has because it doesn't apply an image to the intersection segments. If you're developing a game, most likely you are going to apply a texture of some sort to a QUAD. In this example we do exactly that because why not. I didn't want to mess with Example 4 at the moment and wanted to figure something new out with OpenGL on the NDS.

# Preview
[![raycasting_example2](./screenshots/raycasting_example3.gif)] - coming soon

# Makefile
We'll be using pcx files to load as textures in OpenGL. For the NDS to understand this file it needs it's own header file. To create that we need to make a simple change to our Makefile. Add the following command to the end of the make file before the `endif`
````
#---------------------------------------------------------------------------------
%.pcx.o	:	%.pcx
#---------------------------------------------------------------------------------
	@echo $(notdir $<)
	@$(bin2o)


-include $(DEPENDS)
````

# Code Explained
### NDS OpenGL
This entire example relies on the NDS version of OpenGL, [more about that in VideoGL.h](http://libnds.devkitpro.org/videoGL_8h.html).