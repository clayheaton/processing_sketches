// Each sector will have a uniform w and h

class Sector {
  PVector corner, center;
  // Rotator rot;
  Circle circle;

  // We'll have a different x and y for our
  // grid of sectors
  int xCoord, yCoord, w, h;

  Sector(int _x, int _y, PVector _corner, int _w, int _h) {
    this.xCoord = _x;
    this.yCoord = _y;
    this.corner = _corner;
    this.w      = _w;
    this.h      = _h;

    this.center = new PVector(this.corner.x + this.w/2.0, this.corner.y + this.h/2.0);
    
    // makeRotator(false);
    color c = color(random(255),random(255),random(255));
    
    int nCircles = (int)random(3,12);
    int diam     = (int)random(10,40);
    circle = new Circle(nCircles,diam,c,true);
  }

  /* 
   ===============================================
   SETUP METHODS
   ===============================================
   */

  /*
  void makeRotator(boolean _useNoise) {

    int numCircles, innerDiam, strkWght;

    if (_useNoise) {
      float d = 0.05;
      float n = noise(this.xCoord * d, this.yCoord * d);

      numCircles = int(4 + (n*6)); // (int)random(4,10)
      innerDiam  = int(4 + (n*6)); // (int)random(4,10)
      strkWght   = int(4 + (n*4)); // (int)random(4,8)
    } else {
      numCircles = (int)random(4, 12);
      innerDiam  = (int)random(4, 10);
      strkWght   = (int)random(4, 8);
    }
    
    
    this.rot = new Rotator(numCircles, innerDiam, strkWght, false, true);
  }
  */

  /* 
   ===============================================
   DISPLAY METHODS
   ===============================================
   */

  void display() {
    // rot.displayAt(this.center.x, this.center.y);
    circle.drawAt(this.center.x,this.center.y,childAngle);
    if (debug) {
      debugDisplay();
    }
  }

  /* 
   ===============================================
   DEBUG METHODS
   ===============================================
   */

  void debugDisplay() {
    noFill();
    stroke(150);
    strokeWeight(1);
    rect(this.corner.x, this.corner.y, this.w, this.h);
    noStroke();
    fill(0);
    textFont(debugFont);
    text(this.coords(), this.corner.x + 2, this.corner.y + 10);
  }

  String coords() {
    return "(" + this.xCoord + ", " + this.yCoord + ")";
  }

  String cornerPosition() {
    return "(" + this.corner.x + ", " + this.corner.y + ")";
  }
}