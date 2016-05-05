class WorldGrid {
  PVector origin;
  int w, h, cellsAcross, cellsTall;
  int cellWidth, cellHeight;

  WorldCell[][] cells;

  boolean drawGrid = false;

  WorldGrid(int originX, int originY, int _w, int _h, int _cellsAcross, int _cellsTall) {
    printDebug("WorldGrid initialized at (" + originX + ", " + originY + ")");
    printDebug("WorldGrid size: (" + _w + ", " + _h + ")");
    printDebug("WordGrid cell dimensions: (" + _cellsAcross + ", " + _cellsTall + ")");

    origin = new PVector(originX, originY);
    w = _w;
    h = _h;
    cellsAcross = _cellsAcross;
    cellsTall   = _cellsTall;

    // This initializes the grid.
    cells = new WorldCell[cellsTall][cellsAcross];

    for (int y = 0; y < cellsTall; y++) {
      WorldCell[] thisRow = new WorldCell[cellsAcross];

      for (int x = 0; x < cellsAcross; x++) {
        WorldCell wc = new WorldCell(x, y);
        thisRow[x] = wc;
      }
      cells[y] = thisRow;
    }
  }

  void display() {
    if (drawGrid) {
      noFill();
      stroke(200);
      strokeWeight(0.5);
      for (int y = 0; y < cellsTall; y++){
         line(this.origin.x, y*unit_size, this.origin.x + this.w, y*unit_size); 
      }
      for (int x = 0; x < cellsAcross; x++){
         line(x * unit_size, this.origin.y, x * unit_size, this.origin.y + this.h); 
      }
    }
  }
  
  WorldCell cellForPixels(int x, int y){
    int cellX = floor(x / unit_size);
    int cellY = floor(y / unit_size);
    
    return cells[cellY][cellX];
  }
  
  PVector pixelsForCoordOrigin(int x, int y){
    PVector p = new PVector(x*unit_size+origin.x,y*unit_size+origin.y);
    return p;
  }
}

class WorldCell {
  PVector coords;
  PVector pixelPosition;

  WorldCell(int xCoord, int yCoord) {
    coords = new PVector(xCoord, yCoord);
    pixelPosition = new PVector(xCoord*unit_size, yCoord*unit_size);
  }
}