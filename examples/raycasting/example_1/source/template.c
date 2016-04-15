/*---------------------------------------------------------------------------------
What I listened to:
Got to love Initial D. Just as it makes my drive faster then I should, it does the same to my programming fingers. https://www.youtube.com/watch?v=Gah8FnYSypk&list=RDkxLwGow0Tvw&index=3

ray casting example 1
Based on: https://github.com/ncase/sight-and-light/blob/gh-pages/draft1.html

-- John Riselvato ( April 13th, 2016 )

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

Things to know/whats new:
- What is Ray Casting?
- This is the first time going into GL Read more about it here: http://libnds.devkitpro.org/videoGL_8h.html
- v16 = vertex 4.12 fixed format
---------------------------------------------------------------------------------*/
#include <nds.h>

typedef struct { // {x , y} coordinate
	float x;
	float y;
} Coord;

typedef struct { // {a.x, a.y} & {b.x, b.y}
	Coord a;
	Coord b;
} Ray;

// globals
touchPosition touch; // stylus touch position
Ray line_ray;

// functions
void renderLine();
Coord convertNDSCoordsToGL(Coord ndsCoord);

int main(int argc, char** argv) {
	videoSetMode(MODE_0_3D); // enable BG0 with 3D

	glInit(); // init GL
	glClearColor(5, 5, 5, 31); // set the BG color
	glClearDepth(0x7FFF);

	glViewport(0,0,255,191);

	gluPerspective(70, 256.0 / 192.0, 0.1, 40);
	glPolyFmt(POLY_ALPHA(31) | POLY_CULL_NONE);
	gluLookAt( // set up camera
		0.0, 0.0, 1.0, //camera possition
		0.0, 0.0, 0.0, //look at
		0.0, 1.0, 0.0 //up
	);

	while(1) {
		scanKeys();
		if(keysHeld() & KEY_TOUCH) touchRead(&touch);

		Coord tmp = {touch.px, touch.py};
		line_ray.b = tmp;

		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();

		renderLine();

		glFlush(0);
		swiWaitForVBlank();
	}
}

Coord convertNDSCoordsToGL(Coord ndsCoord) {
	float AXIS_X_MAX = 1;
	float AXIS_X_MIN = -1;
	float AXIS_Y_MAX = 1;
	float AXIS_Y_MIN = -1;

	// Stole equations from http://stackoverflow.com/a/4521276/525576
	double x = ndsCoord.x / (double) SCREEN_WIDTH * (AXIS_X_MAX - AXIS_X_MIN) + AXIS_X_MIN;
	double y = (1 - ndsCoord.y / (double) SCREEN_HEIGHT) * (AXIS_Y_MAX - AXIS_Y_MIN) + AXIS_Y_MIN;

	Coord converted = {x, y};
	return converted;
}

void renderLine() {
	glPushMatrix();
	glBegin(GL_QUADS);
		glColor3b(255, 0, 0);
		glColor3b(255, 0, 0);
		glColor3b(255, 0, 0);
		glColor3b(255, 0, 0);

		Coord converted = convertNDSCoordsToGL(line_ray.b);

		glVertex3v16(floattov16(line_ray.a.x),floattov16(line_ray.a.y), 0); // A
		glVertex3v16(floattov16(line_ray.a.x), floattov16(line_ray.a.y), 0); // B
		glVertex3v16(floattov16(converted.x), floattov16(converted.y), 0); // C
		glVertex3v16(floattov16(converted.x), floattov16(converted.y), 0); // D

	glEnd();
	glPopMatrix(1);
}