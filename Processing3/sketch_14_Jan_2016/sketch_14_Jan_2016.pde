import gifAnimation.*;
import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;

GifMaker gifExport;

PImage ziggy;
ArrayList<Voxel> voxels;

PeasyCam cam;

void setup() {
  size(920, 552, P3D);
  cam = new PeasyCam(this, width/8, height/8, 0, 200);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  ziggy = loadImage("ziggy.jpg");
  ziggy.loadPixels();

  voxels = new ArrayList<Voxel>();
  for (int x = 0; x < ziggy.width; x++) {
    for (int y = 0; y < ziggy.height; y++) {
      int loc = x + y*ziggy.width;
      color c = ziggy.pixels[loc];
      Voxel v = new Voxel(x, y, c);
      voxels.add(v);
    }
  }

  sphereDetail(3);
  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setTransparent(255, 255, 255);
}
void draw() {
  background(0);

  for (Voxel v : voxels) {
    v.display();
  }

  gifExport.addFrame();
}

void keyPressed() {
  gifExport.finish();
}