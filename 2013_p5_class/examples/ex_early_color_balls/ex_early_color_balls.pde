int startX = 0;
int startY = 0;
int maxDiam = 40;
int squareSize = 40;
 
void setup() {
  background(255);
  size(400,400);
  noStroke();
  smooth();
}
 
void draw() {
  drawBall(startX, startY, maxDiam);
   
   
  // move to the next start position on the current row
  startX += squareSize;
   
  // Move to the next row
  if (startX >= width) {
    startX = 0;
    startY += squareSize;
  }
}
 
void drawBall(int startX, int startY, int maxDimension) {
   
  float diam;
  diam = random(maxDimension/10,maxDimension);
   
  fill(random(0,240), random(0,240), random(0,240));
  ellipseMode(CORNER);
  ellipse(startX, startY, diam, diam);
}
