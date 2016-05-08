# Basic RTS
In this example we learn how to use the stylus to select a house and have a menu pop up. In Part 2, we will use this menu to select units to create.

# Source Files
This is the first time we actually split up our code into different source files. This is truly a better way to organize the code into different sections in order to keep things cleaner and easier to understand.

#### Menu
menu.c & menu.h will contain the functionality of all menu related code. This includes showing the menu, selecting items from the menu and more.

#### Units
unit.c & unit.h will contain the functionality and act as a class for the basic unit in our RTS. This includes generating, moving and killing off units.

#### House
house.c & house.h will contain the functionality of the house. The house is used to create additional units which also requires the menu to be shown to do so.