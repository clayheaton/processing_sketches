// Derived from http://stackoverflow.com/a/25346777/373402

class Triangle {
  
  color _c;
  double _x1, _y1, _x2, _y2, _x3, _y3;
  
  Triangle(double x1, double y1, double x2, double y2, double x3, double y3, color c) {
    _c  = c;
    _x1 = x1;
    _x2 = x2;
    _x3 = x3;
    _y1 = y1;
    _y2 = y2;
    _y3 = y3;
    
    this.x3 = x3;
    this.y3 = y3;
    y23 = y2 - y3;
    x32 = x3 - x2;
    y31 = y3 - y1;
    x13 = x1 - x3;
    det = y23 * x13 - x32 * y31;
    minD = Math.min(det, 0);
    maxD = Math.max(det, 0);
  }

  boolean contains(double x, double y) {
    double dx = x - x3;
    double dy = y - y3;
    double a = y23 * dx + x32 * dy;
    if (a < minD || a > maxD)
      return false;
    double b = y31 * dx + x13 * dy;
    if (b < minD || b > maxD)
      return false;
    double c = det - a - b;
    if (c < minD || c > maxD)
      return false;
    return true;
  }

  void display() {
    noStroke();
    fill(_c);
    beginShape();
    vertex((float)_x1,(float)_y1);
    vertex((float)_x2,(float)_y2);
    vertex((float)_x3,(float)_y3);
    vertex((float)_x1,(float)_y1);
    endShape();
  }

  private final double x3, y3;
  private final double y23, x32, y31, x13;
  private final double det, minD, maxD;
}

