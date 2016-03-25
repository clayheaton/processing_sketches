import processing.video.*;

Capture video;

void setup() {
  size(320, 240);
  video = new Capture(this, 320, 240);
  video.start();
}

void draw() {
  image(video, 0, 0);
}

void captureEvent(Capture video) {
  video.read();
}