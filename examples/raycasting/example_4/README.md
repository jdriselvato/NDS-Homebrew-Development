# Ray Casting Example 4
If you notice in example_3 some times the fill overlaps with the segment walls.
So instead we'll take the corners of the segment walls as intersections instead of
randomly placing a bunch of rays.

Based on this source [source](https://github.com/ncase/sight-and-light/blob/gh-pages/draft4.html).

# Preview
[![raycasting_example2](./screenshots/raycasting_example4.gif)] - coming soon

# Code Explained
### NDS OpenGL
This entire example relies on the NDS version of OpenGL, [more about that in VideoGL.h](http://libnds.devkitpro.org/videoGL_8h.html).