class Sector {
  PVector cornerPosition;
  PVector sectorCenter;
  
  boolean visited = false;

  Sector(int _x, int _y) {
    cornerPosition = new PVector(_x, _y);
    sectorCenter   = new PVector(_x + sector_w/2, _y + sector_h/2);
  }

  void display() {
    float diameter = min(sector_w, sector_h) * 0.9;

    // Is the mouse inside of the ellipse we're going to draw?
    PVector mousePos = new PVector(mouseX,mouseY);
    
    // Vector from sector center to mouse
    PVector p = PVector.sub(sectorCenter,mousePos);
    
    // Magnitude of that vector
    float m = p.mag();
    
    // Absolute value of that magnitude
    m = abs(m);
    
    // Check if it is less than the radius
    if (m < diameter/2 || visited == true){
     fill(255,0,0); 
     diameter *= 1.1;
     //visited = true;
    } else {
     fill(220); 
    }

    ellipse(sectorCenter.x, sectorCenter.y, diameter, diameter);
  }
}