import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;

PImage ziggy;
ArrayList<Voxel> voxels;

PeasyCam cam;

void setup() {
  size(460, 276, P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  ziggy = loadImage("ziggy.jpg");
  // println(ziggy.width + ", " + ziggy.height);
  loadPixels();

  voxels = new ArrayList<Voxel>();
  println("here");
  for (int x = 0; x < pixelWidth; x++) {
    println("insidex");
    for (int y = 0; y < pixelHeight; y++) {
      int loc = x + y*pixelWidth;
      color c = pixels[loc];
      Voxel v = new Voxel(x, y, c);
      voxels.add(v);
      println(x + ", " + y);
    }
  }

  noStroke();
}
void draw() {

  background(0);
  rotateX(0);
  rotateY(0);

  for (Voxel v : voxels) {
    v.display();
  }
}