int x = 0;
float y = 200;
 
void setup() {
  size(800,200);
  background(0);
  noStroke();
  smooth();
}
 
void draw() {
  fill(random(255),random(255),random(255));
  ellipse(x,y,5,5);
   
  x += 2;
  y = height/2 + (20*sin(x));
}
