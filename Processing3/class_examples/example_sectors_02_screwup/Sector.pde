class Sector {

  // Useful to draw a box
  PVector cornerPosition;

  // Useful for drawing circles in the center
  PVector sectorCenter;

  // Useful for communicating with neighbors
  PVector coords;

  // Useful for maintaining "state" 
  boolean visited = false;

  // Store this Sector's active state
  boolean i_am_active = false;

  // Useful for listening to neighbors
  boolean neighbor_active = false;

  // Store neighbor coordinates 
  ArrayList<PVector> neighbors = new ArrayList<PVector>();

  // Store the diameter of the circle we'll draw
  float diameter;



  // This is the constructor
  Sector(int _x, int _y, int _xcoord, int _ycoord) {
    cornerPosition = new PVector(_x, _y);
    coords         = new PVector(_xcoord, _ycoord);

    // Derived from the 
    sectorCenter   = new PVector(_x + sector_w/2, _y + sector_h/2);

    // Calculate a diameter for a circle we'll draw
    diameter = min(sector_w, sector_h) * 0.9;

    // Establish neighbor coordinates
    makeFriendsWithNeighbors();
  }

  void setActiveState() {
    // Is the mouse inside of the ellipse we're going to draw?
    PVector mousePos = new PVector(mouseX, mouseY);

    // Vector from sector center to mouse
    PVector p = PVector.sub(sectorCenter, mousePos);

    // Magnitude of that vector
    float m = p.mag();

    // Absolute value of that magnitude
    m = abs(m);

    if (m < diameter/2) {
      i_am_active = true;
      tellNeighborsImActive(true);
      // println("\n");
      for (PVector ns : neighbors) {
        Sector n = getNeighborAtCoords(ns);
        // println("Sector: " + n.coords + " Active State: " + n.neighbor_active);
      }
    } else {
      i_am_active = false;
      tellNeighborsImActive(false);
    }
  }

  void tellNeighborsImActive(boolean _iAmHighlighted) {
    // Now we access the 2D ArrayList of Sectors
    if (_iAmHighlighted) {
      setNeighborActive(true);
    } else {
      setNeighborActive(false);
    }
  }

  void setNeighborActive(boolean _activeState) {
    for (PVector ns : neighbors) {
      Sector n = getNeighborAtCoords(ns);
      n.neighbor_active = _activeState;
    }
  }

  Sector getNeighborAtCoords(PVector _coords) {
    //println(_coords);
    ArrayList<Sector> theRow = sectors.get((int)_coords.y);
    Sector neighbor = theRow.get((int)_coords.x);
    return neighbor;
  }

  void makeFriendsWithNeighbors() {
    // We'll identify neighbors with a nested loop
    for (int nx = -1; nx <= 1; nx++) {
      for (int ny = -1; ny <= 1; ny++) {
        PVector neighbor = new PVector(coords.x + nx, coords.y + ny);
        if (neighborIsValid(neighbor)) {
          neighbors.add(neighbor);
          // println("Sector: " + this.coords + ", Neighbor: " + neighbor);
        }
      }
    }
  }

  boolean neighborIsValid(PVector _neighbor) {
    if (_neighbor.x >= 0 && _neighbor.x < sectors_wide && _neighbor.y >= 0 && _neighbor.y < sectors_tall) {
      return true;
    } else {
      return false;
    }
  }

  // This is the method for drawing the sector
  // Keep it drawing specific. Move other logic
  // to other methods.
  void display() {

    // Check if it is less than the radius
    if (i_am_active) {
      fill(255, 0, 0);
    } else if (neighbor_active) {
      fill(#45ACEA);
    } else {
      fill(220);
    }

    ellipse(sectorCenter.x, sectorCenter.y, diameter, diameter);
  }
}