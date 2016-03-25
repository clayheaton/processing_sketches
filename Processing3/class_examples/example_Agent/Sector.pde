// Each sector will have a uniform w and h

class Sector {
  PVector corner, center;

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
  }

  /* 
   ===============================================
   DISPLAY METHODS
   ===============================================
   */

  void display() {
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
    rect(this.corner.x, this.corner.y, this.w, this.h);
    noStroke();

    if (debugText) {
      fill(0);
      textFont(debugFont);
      text(this.coords(), this.corner.x + 2, this.corner.y + 10);
    }
  }

  String coords() {
    return "(" + this.xCoord + ", " + this.yCoord + ")";
  }

  String cornerPosition() {
    return "(" + this.corner.x + ", " + this.corner.y + ")";
  }
}