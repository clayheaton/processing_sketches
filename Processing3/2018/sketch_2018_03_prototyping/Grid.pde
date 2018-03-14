class Grid {
  int sectorsAcross, sectorsDown;
  String sectorType;
  Sector[][] sectors;
  
  Grid(int _nx, int _ny, String _sectorType) {
    this.sectorsAcross = _nx;
    this.sectorsDown = _ny;

    // Parse for establishing proper sectors
    this.sectorType = _sectorType;
    this.sectors = new Sector[this.sectorsAcross][this.sectorsDown];
    makeSectors();
  }
  
  void display() {
    for (int x = 0; x < this.sectorsAcross; x++) {
      for (int y = 0; y < this.sectorsDown; y++) {
        Sector s = sectors[x][y];
        s.display();
      }
    }
  }

  void makeSectors() {
    int sectorW = (int)(width - UI_PANEL_WIDTH - (GRID_OUTER_MARGIN * 2) - (GRID_INNER_MARGIN * (this.sectorsAcross - 1))) / this.sectorsAcross;
    int sectorH = (int)(height - (GRID_OUTER_MARGIN * 2) - (GRID_INNER_MARGIN * (this.sectorsDown - 1))) / sectorsDown;
    
    for (int y = 0; y < sectorsDown; y++) {
      for (int x = 0; x < sectorsAcross; x++) {
        PVector secCorner = new PVector(x*sectorW + GRID_OUTER_MARGIN + (x * GRID_INNER_MARGIN) + UI_PANEL_WIDTH,
                                        y*sectorH + GRID_OUTER_MARGIN + (y * GRID_INNER_MARGIN));
        FlairSector s = new FlairSector(x, y, secCorner, sectorW, sectorH);
        sectors[x][y] = s;
      }
    }
  }
}