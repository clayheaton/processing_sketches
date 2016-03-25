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
   DISPLAY METHODS
   ===============================================
   */

  void display() {
    // rot.displayAt(this.center.x, this.center.y);
    circle.drawAt(this.center.x,this.center.y,childAngle);
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