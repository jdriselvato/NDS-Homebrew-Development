# Basic Sprite Collision
This source code explores the understanding of Sprite Collision detection. Obviously one of the more important parts of developing a game is allowing a reaction based on two sprites touching. In this example, we'll have a center object (wall) that will prevent the sprite from entering it's boundries.

This is also the first example using the bottom screen!

### Understanding the Code
The most important part of this example is the collision function. If the collision occurs, the function returns true. 


````
bool collision() {
	int mainWidth = 8;
	int mainHeight = 8;
	int wallWidth = 40;
	int wallHeight = 40;

	int mainLeft = mainSprite.x;
	int wallLeft = wallSprite.x;
	int mainRight = mainSprite.x + mainWidth;
	int wallRight = wallSprite.x + wallWidth;
	int mainTop = mainSprite.y;
	int wallTop = wallSprite.y;
	int mainBottom = mainSprite.y + mainHeight;
	int wallBottom = wallSprite.y + wallHeight;

	if (mainLeft < wallRight && // left main will detect right wall
		mainRight > wallLeft && // right main will detect left wall
		mainTop < wallBottom && // top main will detect wall bottom
		mainBottom > wallTop) { // bottom main will detect wall top
    	return true;
	}
	return false;
}
````

#### What next?
Read up on more advance topics of collision such as hitbox detection (like above) or bitmap detection

Checkout these resources for more details:
	- http://www.gamedev.net/page/resources/_/technical/game-programming/collision-detection-r735
	- http://buildnewgames.com/gamephysics/
