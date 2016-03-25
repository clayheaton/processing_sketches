boolean debug  = false;

PFont debugFont;

int gridAcross = 3;
int gridDown   = 1;

int theMargin  = 50;

boolean pause;

Grid grid;

void setup() {
  size(800, 400);

  // Set up fonts
  debugFont = createFont("Consolas", 10);

  // Establish the grid
  grid = new Grid(gridDown, gridAcross, theMargin);

  background(0);
  strokeCap(SQUARE);
  
  pause = false;
}

void draw() {
  background(0);
  grid.display();
  
  if(pause){
   noLoop(); 
  }
}

void mouseClicked(){
  pause = !pause;
  loop();
}