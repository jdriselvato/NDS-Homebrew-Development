# Basic User Menu

Here the user can use the up and down key to navigate a menu and view new data when selecting menu item with the A button

### What's new:
* `keysDown()` lets you hold down a key and it only registers as one press. Great for menus
* `consoleSetWindow()` lets you set the window of the console `(x, y, width, height)`

### Understanding the Code

First off we have an array of Menu Items. In this case 4 of them
````
// list of menu items
struct MenuItem items[] = {
	{"Play", 0},
	{"Load", 1},
	{"Settings", 2},
	{"Credits", 3}
};
````

Since we will be create the menu via text our init will look like this:

````
	consoleInit(&consoleSub, 0, BgType_Text4bpp, BgSize_T_256x256, 16, 6, false, true);
````

Notice the `consoleInit()`, as it's how you init the text base console. 
This is typically a lot easier to get text on the screen with. 

Next, to move through the menu list we will use the Arrow keys. 
I've created a method called `arrowKeysDownHandler(int keys, int cursorLocation)` which takes the current cursor location and the key pressed and relocated the cursor depending on direction.

### Controls

* **A Button** - Select Current Menu Item
* **B Button** - Return to root of Menu
* **UP Button** - Move cursor up
* **Down Button* - Move cursor down
