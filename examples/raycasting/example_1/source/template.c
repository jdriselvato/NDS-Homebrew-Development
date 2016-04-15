/*---------------------------------------------------------------------------------
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
	glClearColor(255,255,255,31); // set the BG color
	glClearPolyID(1); // unique ID of background
	glClearDepth(0x7FFF);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

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

		renderLine();

		glFlush(0);
		swiWaitForVBlank();
	}
}

Coord convertNDSCoordsToGL(Coord ndsCoord) {
	Coord converted = {ndsCoord.x, ndsCoord.y};
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