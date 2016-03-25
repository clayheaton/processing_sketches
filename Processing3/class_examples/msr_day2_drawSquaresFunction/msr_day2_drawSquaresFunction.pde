color r1;

void setup() {
  size(800, 400);
  noStroke();
  r1 = randomColor(255);
  background(255);
}

void draw() {
  background(255);
  drawThreeSquares(mouseX, mouseY, r1, 5, 50, 10);
}

void drawThreeSquares(int _x, int _y, color _c, int _n, int _w, int _spacing) {
  fill(_c);
  for (int i = 0; i < _n; i++) {
    rect(_x + i*(_w + _spacing), _y + (i * _w), _w, _w);
  }
}

color randomColor(int _alphaValue) {
  float r = random(0, 255);
  float g = random(0, 255);
  float b = random(0, 255);

  color c = color(r, g, b, _alphaValue);
  return c;
}