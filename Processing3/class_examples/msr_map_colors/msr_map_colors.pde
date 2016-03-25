void setup() {
  size(600, 400);
  background(0);
}

void draw() {
  
  float newMouseX = abs((width/2) - mouseX);
  float newMouseY = abs((height/2) - mouseY);
  
  float r = map(newMouseX,0,width,0,255);
  float b = map(newMouseY,0,height,0,255);
  
  background(r,0,b);

}