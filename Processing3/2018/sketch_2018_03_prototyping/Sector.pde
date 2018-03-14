class Sector {
  int xCoord, yCoord, w, h;
  PVector corner, center;
  Sector(int _x, int _y, PVector _corner, int _w, int _h) {
    this.xCoord = _x;
    this.yCoord = _y;
    this.corner = _corner;
    w = _w;
    h = _h;
  }

  void display() {
    if (debug) {
      noFill();
      stroke(200);
      rect(this.corner.x, this.corner.y, this.w, this.h);
    }
  }
}

// Reads and draws flair components
class FlairSector extends Sector {
  FlairSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
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