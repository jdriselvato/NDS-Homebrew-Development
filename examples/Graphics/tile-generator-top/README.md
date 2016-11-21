# Tile Generator (Top Screen)

Generating a basic tile generator from array. 

### Things to know:
* NDS only supports 128 sprites on screen unfortunately, so 12 x 16 tiles wont work at 16x16 sprites.

### Understanding the Code

The cool thing about sprite sheets is you can dynamically create maps easily through multi-dimensional arrays. 

In this code we have an array titled `title_array` which contains 6 rows of 8 tiles laid out. As seen below:
````
	int tile_array[6][8] = { // create a map layout
		{0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 2, 2, 1, 1, 0, 0},
		{0, 1, 1, 2, 1, 1, 1, 0},
		{0, 1, 1, 2, 2, 2, 2, 0},
		{0, 0, 1, 1, 1, 1, 2, 0},
		{0, 0, 0, 0, 0, 0, 0, 0},
	};
 ````
 
 If you notice there are 3 numbers (0, 1 and 2). These correlate to a specific color to show. As seen below:

````
	int tile_colors[] = {
		ARGB16(1, 0, 0, 31), // blue (water?)
		ARGB16(1, 0, 31, 0), // green (grass?)
		ARGB16(1, 31, 31, 0) // yellow (sand?)
	};
````

### Preview

coming soon
