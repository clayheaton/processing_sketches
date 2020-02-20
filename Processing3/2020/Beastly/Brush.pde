class Brush {
  PVector brushStart, brushEnd;
  float distToBrush = 0.5;
  float radToBrush;
  int lengthOfBrush;
  int brushDiameter;
  BeastSegment parent;
  color c;

  Brush(BeastSegment bs) {
    lengthOfBrush = (int)random(100);
    brushDiameter = 10+ (int)random(30);
    radToBrush = random(PI);
    c = color(random(255), random(255), random(255), 255);
    parent = bs;
    update();
  }

  void display() {
    debugDisplay();
    fill(c,50);
    noStroke();
    ellipse(brushEnd.x, brushEnd.y, brushDiameter, brushDiameter);
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
    brushEnd = PVector.add(brushStart, positionWith(parent.radiansBetween() - radToBrush, lengthOfBrush));
    
  }

  PVector positionWith(float angle, float length) {
    float x = cos(angle) * length;
    float y = sin(angle) * length;
    return new PVector(x, y);
  }
}
