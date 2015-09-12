float angle = 0;

PVector center;

float radius   = 150;
float diameter = radius * 2;

void setup(){
  size(600,600);
  center = new PVector(width/2,height/2);
}

void draw(){
  background(255);
  
  // Draw our circle.
  noFill();
  stroke(0);
  ellipse(center.x,center.y,diameter,diameter);
  
  // Calculate the x and y points on the circle
  float xPoint = center.x + cos(radians(angle))*radius;
  float yPoint = center.y + sin(radians(angle))*radius;
  
  // Draw a red circle at the x and y point
  fill(255,0,0);
  noStroke();
  ellipse(xPoint,yPoint,10,10);
  
  // Increment the angle
  angle += 1;
}