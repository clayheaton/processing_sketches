
boolean debug = false;
Beast beast;

void setup() {
  size(800, 800);
  background(255);
  noStroke();

  beast = new Beast(100);
}


void draw() {
  if (frameCount % 4 == 0) {
    fill(255, 50);
    rect(0, 0, width, height);
  }
  beast.display();
}  
