void setup() {
  size(400, 400);
  background(255);
}

void draw() {
  //background(255);

  color myColor = randomColor(20);
  noStroke();
  fill(myColor);

  rect(mouseX, mouseY, 100, 100);
  
}

color randomColor(int _alphaValue) {
  float r = random(0, 255);
  float g = random(0, 255);
  float b = random(0, 255);

  color c = color(r, g, b, _alphaValue);
  return c;
}