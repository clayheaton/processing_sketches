float r;
float g;
float b;
float a;
 
float diam;
float x=0;
float y=0;
 
void setup() {
  size(400,400);
  background(0);
  smooth();
}
 
void draw() {
  r = random(255);
  g = random(255);
  b = random(255);
  a = random(255);
  diam = 8;
 
  noStroke();
  fill(r,g,b,a);
  ellipse(x,y,diam,diam);
 
  if (x>400) {
    x = 0;
  } else {
    x = x + 10;
  }
 
  if (x>400) {
    y = y + 10;
  }
 
}
