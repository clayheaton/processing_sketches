
void setup() {
  size(300, 300);
  background(255);
  strokeWeight(6);
}
void draw() {
  background(255);
  drawArrowAtCoords(width/2,height/2);
}

void drawArrowAtCoords(float xPos, float yPos) {
  pushMatrix();
  translate(xPos, yPos);
  
  // Calculate the angle to the mouse
  // by using the arctangent of the ratio
  // of the length of the sides.
  float a = atan2(mouseY - yPos, mouseX - xPos);

  rotate(a);
  line(-20, 0, 10, 0);
  line(10, 0, 0, 10);
  line(10, 0, 0, -10);
  popMatrix();
}