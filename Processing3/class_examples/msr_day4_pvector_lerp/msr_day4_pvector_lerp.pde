PVector v1, v2;

void setup() {
  size(500,500);

  v1 = new PVector(40, 20);
  v2 = new PVector(250, 350); 
}

void draw() {
  background(255);
  fill(255);
  ellipse(v1.x,v1.y,20,20);
  ellipse(v2.x,v2.y,20,20);
  
  float percent = map(mouseX,0,width,0,1);
  
  PVector v3 = PVector.lerp(v1,v2,percent);
  
  fill(255,0,0);
  ellipse(v3.x,v3.y,20,20);
}