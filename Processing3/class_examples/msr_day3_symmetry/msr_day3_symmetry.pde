boolean okToDraw = true;
void setup() {
  size(600, 600); 
  noStroke();
  background(255);
}

void draw() {
  if (okToDraw && (mouseX > 0 || mouseY > 0)) {
    fill(0);
    ellipse(mouseX, mouseY, 10, 10);
    fill(255, 0, 0);
    ellipse(width - mouseX, mouseY, 10, 10);
    fill(128);
    ellipse(mouseX, height-mouseY, 10, 10);
    fill(#438FDE);
    ellipse(width - mouseX, height - mouseY, 10, 10);
  }
}

void keyPressed() {
  if (key == 'b') {
    okToDraw = !okToDraw;
  }
}