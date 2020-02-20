PFont f;

void setup() {
  size(800, 800);
  f = loadFont("AppleGothic-30.vlw");
  background(255);
  textFont(f, 30);
  textAlign(LEFT);
  noStroke();
  rectMode(CORNER);
}

void draw() {
  background(255);
  fill(0);
  text("subjective\nfunction", 200, 100);

  fill(128);
  rect(135, 80, 60, 60);
}
