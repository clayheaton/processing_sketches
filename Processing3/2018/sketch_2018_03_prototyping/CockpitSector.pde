class CockpitSector extends Sector {
  Cockpit cockpit;
  CockpitSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
    rebuild();
  }

  void rebuild() {
    cockpit = new Cockpit();
  }

  void display() {
    if (debug) {
      debugDisplay();
    }

    pushMatrix();
    translate(this.center.x, this.center.y);
    this.cockpit.display();
    popMatrix();
  }
}
