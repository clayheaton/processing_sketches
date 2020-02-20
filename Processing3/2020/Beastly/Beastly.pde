
boolean debug = true;
Beast beast;

void setup() {
  size(800, 800);
  background(255);
  noStroke();

  beast = new Beast(10);
}


void draw() {
  if (frameCount % 1 == 0) {
    fill(255, 50);
    rect(0, 0, width, height);
  }
  //fill(255, 5);
  //rect(0, 0, width, height);
  beast.display();
}  
