class Sector {
  PVector cornerPosition;
  PVector sectorCenter;

  Sector(int _x, int _y) {
    cornerPosition  = new PVector(_x, _y);
    sectorCenter    = new PVector(_x + sector_w/2, _y + sector_h/2);

  }

  void display() {

    PVector mousePosition = new PVector(mouseX,mouseY);
    PVector lineEnd = PVector.lerp(sectorCenter,mousePosition,0.4);
    line(sectorCenter.x,sectorCenter.y,lineEnd.x,lineEnd.y);
    
  }

}