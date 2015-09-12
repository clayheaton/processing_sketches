void setup() {
  size(1000, 120);
  background(255);
  noFill();
}

void draw() {

  // Pick top or bottom
  int r = (int)random(100);
  boolean top = false;
  
  if (r > 50){
    top = true;
  }
  
  // Determine arc parameters
  int y        = top ? height : 0;
  int x        = (int)random(width);
  int endY     = y == 0 ? height : 0;
  int diameter = (int)random(height * 3);
  int angleMax = y == 0 ? -90 : 90;
  
  // Determine stroke color
  int offset   = abs(width/2 - x);
  stroke(map(offset,0,width/2,100,255),0,50);
  
  // Draw an arc
  arc(x, y, diameter, diameter, 0, angleMax);
}