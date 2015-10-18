// For loop example
void setup() {
  size(400, 400);
}

void draw() {
  // Set the background to white
  background(255);

  // No stroke
  noStroke();

  // Fill Color to red
  fill(255, 0, 0);

  // For loop
  // This example has a loop inside of a loop.
  // We can use this technique to create things
  // on a grid.

  for (int x = 1; x < 10; x++) {
    for (int y = 1; y < 10; y++) {
      int ellipseX = x * (width/10);
      int ellipseY = y * (height/10);
      int ellipseW = 10 + (x * 2);
      int ellipseH = 10 + (y * 3);

      ellipse(ellipseX, ellipseY, ellipseW, ellipseH);
    }
  }
}