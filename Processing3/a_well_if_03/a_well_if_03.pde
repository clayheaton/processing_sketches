// Condition Expressions Example
float r = 0;
float g = 0;
float b = 0;

void setup() {
  size(400, 400);
}
void draw() {
  background(r, g, b);
  stroke(0);
  line(width/2, 0, width/2, height);
  line(0,height/2,width,height/2);

  // Change r depending on the mouseX position
  if (mouseX > width/2) {
    r = r + 1;
  } else {
    r = r - 1;
  }
  
  // Change b based on the mouseY position
  if (mouseY > height/2) {
    b = b + 1;
  } else {
    b = b - 1;
  }
  
  // Change g based on the mouse being pressed
  if (mousePressed) {
    g = g + 1;
  } else {
    g = g - 1;
  }

  // Keep the values between 0 and 255
  r = constrain(r,0,255);
  g = constrain(g,0,255);
  b = constrain(b,0,255);
}