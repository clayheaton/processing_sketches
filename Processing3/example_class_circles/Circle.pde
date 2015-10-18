class Circle {
  float x, y;
  boolean dynamic;
  boolean overlapping = false;
  PVector p;
  int diameter = 40;

  Circle() {
    this.x = width/2;
    this.y = height/2;
    this.dynamic = false;
    setVector();
  }

  /* Appears at the specified x and y coords. */
  Circle(float _x, float _y) {
    this.x = _x;
    this.y = _y;
    this.dynamic = false;
    setVector();
  }

  /* Dynamic circles are blue and follow the mouse. */
  Circle(boolean _dynamic) {
    this.x = mouseX;
    this.y = mouseY;
    this.dynamic = true;
    setVector();
  }

  void setVector() {
    p = new PVector(this.x, this.y);
  }

  void display() {
    noStroke();
    fill(255, 0, 0);

    if (dynamic) {
      if(overlapping){
       fill(0,255,0); 
      } else {
       fill(0,0,255); 
      }
      ellipse(mouseX, mouseY, diameter, diameter);
    } else {
      ellipse(this.x, this.y, diameter, diameter);
    }
  }

  void update() {
    if (dynamic) {
      this.x = mouseX;
      this.y = mouseY;
      this.p.x = this.x;
      this.p.y = this.y;

      // println(x + ", " + y);

      for (Circle c : circles) {
        if (c == this) {
          continue;
        } else {
          PVector v3 = PVector.sub(p, c.p);
          float m = mag(v3.x, v3.y);

          if (m < this.diameter) {
            overlapping = true;
            break;
          } else {
            overlapping = false;
          }
        }
      }
    }
  }
}