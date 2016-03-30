# Why Tools

At some point in history, some of the NDS tools that were available today wont be in a few years. Through my period of learning more about developing on the NDS, i've found an unfortunate amount of broken links and dead downloads. So to preserve history and provide anyone with an interest in developing with them this section will inclode tools.

Because 99% of these tools are released for public homebrew use I'll try to ensure that I'm not condoning piracy. If I do step on someones feet, please notify me and I'll remove it asap.

# Tools

### GRIT
Grit is this nice software that has a bunch of image/map handling abilites. Looks like the last time this was updated was in 2010 but fortunately the project developer still provides links to different versions: http://www.coranac.com/projects/#grit

Most likely once I figure out how to use this tool (and compile it on OSX, which once I do I'll provide a copy of it here), this will be the go to way to generate maps for tile based games.

So getting GRIT to compile on OSX was pretty messy. I've included the final output of what I compiled in the GRIT folder but just in case something breaks here's how I did it.
1. I found out that there's a github repo that makes compiling GRIT a lot easier on OSX. So clone that repo:
````
git clone https://github.com/alvasnaedis/grit
````
2. I had to download Freeimage which is a requirement to compile GRIT. You can find that here: http://freeimage.sourceforge.net/download.html but I had a hard time compiling it as well, so I found out brew has a version. So simply run:
````
brew install freeimage
````
4. Now we should be able to compile GRIT from the above repo by alvasnaedis. Which in my case was a success. We can use command line grit.


