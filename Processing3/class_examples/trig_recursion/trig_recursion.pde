Circle parentCircle;

float diameter   = 400;
float decay      = 0.5;
float childAngle = 90;

void setup(){
  size(800,800);
  background(255);
  
  parentCircle = new Circle(4,diameter);
  
  noFill();
  stroke(0);
}

void draw(){
  background(255);
  parentCircle.drawAt(width/2,height/2, childAngle);
  
  childAngle++;
}