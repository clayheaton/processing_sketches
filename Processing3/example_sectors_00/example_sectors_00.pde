int sectors_wide = 24;
int sectors_tall = 16;
int sector_w, sector_h;


void setup() {
  size(900, 600); 
  sector_w = width / sectors_wide;
  sector_h = height / sectors_tall;

  noStroke();
  fill(150);
}

void draw() {
  background(255);

  // Nested for loops for getting the grid
  for (int x=0; x < sectors_wide; x++) {
    for (int y=0; y < sectors_tall; y++) {
      float half_width = sector_w / 2.0;
      float half_height = sector_h / 2.0;
      
      // Create a PVector to store the point where we'll
      // draw a circle.
      PVector circleCenter = new PVector(x*sector_w + half_width,y*sector_h + half_height);
      
      // Draw the circle.
      ellipse(circleCenter.x,circleCenter.y,30,30);
    }
  }
}