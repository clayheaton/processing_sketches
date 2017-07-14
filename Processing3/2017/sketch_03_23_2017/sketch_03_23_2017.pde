import gifAnimation.*;

GifMaker gifExport;

float angle  = 0;
float radius = 300;
PVector center;


void setup() {
  size(400, 400);
  background(18, 37, 54);
  smooth();
  // pixelDensity(2);
  center = new PVector(width/2, height/2);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(1);
  gifExport.setTransparent(255, 255, 255);
}

void draw() {
  background(18, 37, 54);
  noFill();
  stroke(255, 50);
  //ellipse(width/2,height/2,radius,radius/2);

  float newRadius = radius * sin(angle);

  float tempAngle = angle;

  for (int i = 0; i < 30; i++) {
    float x = center.x + cos(tempAngle)*newRadius/2;
    float y = center.y + sin(tempAngle)*radius/3;

    stroke(255, min(i*10, 255));
    fill(255, min(i*4, 255));
    ellipse(x, y, sin(tempAngle)*100, sin(tempAngle)*100);
    tempAngle += 1;
  }

  angle += 0.04;

  if (TWO_PI - angle > 0.02) {
    gifExport.addFrame();
  } else {
    gifExport.finish();
    noLoop();
  }
}