int screen_width      = 5760;
int screen_height     = 2304;
float run_factor      = 0.2;
int width_functional  = int(screen_width * run_factor);
int height_functional = int(screen_height * run_factor);

int squares_wide      = 15;
int squares_tall      = 8;

float square_pixels_wide = float(width_functional) / squares_wide;
float square_pixels_tall = float(height_functional) / squares_tall;

ArrayList<ArrayList<Cube>> cubes;

ColorObj black = new ColorObj(color(#000000));

void setup() {
  // Full size: 5760 x 2304
  // 0.2 size:  1152 x 460
  size(1152, 460, P3D);
  stroke(255);
  strokeWeight(1);
  smooth();
  ortho();

  cubes = new ArrayList<ArrayList<Cube>>();

  float half_width  = square_pixels_wide * 0.5;
  float half_height = square_pixels_tall * 0.5;

  ColorObj initColor = new ColorObj(color(#000000));

  for (int i = 0; i < squares_tall; i++) {
    ArrayList<Cube> row = new ArrayList<Cube>();
    cubes.add(row);
    for (int j = 0; j < squares_wide; j++) {
      float x = j * square_pixels_wide + half_width;
      float y = i * square_pixels_tall + half_height;
      ColorObj co = new ColorObj(randomColor());

      Cube c = new Cube(x, y, square_pixels_wide, square_pixels_tall, square_pixels_tall, co);
      row.add(c);
    }
  }
}


void draw() {
  background(0);

  for (ArrayList<Cube> a : cubes) {
    for (Cube c : a) {
      c.display();
    }
  }
  
}

color randomColor() {
  int r = int(random(255));
  int g = int(random(255));
  int b = int(random(255));
  return color(r, g, b);
}

void drawGrid() {
  stroke(255);
  for (int i = 1; i < squares_wide; i++) {
    line(i*square_pixels_wide, 0, i*square_pixels_wide, height);
  }
  for (int j = 0; j < squares_tall; j++) {
    line(0, j*square_pixels_tall, width, j*square_pixels_tall);
  }
}

// For debugging
PVector gridPosFromClick(){
  int row = int(mouseY / square_pixels_tall);
  int col = int(mouseX / square_pixels_wide);
  return new PVector(row,col);
}

void mouseClicked(){
  PVector pos = gridPosFromClick();
  ArrayList<Cube> a = cubes.get(int(pos.x));
  Cube c = a.get(int(pos.y));
  c.currentColor = black;
}




/* Comment out this method if you don't want full screen */
/*
boolean sketchFullScreen() {
 return true;
 }
 */
