/*---------------------------------------------------------------------------------
What I listened to/thoughts:
Got to love Initial D. Just as it makes my drive faster then I should, it does the same to my programming fingers. https://www.youtube.com/watch?v=Gah8FnYSypk&list=RDkxLwGow0Tvw&index=3
You know what get's no respect, Majin Bone kits.. They look sweet but never caught on. Shame.
- John Riselvato (johnriselvato.com)
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
#include <math.h>
#include <stdio.h>

typedef struct { // {x , y} coordinate
	float x;
	float y;
	float param; // something to do with T1
} Coord;

bool isCoordNull(Coord coord) {
	if (coord.x == -1 && coord.y == -1) return true;
	return false;
}

typedef struct { // {a.x, a.y} & {b.x, b.y}
	Coord a;
	Coord b;
} Ray;

typedef struct { // Square Segments on screen
	Coord a, b, c, d;
} Square;

Square segments[] = { // the objects on screen
	{{0.5, 0.9}, {0.4, 0.9}, {0.4, 0.5}, {0.5, 0.5}},
	{{-0.2, -0.4}, {-0.3, -0.4}, {-0.5, -0.5}, {-0.3, -0.5}},
	{{0.5, 0.4}, {1.0, 0.4}, {1.0, 0.1}, {0.5, 0.1}},
	{{-0.5, 0.4}, {-1.0, 0.4}, {-1.0, 0.1}, {-0.5, 0.1}},

	{{-1.0, -1.0}, {-1.0, -1,0}, {-1.0, 1.0}, {-1.0, 1.0}}, // left wall
	{{-1.0, -1.0}, {1.0, -1,0}, {1.0, -1.0}, {-1.0, -1.0}}, // bottom wall
	{{1.0, -1.0}, {1.0, -1,0}, {1.0, 1.0}, {1.0, 1.0}}, // right wall
	{{1.0, 1.0}, {1.0, 1,0}, {-1.0, 1.0}, {-1.0, 1.0}}, // top wall
};
// globals
touchPosition touch; // stylus touch position
Ray line_ray;
Coord null = {-1, -1}; // faking null which isn't really safe at all. I should do something else.

// functions
void renderSegments();
void renderLine();
Coord convertNDSCoordsToGL(Coord ndsCoord);
Coord getIntersection(Ray ray, Ray segment);

int main(int argc, char** argv) {
	videoSetModeSub(MODE_0_2D);
	consoleDemoInit();
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
		line_ray.b = convertNDSCoordsToGL(tmp);

		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();


		Coord closestIntersect = null;
		for(int i = 0; i < sizeof(segments)/sizeof(Square); i++){
			Square segment = segments[i];
			Ray SegmentRays[] = {
				{segment.a,segment.b}, // A to B
				{segment.b,segment.c}, // B to C
				{segment.c,segment.d}, // C to D
				{segment.d,segment.a}, // D to A
			};
			for (int t = 0; t < sizeof(SegmentRays)/sizeof(Ray); t++) {
				Coord intersect = getIntersection(line_ray, SegmentRays[t]);
				if (isCoordNull(intersect)) continue;
				if (isCoordNull(closestIntersect)) closestIntersect = intersect;
				if(intersect.param < closestIntersect.param){
					closestIntersect = intersect;
				}
			}
		}
		Coord intersect = closestIntersect;

		printf("\x1b[1;1HSegment @{%.6f, %.6f}", intersect.x, intersect.y);
		// line_ray.b = intersect;
		renderLine(intersect);
		renderSegments();

		glFlush(0);
		swiWaitForVBlank();
	}
}

Coord getIntersection(Ray ray, Ray segment) {
	// RAY in parametric: Point + Direction*T1
	float r_px = ray.a.x;
	float r_py = ray.a.y;
	float r_dx = ray.b.x-ray.a.x;
	float r_dy = ray.b.y-ray.a.y;

	// SEGMENT in parametric: Point + Direction*T2
	float s_px = segment.a.x;
	float s_py = segment.a.y;
	float s_dx = segment.b.x-segment.a.x;
	float s_dy = segment.b.y-segment.a.y;

	// Are they parallel? If so, no intersect (Pythagorean)
	float r_mag = sqrt(r_dx*r_dx+r_dy*r_dy);
	float s_mag = sqrt(s_dx*s_dx+s_dy*s_dy);

	if(r_dx/r_mag==s_dx/s_mag && r_dy/r_mag==s_dy/s_mag){ // Directions are the same.
		return null;
	}
	// SOLVE FOR T1 & T2
	float T2 = (r_dx*(s_py-r_py) + r_dy*(r_px-s_px))/(s_dx*r_dy - s_dy*r_dx);
	float T1 = (s_px+s_dx*T2-r_px)/r_dx;

	// Must be within parametic whatevers for RAY/SEGMENT
	if(T1<0) return null;
	if(T2<0 || T2>1) return null;

	Coord raycast = {r_px+r_dx*T1, r_py+r_dy*T1, T1};
	return raycast;
}

// Segment related functions
void renderSegments() {
	for (int i = 0; i < sizeof(segments)/sizeof(Square); i++) {
		glPushMatrix();
		glBegin(GL_QUADS);

		glColor3b(255, 255, 255);
		glVertex3v16(floattov16(segments[i].a.x),floattov16(segments[i].a.y), 0); // A
		glColor3b(255, 255, 255);
		glVertex3v16(floattov16(segments[i].b.x),floattov16(segments[i].b.y), 0); // B
		glColor3b(255, 255, 255);
		glVertex3v16(floattov16(segments[i].c.x),floattov16(segments[i].c.y), 0); // C
		glColor3b(255, 255, 255);
		glVertex3v16(floattov16(segments[i].d.x),floattov16(segments[i].d.y), 0); // D

		glEnd();
		glPopMatrix(1);
	}
}

// the redline related functions
void renderLine(Coord coord) {
	glPushMatrix();
	glBegin(GL_QUADS);
		//Coord converted = convertNDSCoordsToGL(line_ray.b);

		glColor3b(255, 0, 0);
		glVertex3v16(floattov16(line_ray.a.x),floattov16(line_ray.a.y), 0); // A
		glColor3b(255, 0, 0);
		glVertex3v16(floattov16(line_ray.a.x), floattov16(line_ray.a.y), 0); // B
		glColor3b(255, 0, 0);
		glVertex3v16(floattov16(coord.x), floattov16(coord.y), 0); // C
		glColor3b(255, 0, 0);
		glVertex3v16(floattov16(coord.x), floattov16(coord.y), 0); // D

	glEnd();
	glPopMatrix(1);
}

// OpenGL Coordinates functions
Coord convertNDSCoordsToGL(Coord ndsCoord) {
	// OpenGLs coordinates
	float AXIS_X_MAX = 1;
	float AXIS_X_MIN = -1;
	float AXIS_Y_MAX = 1;
	float AXIS_Y_MIN = -1;

	// Stole equations from http://stackoverflow.com/a/4521276/525576
	double x = (ndsCoord.x / (double) SCREEN_WIDTH) * (AXIS_X_MAX - AXIS_X_MIN) + AXIS_X_MIN;
	double y = (1 - ndsCoord.y / (double) SCREEN_HEIGHT) * (AXIS_Y_MAX - AXIS_Y_MIN) + AXIS_Y_MIN;

	Coord converted = {x, y};

	return converted;
}