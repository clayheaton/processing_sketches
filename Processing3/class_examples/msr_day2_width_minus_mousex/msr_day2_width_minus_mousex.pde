void setup(){
  size(400,400);
  frameRate(10);
}

void draw(){
 background(255);
 fill(255,0,0);
 ellipse(mouseX,mouseY,40,40);
 
 fill(0,0,255);
 ellipse(width - mouseX,height - mouseY,40,40);
}