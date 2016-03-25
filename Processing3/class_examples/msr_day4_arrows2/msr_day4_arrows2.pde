int arrowsAcross = 20;
int arrowsDown   = 10;

void setup() {
  size(800, 600);
  background(255);
  strokeWeight(6);
}
void draw() {
  background(0);
  for (int i = 1; i < arrowsAcross; i++){
   for (int j = 1; j < arrowsDown; j++) {
     float x = i * width/arrowsAcross;
     float y = j * height/arrowsDown;
     drawArrowAtCoords(x,y);
   }
  }
}

void drawArrowAtCoords(float xPos, float yPos) {
  pushMatrix();
  translate(xPos, yPos);
  
  // Calculate the angle to the mouse
  // by using the arctangent of the ratio
  // of the length of the sides.
  float a = atan2(mouseY - yPos, mouseX - xPos);

  // Change color based on distance to mouse
  float m = mag(mouseX - xPos, mouseY - yPos);
  float r = map(m,0,width,255,0);
  stroke(r,0,0);

  rotate(a);
  line(-20, 0, 10, 0);
  line(10, 0, 0, 10);
  line(10, 0, 0, -10);
  popMatrix();
}