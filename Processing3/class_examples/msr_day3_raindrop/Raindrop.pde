// This is a blueprint of a Raindrop
class Raindrop {
  // These are called instance variables
  float yPos, xPos, changeRate, rainSize;

  boolean hide = false;

  // This is called the constructor function (method)
  Raindrop(int _smallSize, int _largeSize) {
    yPos = random(0, height);
    xPos = random(0, width);
    changeRate = random(2, 4);
    rainSize = random(_smallSize, _largeSize);
  }

  // This method draws the raindrop
  void display() {
    if (hide == false) {
      noStroke();
      fill(0, 0, 255, 150);
      pushMatrix();
      translate(xPos,yPos);
      ellipse(0, 0, rainSize, rainSize);
      popMatrix();
    }
  }

  // This method updates the raindrop's position
  void update() {
    yPos += changeRate;
    if (yPos > height + rainSize/2) {
      yPos = -rainSize/2;
      xPos = random(0, width);
      hide = false;
    }

    if (mag(abs(mouseX - xPos), abs(mouseY - yPos)) < 50) {
      hide = true;
    }
  }
}