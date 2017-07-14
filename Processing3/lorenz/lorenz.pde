import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;

// From this tutorial
// https://www.youtube.com/watch?v=f0lkz2gSsIk&feature=youtu.be


float x = 0.01;
float y = 0;
float z = 0;

float a = 10; // sigma
float b = 28; // rho
float c = 8.0/3.0; // beta

ArrayList<PVector> points = new ArrayList<PVector>();

PeasyCam cam;

void setup() {
  size(800, 600, P3D);
  pixelDensity(2);
  colorMode(HSB);
  cam = new PeasyCam(this, 500);

  background(0);
}

void draw() {
  background(0);
  float dt = 0.01;

  float dx = dt * (a * (y - x));
  float dy = dt * (x * (b - z) - y);
  float dz = dt * (x * y - c * z);

  x = x + dx;
  y = y + dy;
  z = z + dz;

  points.add(new PVector(x, y, z));


  noFill();
  //translate(width/2, height/2);
  scale(2);

  float hu = 0;
  beginShape();
  for (PVector v : points) {
    stroke(hu, 255, 255);
    curveVertex(v.x, v.y, v.z); 
    hu += 0.1;
    if (hu > 255) {
      hu = 0;
    }
  }
  endShape();
}