# Ray Casting on NDS
I found a really awesome resource on [Ray Casting](https://en.wikipedia.org/wiki/Ray_casting) with HTML5/JS Canvas. So much so that I think it's worth the effort to porting it to the NDS. This resouce by ncase, is interactive so go check it out before you start trying to understand each example. http://ncase.me/sight-and-light/

# Examples
The Ray cast examples by ncase are a collection of improved iterations. This includes a total of 8 different examples some of which I will port. Below are an outline of each

### *1. Example_1* - documentation incomplete
This example shows off a basic hit detections on a single ray. This is a good starting point to understand the basics of Ray Casting. Move the stylus in any direction and watch the ray cast to various objects on the screen. Based on this [source](https://github.com/ncase/sight-and-light/blob/gh-pages/draft1.html).

### *2. Example_2* - documentation incomplete
In this example we take multiple rays calculate the intersection of various objects on screen.  We take a lot of what we learned from the first example and expand it with multiple rays. Based on this source [source](https://github.com/ncase/sight-and-light/blob/gh-pages/draft2.html).

### *3. Example_3* - documentation incomplete
In this example we take multiple rays calculate the intersection of various objects on screen. The only difference between this example and Example 2 is that we are filling the rays for the first time. Based on this source [source](https://github.com/ncase/sight-and-light/blob/gh-pages/draft3.html).

### *3. Example_4* :octocat: Dev-ing :octocat:
If you notice in example_3 some times the fill overlaps with the segment walls. So instead we'll take the corners of the segment walls as intersections instead of randomly placing a bunch of rays. Based on this source [source](https://github.com/ncase/sight-and-light/blob/gh-pages/draft4.html).