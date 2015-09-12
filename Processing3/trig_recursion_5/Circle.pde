class Circle {
  Circle child  = null;

  int numChildren;
  float diameter, radius;

  color c;

  boolean skipDrawing;

  Circle(int _numChildren, float _diameter, color _c, boolean _skip) {
    numChildren = _numChildren;
    diameter    = _diameter;
    radius      = diameter / 2;
    c = _c;
    skipDrawing = _skip;

    // Create a child, if _numChildren is > 
    if (_numChildren > 0) {
      float newChildDiameter = this.diameter * decay;
      color newChildColor = (int)(c * 1/decay);
      int newNumChildren = _numChildren - 1;
      boolean childskip = childCircles - newNumChildren < 3 ? true : false;
      child = new Circle(newNumChildren, newChildDiameter, newChildColor, childskip);
    }
  }

  void drawAt(float _x, float _y, float _angle) {
    // Draw this circle
    if (true) {
      float alpha = map(firstDiameter - this.diameter,0,firstDiameter,0,100);
      
      fill(c,alpha);
      ellipse(_x, _y, this.diameter, this.diameter);
    }

    // Tell the child to draw itself.
    if (null == child) {
      return;
    } else {
      float childX = _x + cos(radians(_angle))*radius;
      float childY = _y + sin(radians(_angle))*radius;
      child.drawAt(childX, childY, _angle * angleDecay);
    }
  }
}