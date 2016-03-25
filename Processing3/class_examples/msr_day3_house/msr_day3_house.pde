House h;

int xPos, yPos;

void setup() {
  size(500, 500);
  background(255);
  h = new House();
  
  xPos = 100;
  yPos = 300;
}

void draw() {
  background(255);
  h.displayAt(xPos,yPos,0.8,45);
}