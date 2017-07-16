class GameGrid {
  int w, h, dim;
  Sector[][] sectors;
  PVector selectedSector;

  GameGrid(int gridWidth, int gridHeight, int gridSize) {
    this.w = gridWidth;
    this.h = gridHeight;
    this.dim = gridSize;

    this.sectors = new Sector[this.w][this.h];
    establishSectors();
  }
  
  void advanceTurn(){
    println("GameGrid advanceTurn()");
    for (int i = 0; i < this.w; i++) {
      for (int j = 0; j < this.h; j++) {
        sectors[j][i].advanceTurn();
      }
    }
  }

  void establishSectors() {
    // Initialize the PVector we use to choose which sector is selected
    this.selectedSector = new PVector(-1,-1);
    
    for (int i = 0; i < this.w; i++) {
      for (int j = 0; j < this.h; j++) {
        PVector p = new PVector(i*this.dim, j*this.dim);
        sectors[j][i] = new Sector(i, j, p, dim, dim);
      }
    }
    
    // Choose an initial sick person
    int randX = int(random(this.w));
    int randY = int(random(this.h));
    
    // Set the person as sick
    Sector s = sectors[randY][randX];
    s.setState(STATE_CONTAGIOUS);
  }
  
  void selectSector(){
    for (int i = 0; i < this.w; i++) {
      for (int j = 0; j < this.h; j++) {
        sectors[j][i].selectCheck();
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