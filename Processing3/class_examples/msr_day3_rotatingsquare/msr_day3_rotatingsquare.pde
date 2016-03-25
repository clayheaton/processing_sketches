float rotAngle = 0;

void setup(){
 size(500,500); 
 background(255);
}

void draw(){
  background(255);
  fill(255,0,0);
  noStroke();
  
  pushMatrix();
  translate(100,100);
  rotate(radians(rotAngle));
  rectMode(CENTER);
  rect(0,0,50,50);
  popMatrix();
  
  rotAngle += 1;
}