float r = 150;
float g = 0;
float b = 0;

void setup() {
  size(400, 400);
}

void draw() {

  background(r, g, b);
  stroke(255);
  line(width/2, 0, width/2, height);

  // Conditional expressions
  if (mouseX > width/2) {
    r = r + 1;
  } else {
    r = r - 1;
  }

  // Replace the second if statement
  // with the constrain convenience function
  r = constrain(r,0,255);
}