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
  
  noStroke();
  fill(150);
}

void draw() {
  background(255);

  for (Sector s : sectors) {
    s.display();
  }
}