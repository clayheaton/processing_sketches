import processing.video.*;
Capture cam;

void setup() {
  String[] cameras = Capture.list();

  for (int i = 0; i < cameras.length; i++) {
    println(i + ": " + cameras[i]);
  }


  size(960, 360);
  background(255);
  // pixelDensity(2);

  cam = new Capture(this, cameras[6]);
  cam.start();
  frameRate(120);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  cam.filter(POSTERIZE, 2);
  tint(255, 0, 0);
  image(cam, 0, 0);


  tint(0, 255, 0);
  image(cam, cam.width, 0);

  tint(0, 0, 255);
  image(cam, cam.width*2, 0);

  tint(255, 255, 0);
  image(cam, 0, cam.height);


  tint(0, 255, 255);
  image(cam, cam.width, cam.height);

  //tint(255, 0, 255);
  noTint();
  image(cam, cam.width*2, cam.height);
}