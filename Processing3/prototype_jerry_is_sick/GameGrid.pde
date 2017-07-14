class GameGrid {
  int w, h, dim;
  Sector[][] sectors;

  GameGrid(int gridWidth, int gridHeight, int gridSize) {
    this.w = gridWidth;
    this.h = gridHeight;
    this.dim = gridSize;

    this.sectors = new Sector[this.w][this.h];
    establishSectors();
  }

  void establishSectors() {
    for (int i = 0; i < this.w; i++) {
      for (int j = 0; j < this.h; j++) {
        PVector p = new PVector(i*this.dim, j*this.dim);
        sectors[j][i] = new Sector(i, j, p, dim, dim);
      }
    }
  }

  void display() {
    for (int i = 0; i < this.w; i++) {
      for (int j = 0; j < this.h; j++) {
        sectors[j][i].display();
      }
    }
  }
}