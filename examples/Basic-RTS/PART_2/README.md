# Basic RTS Part 2
In this example we use our new menu to select a menu item, specifically create a unit. Using timers we'll create a queue for creating new units and once each timer is complete a unit will be added to the screen, next to the house.

# Source Files
#### Menu
menu.c & menu.h will contain the functionality of all menu related code. This includes showing the menu, selecting items from the menu and more.

#### Units
unit.c & unit.h will contain the functionality and act as a class for the basic unit in our RTS. This includes generating, moving and killing off units.

#### House
house.c & house.h will contain the functionality of the house. The house is used to create additional units which also requires the menu to be shown to do so.

# Whats new?
#### Timers & Units
In this example we'll learn how to use the timer functionality to generate units. Units can be added to a queue and every 5 seconds a new unit will be generated and added to the map.