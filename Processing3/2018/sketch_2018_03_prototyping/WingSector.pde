class WingSector extends Sector {
  Wing wing;
  WingSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
    rebuild();
  }

  void rebuild() {
    wing = new Wing();
  }

  void display() {
    if (debug) {
      debugDisplay();
    }

    pushMatrix();
    translate(this.center.x, this.center.y);
    this.wing.display();
    popMatrix();
  }
}
