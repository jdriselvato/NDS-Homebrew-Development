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

const struct {
	int ax, ay;
	int bx, by;
} Ray = {SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2};

// globals
touchPosition touch; // stylus touch position
Ray line_ray;
// functions
void renderLine();

int main(int argc, char** argv) {
	videoSetMode(MODE_0_3D); // enable BG0 with 3D

	glInit(); // init GL
	glClearColor(255,255,255,31); // set the BG color
	glClearPolyID(1); // unique ID of background
	glClearDepth(0x7FFF);

	glViewport(0,0,255,191);

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
		if(key & KEY_TOUCH) touchRead(&touch);

		line_ray.bx = touch.px;
		line_ray.by = touch.py;

		renderLine();

		glFlush(0);
		swiWaitForVBlank();
	}
}

void renderLine() {
	glPushMatrix();
	glBegin(GL_QUADS);
		glColor3b(255, 0, 0);
		glVertex3v16(floattov16(-0.01),floattov16(-0.5), 0);

		glColor3b(255, 0, 0);
		glVertex3v16(floattov16(0.01), floattov16(-0.5), 0);

		glColor3b(255, 0, 0);
		glVertex3v16(floattov16(0.01), floattov16(0.5), 0);

		glColor3b(255, 0, 0);
		glVertex3v16(floattov16(-0.01), floattov16(0.5), 0);
	glEnd();
	glPopMatrix(1);
}