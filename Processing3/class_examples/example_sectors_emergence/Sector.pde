class Sector {
  PVector cornerPosition;
  PVector sectorCenter;
  
  color c;

  Sector(int _x, int _y) {
    cornerPosition  = new PVector(_x, _y);
    sectorCenter    = new PVector(_x + sector_w/2, _y + sector_h/2);
    c = randomColor();
  }

  void display() {
    stroke(c);

    PVector mousePosition = new PVector(mouseX,mouseY);
    PVector lineEnd = PVector.lerp(sectorCenter,mousePosition,0.4);
    lineEnd.setMag(500);
    line(sectorCenter.x,sectorCenter.y,lineEnd.x,lineEnd.y);
    
  }
  
  color randomColor() {
    return color(random(255), random(255), random(255));
  }

}