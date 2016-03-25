
int thingdim   = 40;
int perturbAmt = 2;

void setup() {
  size(800, 600);
  background(255);
}

void draw() {
  background(255);
  for (int x = 5; x < width; x += 50) {
    Thing t = new Thing(x);
    for (int y = 5; y < height; y += 50) {
      pushMatrix();
      translate(x, y);
      t.display();
      t.perturb();
      popMatrix();
    }
  }
  // noLoop();
}