class Sector {
  int xCoord, yCoord, w, h;
  PVector corner, center;

  Sector(int _x, int _y, PVector _corner, int _w, int _h) {
    this.xCoord = _x;
    this.yCoord = _y;
    this.corner = _corner;
    w = _w;
    h = _h;
    
    this.center = new PVector(this.corner.x + w/2, this.corner.y + h/2);
  }

  void display() {
    if (debug) {
      debugDisplay();
    }
  }
  
  void rebuild() {
     println("rebuild() not implemented in subclass");
  }

  void debugDisplay() {
    noFill();
    stroke(200);
    rect(this.corner.x, this.corner.y, this.w, this.h);
  }
}

class CockpitSector extends Sector {
  CockpitSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
  }
}

class WingSector extends Sector {
  WingSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
  }
}

class SegmentSector extends Sector {
  SegmentSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
  }
}

class TailSector extends Sector {
  TailSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
  }
}

class ShipSector extends Sector {
  ShipSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
  }
}

class ArmadaSector extends Sector {
  ArmadaSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
  }
}