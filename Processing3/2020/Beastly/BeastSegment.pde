class BeastSegment {
  PVector a;
  float angle = 0;
  float len;
  PVector b = new PVector();
  BeastSegment parent = null;
  BeastSegment child = null;
  int numBrushes = 1;
  ArrayList<Brush> brushes = new ArrayList<Brush>();

  BeastSegment(float x, float y, float len_) {
    a = new PVector(x, y);
    len = len_;
    calculateB();
    makeBrushes();
  }

  BeastSegment(BeastSegment parent_, float len_) {
    parent = parent_;
    a = parent.b.copy();
    len = len_;
    calculateB();
    makeBrushes();
  }

  void makeBrushes() {
    for (int i = 0; i < numBrushes; i++) {
      Brush br = new Brush(this);
      brushes.add(br);
    }
  }


  void follow() {
    float targetX = child.a.x;
    float targetY = child.a.y;
    follow(targetX, targetY);
  }

  void follow(float tx, float ty) {
    PVector target = new PVector(tx, ty);
    PVector dir = PVector.sub(target, a);
    angle = dir.heading();
    dir.setMag(len);
    dir.mult(-1);
    a = PVector.add(target, dir);
  }

  void calculateB() {
    float dx = len * cos(angle);
    float dy = len * sin(angle);
    b.set(a.x+dx, a.y+dy);
  }

  void update() {
    calculateB();
    for (Brush b : brushes) {
      b.update();
    }
  }


  void display() {
    debugDisplay();
    for (Brush b : brushes) {
      b.display();
    }
  }

  void debugDisplay() {
    if (debug) {
      stroke(128);
      strokeWeight(0.5);
      line(a.x, a.y, b.x, b.y);
    }
  }
}
