class Brush {
  PVector brushStart, brushEnd;
  float distToBrush = 0.5;
  float degreesToBrush = -110;
  int lengthOfBrush = 30;
  BeastSegment parent;
  color c;

  Brush(BeastSegment bs) {
    c = color(random(255), random(255), random(255), 255);
    parent = bs;
    update();
  }

  void display() {
    debugDisplay();
    fill(c);
    noStroke();
    ellipse(brushEnd.x, brushEnd.y, 5, 5);
  }

  void debugDisplay() {
    if (debug) {
      stroke(128);
      strokeWeight(0.5);
      line(brushStart.x, brushStart.y, brushEnd.x, brushEnd.y);
      noStroke();
    }
  }

  void update() {
    brushStart = PVector.lerp(parent.a, parent.b, distToBrush);
    brushEnd = PVector.add(brushStart, (PVector)positionWith(degreesToBrush, lengthOfBrush));
  }

  PVector positionWith(float angle, float length) {
    float x = cos(radians(angle)) * length;
    float y = sin(radians(angle)) * length;
    return new PVector(x, y);
  }
}
