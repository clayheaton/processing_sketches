import processing.video.*;

int x = 0;
int y = 0;

Capture video;

void setup() {
  size(800, 600);
  video = new Capture(this, 80, 60);
  video.start();
  background(255);
  frameRate(60);
}

void draw() {

  int imageX = x * width/10;
  int imageY = y * height/10;

  // Uncomment to tint every other image
  /*
  if ((x+y) % 2 == 0) {
    tint(color(255, 0, 0));
  } else {
    noTint();
  }
  */

  image(video, imageX, imageY);

  if (x > 9) {
    x = 0; 
    y += 1;
  } else {
    x += 1;
  }

  if (y > 9) {
    y = 0;
  }
}

void captureEvent(Capture video) {
  video.read(); 
  // video.filter(INVERT);
  // video.filter(THRESHOLD);
}