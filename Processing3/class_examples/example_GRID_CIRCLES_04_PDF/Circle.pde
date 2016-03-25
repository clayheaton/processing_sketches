class Circle {
  Circle child  = null;

  int numChildren;
  float diameter, radius;

  color c;

  boolean skipDrawing;
  float decay, angleDecay;

  Circle(int _numChildren, float _diameter, color _c, boolean _skip) {
    numChildren = _numChildren;
    diameter    = _diameter;
    radius      = diameter / 2;
    c = _c;
    skipDrawing = _skip;
    this.decay = random(0.6,0.9);
    this.angleDecay = random(1.3,2.5); // 0.8 - 1.1

    // Create a child, if _numChildren is > 
    if (_numChildren > 0) {
      float newChildDiameter = this.diameter * this.decay;
      color newChildColor = (int)(c * 1/this.decay);
      int newNumChildren = _numChildren - 1;
      boolean childskip = childCircles - newNumChildren < 2 ? true : false;
      child = new Circle(newNumChildren, newChildDiameter, newChildColor, childskip);
    }
  }

  void drawAt(float _x, float _y, float _angle) {
    // Draw this circle
    if (!skipDrawing && numChildren % 2 > 0) {
      PVector circleCenter = new PVector(_x,_y);
      PVector canvasCenter = new PVector(width/2,height/2);
      
      PVector dist = PVector.sub(circleCenter,canvasCenter);
      float   mag  = dist.mag();
      // float alpha = map(mag,0,width*1.5,0,100);
      
      fill(c,10);
      ellipse(_x, _y, this.diameter, this.diameter);
    }

    // Tell the child to draw itself.
    if (null == child) {
      return;
    } else {
      float childX = _x + cos(radians(_angle))*radius;
      float childY = _y + sin(radians(_angle))*radius;
      child.drawAt(childX, childY, _angle * this.angleDecay);
    }
  }
}