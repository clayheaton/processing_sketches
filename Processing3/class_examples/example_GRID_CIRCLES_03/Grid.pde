// Class to hold a grid of sectors
class Grid {
  int sectorsDown, sectorsAcross;
  int marginOuter, marginInner;

  // Declare a 2D array of Sectors
  Sector[][] sectors;

  Grid(int _sectorsDown, int _sectorsAcross, int _outerMargin, int _innerMargin) {
    this.sectorsDown   = _sectorsDown;
    this.sectorsAcross = _sectorsAcross;
    this.marginOuter   = _outerMargin;
    this.marginInner   = _innerMargin;

    // Initialize the storage of sectors
    sectors = new Sector[this.sectorsAcross][this.sectorsDown];

    // Adjust the window size to make even Sectors
    resizeWindow();

    // Establish Sectors
    makeSectors();
  }

  /* 
   ===============================================
   DATA ACCESS METHODS
   ===============================================
   */

  Sector sectorAt(int _x, int _y) {
    return sectors[_x][_y];
  }

  /* 
   ===============================================
   DISPLAY METHODS
   ===============================================
   */

  void display() {
    for (int x = 0; x < this.sectorsAcross; x++) {
      for (int y = 0; y < this.sectorsDown; y++) {
        Sector s = sectors[x][y];
        s.display();
      }
    }
  }

  void debugDisplay() {
    for (int x = 0; x < this.sectorsAcross; x++) {
      for (int y = 0; y < this.sectorsDown; y++) {
        Sector s = sectors[x][y];
        s.debugDisplay();
      }
    }
  }
  /* 
   ===============================================
   SETUP METHODS
   ===============================================
   */

  /* This resizes the canvas to make the sectors equal size */
  void resizeWindow() {
    float currentW = (float)width;
    float currentH = (float)height;
    float newW = currentW;
    float newH = currentH;

    // Figure out what the new W and H should be
    while (newW % this.sectorsAcross > 0) {
      newW += 1;
    }
    while (newH % this.sectorsDown > 0) {
      newH += 1;
    }

    // Adjust the canvas W and H if necessary
    if (newH != currentH || newW != currentW) {
      surface.setSize((int)newW, (int)newH);
    }
    // println("width: " + width + ", height: " + height);
  }

  /* This creates the sectors and stores them in sectors[][] */
  void makeSectors() {
    int sectorW = (int)(width - (this.marginOuter * 2)  - (this.marginInner * (sectorsAcross - 1))) / sectorsAcross;
    int sectorH = (int)(height - (this.marginOuter * 2) - (this.marginInner * (sectorsDown - 1))) / sectorsDown;

    for (int y = 0; y < sectorsDown; y++) {
      for (int x = 0; x < sectorsAcross; x++) {
        PVector secCorner = new PVector(x*sectorW + this.marginOuter + (x * this.marginInner), y*sectorH + this.marginOuter + (y * this.marginInner));
        Sector s = new Sector(x, y, secCorner, sectorW, sectorH);
        sectors[x][y] = s;
      }
    }
    if (debug) {
      for (int y = 0; y < sectorsDown; y++) {
        for (int x = 0; x < sectorsAcross; x++) {
          Sector s = sectors[x][y];
          println("Sector " + s.coords() + ": " + s.cornerPosition());
        }
      }
    }
  }
}