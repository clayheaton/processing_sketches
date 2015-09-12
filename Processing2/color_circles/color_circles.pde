
void setup() {
  size(1000, 1000);
  // background(color(#393A67));
  background(0);
  //background(255);
  //frameRate(20);
}

void draw() {

  float x = random(width);
  float y = random(height);

  float diam = abs(height/2 - y) + 40;

  if (diam < 50) {
    diam = abs(width/2 - x) + 40;
  }

  float r = map(x, 0, width, 0, 255);
  float g = map(y, 0, height, 0, 255);
  float b = map(diam, 0, height/2, 0, 255);

  noFill();
  stroke(r, g, b, 50);
  ellipse(x, y, diam, diam);
}

