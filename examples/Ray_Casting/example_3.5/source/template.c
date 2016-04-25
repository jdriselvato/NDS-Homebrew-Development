/*---------------------------------------------------------------------------------
What I listened to/thoughts:
In this example we take multiple rays calculate the intersection of various objects on screen. The only difference between this example and Example 2 is that we are filling the rays for the first time.
Based on: https://github.com/ncase/sight-and-light/blob/gh-pages/draft3.html

-- John Riselvato ( April 20th, 2016 )

built with: Nintendo DS rom tool 1.50.3 - Dec 12 2015

Things to know/whats new:
- What is Ray Casting?
- This is the first time going into GL Read more about it here: http://libnds.devkitpro.org/videoGL_8h.html
- v16 = vertex 4.12 fixed format
- What PI is and how COS and SIN work
---------------------------------------------------------------------------------*/
#include <nds.h>
#include <math.h>
#include <stdio.h>
#include <nds/arm9/image.h> // needed to load PCX files

#include <box_pcx.h>
#include <drunkenlogo_pcx.h>


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

int	texture[1]; // Storage For One Texture

// functions
void LoadGLTextures();
void renderTriangle(Coord b, Coord c);
void renderSegments();
Coord convertNDSCoordsToGL(Coord ndsCoord);
Coord getIntersection(Ray ray, Ray segment);

int main(int argc, char** argv) {
	videoSetMode(MODE_0_3D); // enable BG0 with 3D
	vramSetBankA(VRAM_A_TEXTURE); // must have to load a texture

	glInit(); // init GL
	glEnable(GL_TEXTURE_2D); // enable 2D Textures

	glEnable(GL_ANTIALIAS);

	glClearColor(0, 0, 0, 31); // set the BG color
	glClearPolyID(63); // BG must have a unique polygon ID for AA to work
	glClearDepth(0x7FFF);

	glViewport(0,0,255,191);

	LoadGLTextures();

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(70, 256.0/192.0, 0.1, 40);
	glMatrixMode(GL_MODELVIEW); // Set the current matrix to be the model matrix

	// glMaterialShinyness();
	glPolyFmt(POLY_ALPHA(31) | POLY_CULL_NONE | POLY_FORMAT_LIGHT0| POLY_FORMAT_LIGHT1| POLY_FORMAT_LIGHT2);

	// Texture things here
	glLight(0, RGB15(31,31,31) , 0,				  floattov10(-1.0),		 0);
	glLight(1, RGB15(31,31,31) , 0,				  0,	floattov10(-1.0));
	glLight(2, RGB15(31,31,31) , 0,				  0,	floattov10(1.0));

	while(1) {
		scanKeys();
		if(keysHeld() & KEY_TOUCH) touchRead(&touch);

		Coord intersects[50];
		int count = 0;
		for (float angle = 0; angle < 3.14*2; angle+= (3.14*2)/50) {
			float dx = cos(angle);
			float dy = sin(angle);

			Coord tmp_a = {touch.px, touch.py};
			line_ray.a = convertNDSCoordsToGL(tmp_a);
			Coord tmp_b = {touch.px+dx, touch.py+dy};
			line_ray.b = convertNDSCoordsToGL(tmp_b);

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
			intersects[count] = intersect;
			count++;
		}

		for (int i = 1; i < sizeof(intersects)/sizeof(Coord); i++) {
			// mouse being the start of a triangle
			Coord b = intersects[i]; // current intersect
			Coord c = intersects[i-1]; // the intersect before
			glBindTexture(GL_TEXTURE_2D, texture[0]);
			renderTriangle(b, c); // makes a nice triangle
		}

		renderTriangle(intersects[0], intersects[49]); // we need to link the first to the last to get full fill

		renderSegments();

		glFlush(0);
		swiWaitForVBlank();
	}
}
// Load PCX files And Convert To Textures
void LoadGLTextures(){
	sImage pcx;
	loadPCX((u8*)drunkenlogo_pcx, &pcx); //load our texture box_pcx from box_pcx.h
	image8to16(&pcx);

	glGenTextures(1, &texture[0]);
	glBindTexture(0, texture[0]);
	glTexImage2D(0, 0, GL_RGB, TEXTURE_SIZE_128 , TEXTURE_SIZE_128, 0, TEXGEN_TEXCOORD, pcx.image.data8);
	imageDestroy(&pcx);
}

void renderTriangle(Coord b, Coord c) {
	// not sure what to accept as arguments yet. probably mouse as a and two segments as b and c.
	glPushMatrix();
	glBegin(GL_TRIANGLES);
		glColor3b(100, 10, 10);
		glVertex3v16(floattov16(line_ray.a.x),floattov16(line_ray.a.y), 0); // A
		glColor3b(100, 10, 10);
		glVertex3v16(floattov16(b.x), floattov16(b.y), 0); // B
		glColor3b(100, 10, 10);
		glVertex3v16(floattov16(c.x), floattov16(c.y), 0); // C
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

// Segment related functions
void renderSegments() {
	for (int i = 0; i < sizeof(segments)/sizeof(Square); i++) {
		glColor3b(255, 255, 255);

		glLoadIdentity();
		glTranslatef(0.0f,0.0f,-1.0f);
		glBindTexture(GL_TEXTURE_2D, texture[0]);

		glBegin(GL_QUADS);
			//glColor3b(255, 255, 255);
			glVertex3v16(floattov16(segments[i].a.x),floattov16(segments[i].a.y), 0); // A
			//glColor3b(255, 255, 255);
			glVertex3v16(floattov16(segments[i].b.x),floattov16(segments[i].b.y), 0); // B
			//glColor3b(255, 255, 255);
			glVertex3v16(floattov16(segments[i].c.x),floattov16(segments[i].c.y), 0); // C
			//glColor3b(255, 255, 255);
			glVertex3v16(floattov16(segments[i].d.x),floattov16(segments[i].d.y), 0); // D
		glEnd();
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