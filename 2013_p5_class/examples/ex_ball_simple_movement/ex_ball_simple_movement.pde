PVector velocity;
PVector position;

void setup() {
  size(400, 400);

  position  = new PVector(width * 0.5, height * 0.5);
  velocity  = new PVector(2, 1);
  fill(128);
  noStroke();
}

void draw() {
  background(255);
 
  ellipse(position.x, position.y, 50, 50);

  position.add(velocity);

  if (position.x > width || position.x < 0) {
    velocity.x *= -1;
  }

  if (position.y > height || position.y < 0) {
    velocity.y *= -1;
  }
}

