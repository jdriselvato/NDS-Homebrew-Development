# Ray Casting on NDS
I found a really awesome resource on [Ray Casting](https://en.wikipedia.org/wiki/Ray_casting) with HTML5/JS Canvas. So much so that I think it's worth the effort to porting it to the NDS. This resouce by ncase, is interactive so go check it out before you start trying to understand each example. http://ncase.me/sight-and-light/

#Introduction
Something I've always found interested was the idea of Ray Casting. I think the first time I saw it was in GISH. Until today, I thought it might be one of those impossible tasks to understand, I'm not so much of a Math guy. In any case, I found an awesome resource on how to do it: http://ncase.me/sight-and-light/
I'm going to try porting the majority of the Sight and Light examples. Fortunately for us, Ncase released all the source code (HTML/JS) on [github](https://github.com/ncase/sight-and-light). I'm going to try making this as easy as possible to understand, including the equations

# Examples
The Ray cast examples by ncase are a collection of improved iterations. This includes a total of 8 different examples some of which I will port. Below are an outline of each

### *1. Example_1* - documentation incomplete
This example shows off a basic hit detections on a single ray. This is a good starting point to understand the basics of Ray Casting. Move the stylus in any direction and watch the ray cast to various objects on the screen. Based on this [source](https://github.com/ncase/sight-and-light/blob/gh-pages/draft1.html).

### *2. Example_2* - documentation incomplete
In this example we take multiple rays calculate the intersection of various objects on screen.  We take a lot of what we learned from the first example and expand it with multiple rays. Based on this source [source](https://github.com/ncase/sight-and-light/blob/gh-pages/draft2.html).

### *3. Example_3* - documentation incomplete
In this example we take multiple rays calculate the intersection of various objects on screen. The only difference between this example and Example 2 is that we are filling the rays for the first time. Based on this source [source](https://github.com/ncase/sight-and-light/blob/gh-pages/draft3.html).

### *3.5. Example_3.5* - documentation incomplete
Everything in this example is the same as Example_3 except I break the format we've been following. This example does not match anything the ncase example has because it doesn't apply an image to the intersection segments. If you're developing a game, most likely you are going to apply a texture of some sort to a QUAD. In this example we do exactly that because why not. I didn't want to mess with Example 4 at the moment and wanted to figure something new out with OpenGL on the NDS.

### *4. Example_4* :octocat: Dev-ing :octocat:
If you notice in example_3 some times the fill overlaps with the segment walls. So instead we'll take the corners of the segment walls as intersections instead of randomly placing a bunch of rays. Based on this source [source](https://github.com/ncase/sight-and-light/blob/gh-pages/draft4.html).