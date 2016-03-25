int x, y;

void setup() {
  size(640, 480);
  background(255);
  fill(255, 0, 0);
  noStroke();
  x = 0;
  y = height/2;
}

void draw() {

  int xPos = x % width;

  if (xPos == 0) {
    background(255);
  }

  y = (int)random(0, height);
  rect(xPos, y, 3, 100);
  x += 1;

}