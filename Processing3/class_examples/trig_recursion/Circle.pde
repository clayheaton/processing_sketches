class Circle {
  Circle child  = null;

  int numChildren;
  float diameter, radius;

  Circle(int _numChildren, float _diameter) {
    numChildren = _numChildren;
    diameter    = _diameter;
    radius      = diameter / 2;

    // Create a child, if _numChildren is > 0
    if (_numChildren > 0) {
      float newChildDiameter = this.diameter * decay;
      child = new Circle(_numChildren - 1, newChildDiameter);
    }
  }

  void drawAt(float _x, float _y, float _angle) {
    // Draw this circle
    ellipse(_x, _y, this.diameter, this.diameter);

    // Tell the child to draw itself.
    if (null == child) {
      return;
    } else {
      float childX = _x + cos(radians(_angle))*radius;
      float childY = _y + sin(radians(_angle))*radius;
      child.drawAt(childX,childY,_angle);
    }
  }
}