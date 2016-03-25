Circle parentCircle;

float firstDiameter = 300;
float decay      = 0.7;
float angleDecay = 0.4;
float childAngle = 90;
color c = color(0,100,255);

int childCircles = 11;

void setup(){
  size(800,800);
  background(255);
  
  parentCircle = new Circle(childCircles,firstDiameter,c,true);
  
  noStroke();
}

void draw(){
  // background(255);
  parentCircle.drawAt(width/2,height/2, childAngle);
  
  childAngle++;
}