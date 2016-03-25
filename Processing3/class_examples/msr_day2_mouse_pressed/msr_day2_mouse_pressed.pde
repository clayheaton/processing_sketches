void setup() {
  size(200, 200);
}

void draw() {
  
}

// Also try mouseReleased()
void mousePressed() {
  float x = random(20,width-20);
  float y = random(20,height-20);
  rect(x,y,20,20);
}