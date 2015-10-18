boolean debug  = true;

PFont debugFont;

int gridAcross = 8;
int gridDown   = 5;

int theMargin  = 50;

boolean pause;

Grid grid;

void setup() {
  size(800, 600);
  pixelDensity(2);
  // Set up fonts
  debugFont = createFont("Consolas", 10);

  // Establish the grid
  grid = new Grid(gridDown, gridAcross, theMargin);

  background(255);
  strokeCap(SQUARE);
  
  pause = false;
}

void draw() {
  background(255);
  grid.display();
  
  if(pause){
   noLoop(); 
  }
}

void mouseClicked(){
  pause = !pause;
  loop();
}