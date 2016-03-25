int     radius, lines;
float   angle;
PVector center;
 
void setup() {
  size(600, 600); 
   
  lines = (int)random(4, 20);
   
  if (lines % 2 > 0) {
    lines += 1;
  }
   
  radius = 200;
  angle  = 360.0 / lines;
  center = new PVector(width/2.0,height/2,0);
   
  smooth();
}
 
void draw() {
  background(255);
  fill(0);
  noStroke();
  ellipse(width/2, height/2, radius*2, radius*2);
   
  stroke(255);
  strokeWeight(2);
   
  for(int i = 0; i < lines; i++){
    float thisAngle = i * angle;
    float ptX = center.x + sin(radians(thisAngle))*radius;
    float ptY = center.y + cos(radians(thisAngle))*radius;
    line(center.x,center.y,ptX,ptY);
  }
}