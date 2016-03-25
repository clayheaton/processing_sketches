int sectors_wide = 12;
int sectors_tall = 8;
int sector_w, sector_h;

ArrayList<Sector> sectors;

void setup() {
  size(900, 600); 
  sector_w = width / sectors_wide;
  sector_h = height / sectors_tall;

  sectors = new ArrayList<Sector>();

  for (int y = 0; y < sectors_tall; y++) {
    for (int x = 0; x < sectors_wide; x++) {
      Sector sec = new Sector(x*sector_w, y*sector_h);
      sectors.add(sec);
    }
  }
  
  noFill();
  strokeWeight(7);
}

void draw() {
  background(255);

  for (Sector s : sectors) {
    s.display();
  }
}

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