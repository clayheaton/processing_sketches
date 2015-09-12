int sectors_wide = 24;
int sectors_tall = 16;
int sector_w, sector_h;

// Now we will work with 2-dimensional arrays
ArrayList<ArrayList<Sector>> sectors;

void setup() {
  size(900, 600); 
  sector_w = width / sectors_wide;
  sector_h = height / sectors_tall;

  // The 'outer' ArrayList will store an 
  // ArrayList for each row of Sectors
  // Initialize the outer list.
  sectors = new ArrayList<ArrayList<Sector>>();

  // Now add an ArrayList to the outer list for each 
  // row. Structure is like:

  // ArrayList< ArrayList<Sector>,
  //            ArrayList<Sector>,
  //            ...                >

  for (int r = 0; r < sectors_tall; r++) {
    ArrayList<Sector> this_row = new ArrayList<Sector>();
    sectors.add(this_row);
  }

  // Now, create the Sector objects and add them to the proper row
  for (int y = 0; y < sectors_tall; y++) {
    for (int x = 0; x < sectors_wide; x++) {
      Sector sec = new Sector(x*sector_w, y*sector_h, x, y);
      ArrayList<Sector> proper_row = sectors.get(y);
      proper_row.add(sec);
    }
  }

  noStroke();
  fill(150);
}

void draw() {
  background(255);

  // Now we need a nested loop to draw
  for (ArrayList<Sector> a_row_of_sectors : sectors) {
    for (Sector s : a_row_of_sectors) {
      s.display();
    }
  }
}